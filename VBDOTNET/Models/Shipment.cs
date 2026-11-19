
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;


[Table("shipment")]
public class Shipment : SqlServerModel
{
    
    [Key]
    [Column("shipment_id")]
    public int ShipmentId { get; set; }

    [Column("order_id")]
    public int OrderId { get; set; }

    [Column("carrier_name")]
    [MaxLength(60)]
    public string? CarrierName { get; set; }

    [Column("tracking_number")]
    [MaxLength(40)]
    public string? TrackingNumber { get; set; }

    
    [Column("shipped_date")]
    public DateTime? ShippedDate { get; set; }

    
    [Column("delivered_date")]
    public DateTime? DeliveredDate { get; set; }

    [Column("shipment_status")]
    [MaxLength(12)]
    public string ShipmentStatus { get; set; } = "Preparing";

    
    public Order? Order { get; set; }

    
    public Delivery? Delivery { get; set; }
}
