
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;

[Table("order_item")]
public class OrderItem : SqlServerModel
{
    
    [Key]
    [Column("order_item_id")]
    public int OrderItemId { get; set; }

    [Column("order_id")]
    public int OrderId { get; set; }

    [Column("product_id")]
    public int ProductId { get; set; }

    
    [Column("quantity")]
    public int Quantity { get; set; }

    
    [Column("unit_price", TypeName = "decimal(9,2)")]
    public decimal UnitPrice { get; set; }

    [Column("selected_color")]
    [MaxLength(7)]
    public string SelectedColor { get; set; } = "";

    
    [Column("subtotal", TypeName = "decimal(10,2)")]
    public decimal Subtotal { get; set; }

    
    public Order? Order { get; set; }

    
    public Product? Product { get; set; }
}
