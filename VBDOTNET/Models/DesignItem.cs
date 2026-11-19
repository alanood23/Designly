
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;

[Table("design_item")]
public class DesignItem : SqlServerModel
{
    
    [Key]
    [Column("design_item_id")]
    public int DesignItemId { get; set; }

    [Column("design_id")]
    public int DesignId { get; set; }

    [Column("product_id")]
    public int ProductId { get; set; }

    
    [Column("position_x", TypeName = "decimal(5,2)")]
    public decimal PositionX { get; set; }

    [Column("position_y", TypeName = "decimal(5,2)")]
    public decimal PositionY { get; set; }

    [Column("rotation_angle")]
    public int RotationAngle { get; set; }

    [Column("selected_color")]
    [MaxLength(7)]
    public string SelectedColor { get; set; } = "";

    [Column("quantity")]
    public int Quantity { get; set; } = 1;

    [Column("position_z", TypeName = "decimal(5,2)")]
    public decimal PositionZ { get; set; }

    
    public RoomDesign? Design { get; set; }

    
    public Product? Product { get; set; }
}
