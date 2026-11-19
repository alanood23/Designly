
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;
using Designly.Support.Helpers;

namespace Designly.Models;

[Table("room_design")]
public class RoomDesign : SqlServerModel
{
    
    [Key]
    [Column("design_id")]
    public int DesignId { get; set; }

    [Column("customer_id")]
    public int CustomerId { get; set; }

    [Column("design_name")]
    [MaxLength(80)]
    public string DesignName { get; set; } = "";

    [Column("room_type")]
    [MaxLength(15)]
    public string RoomType { get; set; } = "";

    
    [Column("room_width", TypeName = "decimal(4,2)")]
    public decimal RoomWidth { get; set; }

    [Column("room_length", TypeName = "decimal(4,2)")]
    public decimal RoomLength { get; set; }

    [Column("room_height", TypeName = "decimal(4,2)")]
    public decimal RoomHeight { get; set; }

    
    [Column("is_public")]
    public bool IsPublic { get; set; }

    
    [Column("share_link")]
    [MaxLength(40)]
    public string? ShareLink { get; set; }

    
    [Column("preview_image")]
    [MaxLength(500)]
    public string? PreviewImage { get; set; }

    
    [Column("created_at")]
    public DateTime CreatedAt { get; set; }

    [Column("updated_at")]
    public DateTime UpdatedAt { get; set; }

    
    public Customer? Customer { get; set; }

    
    public List<DesignItem> Items { get; set; } = new();

    
    [NotMapped]
    public int? ItemsSumQuantity { get; set; }

    
    public int ItemCount()
    {
        if (ItemsSumQuantity.HasValue)
        {
            return ItemsSumQuantity.Value;
        }
        return Items.Sum(i => i.Quantity);
    }

    
    public string DimsLabel()
    {
        return Helpers.DlM(RoomWidth) + " × " + Helpers.DlM(RoomLength) + " m";
    }
}
