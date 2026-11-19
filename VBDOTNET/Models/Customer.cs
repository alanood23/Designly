
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
using Designly.Models.Concerns;

namespace Designly.Models;


[Table("customer")]
public class Customer : AuthAccount
{
    
    [Key]
    [Column("customer_id")]
    public int CustomerId { get; set; }

    [Column("admin_id")]
    public int AdminId { get; set; }

    [Column("first_name")]
    [MaxLength(50)]
    public string FirstName { get; set; } = "";

    [Column("last_name")]
    [MaxLength(50)]
    public string LastName { get; set; } = "";

    [Column("email")]
    [MaxLength(150)]
    public string Email { get; set; } = "";

    
    [JsonIgnore]
    [Column("password_hash")]
    [MaxLength(255)]
    public override string PasswordHash { get; set; } = "";

    [Column("phone")]
    [MaxLength(16)]
    public string Phone { get; set; } = "";

    [Column("city")]
    [MaxLength(50)]
    public string? City { get; set; }

    [Column("account_status")]
    [MaxLength(10)]
    public string AccountStatus { get; set; } = "Active";

    
    [Column("created_at")]
    public DateTime CreatedAt { get; set; }

    public override int GetKey() => CustomerId;

    
    public List<RoomDesign> Designs { get; set; } = new();

    
    public List<Order> Orders { get; set; } = new();

    
    public List<SavedProduct> SavedProducts { get; set; } = new();

    
    public List<CreditCard> Cards { get; set; } = new();

    
    public List<StoreReview> Reviews { get; set; } = new();

    
    [NotMapped]
    public int? OrdersCount { get; set; }

    
    [NotMapped]
    public string FullName => (FirstName + " " + LastName).Trim();

    
    [NotMapped]
    public string ShortName => FirstName + " " + (LastName ?? "").Substring(0, Math.Min(1, (LastName ?? "").Length)) + ".";
}
