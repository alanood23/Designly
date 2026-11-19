
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;
using Designly.Support.Helpers;

namespace Designly.Models;

[Table("product")]
public class Product : SqlServerModel
{
    
    [Key]
    [Column("product_id")]
    public int ProductId { get; set; }

    [Column("store_id")]
    public int StoreId { get; set; }

    [Column("product_name")]
    [MaxLength(100)]
    public string ProductName { get; set; } = "";

    
    [Column("product_type")]
    [MaxLength(10)]
    public string ProductType { get; set; } = "";

    [Column("category")]
    [MaxLength(30)]
    public string Category { get; set; } = "";

    
    [Column("price", TypeName = "decimal(9,2)")]
    public decimal Price { get; set; }

    
    [Column("discount_percent")]
    public int DiscountPercent { get; set; }

    
    [Column("warranty_months")]
    public int WarrantyMonths { get; set; }

    
    [Column("available_colors")]
    [MaxLength(120)]
    public string AvailableColors { get; set; } = "";

    [Column("width_cm")]
    public int WidthCm { get; set; }

    
    [Column("length_cm")]
    public int LengthCm { get; set; }

    [Column("height_cm")]
    public int HeightCm { get; set; }

    [Column("specifications")]
    [MaxLength(500)]
    public string? Specifications { get; set; }

    [Column("stock_qty")]
    public int StockQty { get; set; }

    
    [Column("image_url")]
    [MaxLength(500)]
    public string ImageUrl { get; set; } = "";

    [Column("description")]
    [MaxLength(1000)]
    public string? Description { get; set; }

    
    public Store? Store { get; set; }

    
    public List<OrderItem> OrderItems { get; set; } = new();

    
    public List<DesignItem> DesignItems { get; set; } = new();

    
    public List<SavedProduct> SavedRows { get; set; } = new();

    
    public static IQueryable<Product> ScopeAvailable(IQueryable<Product> q)
    {
        return q.Where(p => p.Store != null && p.Store.StoreStatus == "Active");
    }

    public List<string> ColorList()
    {
        return (AvailableColors ?? "").Split(',').Select(c => c.Trim()).Where(c => c != "").ToList();
    }

    
    public decimal UnitPrice()
    {
        return Helpers.Round(Price * (100 - DiscountPercent) / 100m);
    }

    public bool IsOrderable()
    {
        return Store != null && Store.IsActive() && StockQty > 0;
    }

    
    public string ShortName()
    {
        var w = ProductName.Split(' ');
        return w.Length > 2 ? w[0] + " " + w[^1] : ProductName;
    }

    
    public Dictionary<string, object?> EditorData()
    {
        return new Dictionary<string, object?>
        {
            ["id"] = ProductId,
            ["name"] = ProductName,
            ["store"] = Store?.StoreName,
            ["price"] = UnitPrice(),
            ["image"] = Helpers.DlImg(ImageUrl),
            ["category"] = Category,
            ["w"] = WidthCm / 100.0,
            ["l"] = LengthCm / 100.0,
            ["h"] = HeightCm / 100.0,
            ["colors"] = ColorList(),
            ["specs"] = (Specifications ?? "").ToLowerInvariant(),
        };
    }
}
