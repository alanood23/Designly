

using System.Globalization;
using Designly.Data;
using Designly.Support.Config;
using Designly.Support.Console;
using Designly.Support.Console.Commands;
using Designly.Support.Exceptions;
using Designly.Support.Helpers;
using Designly.Support.Http;
using Designly.Support.Mail;
using Designly.Support.Middleware;
using Designly.Support.Providers;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding.Metadata;
using Microsoft.AspNetCore.Routing.Constraints;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);
var config = builder.Configuration;


DesignlyConfig.Load(config);                                                       
Helpers.TimeZone = TimeZoneInfo.FindSystemTimeZoneById(config["App:Timezone"] ?? "Asia/Riyadh"); 
var culture = new CultureInfo(config["App:Locale"] ?? "en-US");                    
CultureInfo.DefaultThreadCurrentCulture = culture;
CultureInfo.DefaultThreadCurrentUICulture = culture;


builder.Services.AddControllersWithViews(o =>
    {
        
        o.Filters.Add<Handler>();
        
        o.Filters.Add<FormRequestValidationFilter>();
        
        o.Filters.Add(new AutoValidateAntiforgeryTokenAttribute());
        
    })
    .AddMvcOptions(o => o.ModelMetadataDetailsProviders.Add(new SystemTextJsonValidationMetadataProvider()))
    .AddRazorOptions(o =>
    {
        
        o.ViewLocationFormats.Add("/Views/Shared/{0}.cshtml");
    });

builder.Services.AddAntiforgery(VerifyCsrfToken.Configure);
builder.Services.AddHttpContextAccessor();
builder.Services.AddMemoryCache();                     
builder.Services.AddDistributedMemoryCache();          
builder.Services.AddSession(o =>
{
    
    o.IdleTimeout = TimeSpan.FromMinutes(config.GetValue("Session:Lifetime", 120));
    o.Cookie.Name = config["Session:Cookie"] ?? "designly_session";
    o.Cookie.HttpOnly = true;
    o.Cookie.SameSite = SameSiteMode.Lax;
    o.Cookie.Path = "/";
    o.Cookie.IsEssential = true;
});
builder.Services.AddCors(o => o.AddDefaultPolicy(p => p.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader())); 
builder.Services.Configure<Microsoft.AspNetCore.Http.Features.FormOptions>(o => o.MultipartBodyLengthLimit = 8 * 1024 * 1024); 


builder.Services.AddDbContext<AppDbContext>(o => o.UseSqlServer(config.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<DbSeeder>();               

builder.Services.AddScoped<Mailer>();                 


AppServiceProvider.Register(builder.Services);        
AuthServiceProvider.Boot(builder.Services, config);   

EventServiceProvider.Boot();                          
RouteServiceProvider.Boot(builder.Services);          
Kernel.Commands(builder.Services);                    

var app = builder.Build();



if (args.Length > 0 && args[0] == "inspire")
{
    Console.WriteLine(ConsoleRoutes.Inspire());        
    return;
}
if (args.Length > 0 && args[0] == CancelStalePendingOrders.Signature)
{
    using var scope = app.Services.CreateScope();
    Environment.ExitCode = scope.ServiceProvider.GetRequiredService<CancelStalePendingOrders>().Handle();
    return;
}

AppServiceProvider.Boot();                            


if (!app.Environment.IsDevelopment())
{
    
    
    app.UseExceptionHandler(e => e.Run(async ctx =>
    {
        ctx.Response.StatusCode = StatusCodes.Status500InternalServerError;
        ctx.Response.ContentType = "text/html; charset=utf-8";
        await ctx.Response.WriteAsync("<!doctype html><title>Server Error</title><p style=\"font-family:sans-serif;text-align:center;margin-top:20vh\">500 | Server Error</p>");
    }));
    app.UseHsts();
}
else
{
    app.UseDeveloperExceptionPage();
}

app.UseRequestLocalization(new RequestLocalizationOptions
{
    DefaultRequestCulture = new RequestCulture(culture),
    SupportedCultures = new[] { culture },
    SupportedUICultures = new[] { culture },
});
app.UseHttpMethodOverride(new HttpMethodOverrideOptions { FormFieldName = "_method" }); 
Kernel.UseGlobalMiddleware(app);                     
app.UseStaticFiles();                                 
app.UseRouting();
app.UseRateLimiter();                                 
Kernel.UseWebGroup(app);                              













var guards = new (string Guard, string Prefix, string N)[] { ("web", "", ""), ("store", "/store", "store."), ("admin", "/admin", "admin.") };
foreach (var (guard, prefix, n) in guards)
{
    var p = prefix.TrimStart('/');
    var slash = p == "" ? "" : p + "/";
    var get = new { httpMethod = new HttpMethodRouteConstraint("GET") };
    var post = new { httpMethod = new HttpMethodRouteConstraint("POST") };

    app.MapControllerRoute(name: n + "login", pattern: slash + "login",
        defaults: new { controller = "Login", action = "Show", guard }, constraints: get);
    app.MapControllerRoute(name: guard + ".login.post", pattern: slash + "login",
        defaults: new { controller = "Login", action = "Login", guard }, constraints: post);
    app.MapControllerRoute(name: n + "password.request", pattern: slash + "forgot-password",
        defaults: new { controller = "PasswordReset", action = "Show", guard }, constraints: get);
    app.MapControllerRoute(name: n + "password.email", pattern: slash + "forgot-password",
        defaults: new { controller = "PasswordReset", action = "Send", guard }, constraints: post);
    
    app.MapControllerRoute(name: n + "logout", pattern: slash + "logout",
        defaults: new { controller = "Login", action = "Logout", guard }, constraints: post)
        .RequireAuthorization(guard);
}

app.MapControllers();                                 



BroadcastServiceProvider.Boot(app);

app.Run();


public partial class Program { }
