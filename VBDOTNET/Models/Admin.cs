
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
using Designly.Models.Concerns;

namespace Designly.Models;


[Table("admin")]
public class Admin : AuthAccount
{
    
    [Key]
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

    public override int GetKey() => AdminId;

    
    [NotMapped]
    public string FirstName => FullName.Trim().Split(' ')[0];

    
    [NotMapped]
    public string AccountStatus => "Active";
}
