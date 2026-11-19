
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
using Designly.Models.Concerns;

namespace Designly.Models;


[Table("store_admin")]
public class StoreAdmin : AuthAccount
{
    
    [Key]
    [Column("STadmin_id")]
    public int StAdminId { get; set; }

    
    [Column("admin_id")]
    public int AdminId { get; set; }

    [Column("full_name")]
    [MaxLength(100)]
    public string FullName { get; set; } = "";

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

    
    [Column("created_at")]
    public DateTime CreatedAt { get; set; }

    [Column("account_status")]
    [MaxLength(10)]
    public string AccountStatus { get; set; } = "Pending";

    public override int GetKey() => StAdminId;

    
    public List<Store> Stores { get; set; } = new();

    
    
    
    
    [NotMapped]
    public Store? Store => Stores.OrderBy(s => s.StoreId).FirstOrDefault();

    
    [NotMapped]
    public string FirstName => FullName.Trim().Split(' ')[0];
}
