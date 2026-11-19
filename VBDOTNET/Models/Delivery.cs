
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;

[Table("delivery")]
public class Delivery : SqlServerModel
{
    
    [Key]
    [Column("delivery_id")]
    public int DeliveryId { get; set; }

    [Column("shipment_id")]
    public int ShipmentId { get; set; }

    [Column("recipient_name")]
    [MaxLength(100)]
    public string RecipientName { get; set; } = "";

    [Column("phone")]
    [MaxLength(16)]
    public string Phone { get; set; } = "";

    [Column("delivery_address")]
    [MaxLength(250)]
    public string DeliveryAddress { get; set; } = "";

    [Column("city")]
    [MaxLength(50)]
    public string City { get; set; } = "";

    [Column("delivery_method")]
    [MaxLength(10)]
    public string DeliveryMethod { get; set; } = "";

    
    [Column("delivery_fee", TypeName = "decimal(7,2)")]
    public decimal DeliveryFee { get; set; }

    
    [Column("estimated_delivery_date", TypeName = "date")]
    public DateTime EstimatedDeliveryDate { get; set; }

    [Column("delivery_status")]
    [MaxLength(12)]
    public string DeliveryStatus { get; set; } = "Scheduled";

    
    public Shipment? Shipment { get; set; }

    
    public string ShortAddress()
    {
        var first = DeliveryAddress.Split(',')[0].Trim();
        return first + ", " + City;
    }
}
