
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;


[Table("orders")]
public class Order : SqlServerModel
{
    public static readonly string[] OPEN = { "Pending Payment", "Placed", "Processing", "Shipped" };
    public static readonly string[] ACTIVE = { "Placed", "Processing", "Shipped" };
    public static readonly string[] CANCELLABLE = { "Pending Payment", "Placed", "Processing" };
    public static readonly string[] FLOW = { "Placed", "Processing", "Shipped", "Delivered" };
    public static readonly string[] STATUSES = { "Pending Payment", "Placed", "Processing", "Shipped", "Delivered", "Cancelled" };

    
    [Key]
    [Column("order_id")]
    public int OrderId { get; set; }

    [Column("customer_id")]
    public int CustomerId { get; set; }

    
    [Column("order_date")]
    public DateTime OrderDate { get; set; }

    
    [Column("order_total_amount", TypeName = "decimal(10,2)")]
    public decimal OrderTotalAmount { get; set; }

    
    [Column("commission_amount", TypeName = "decimal(10,2)")]
    public decimal CommissionAmount { get; set; }

    [Column("order_status")]
    [MaxLength(16)]
    public string OrderStatus { get; set; } = "Pending Payment";

    
    public Customer? Customer { get; set; }

    
    public List<OrderItem> Items { get; set; } = new();

    
    public Payment? Payment { get; set; }

    
    public Shipment? Shipment { get; set; }

    
    [NotMapped]
    public string Ref => "#DL-" + OrderId;

    public Delivery? Delivery()
    {
        return Shipment?.Delivery;
    }

    
    public int LineCount()
    {
        return Items.Count;
    }

    public decimal ItemsSubtotal()
    {
        return Items.Sum(i => i.Subtotal);
    }

    
    public List<Store> Stores()
    {
        return Items.Select(i => i.Product?.Store).Where(s => s != null).Select(s => s!)
            .GroupBy(s => s.StoreId).Select(g => g.First()).ToList();
    }

    
    public static IQueryable<Order> ScopeForStore(IQueryable<Order> q, int storeId)
    {
        return q.Where(o => o.Items.Any(i => i.Product != null && i.Product.StoreId == storeId));
    }

    public string? NextStatus()
    {
        var i = Array.IndexOf(FLOW, OrderStatus);
        return i == -1 || i == FLOW.Length - 1 ? null : FLOW[i + 1];
    }
}
