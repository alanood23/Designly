
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;


[Table("payment")]
public class Payment : SqlServerModel
{
    
    [Key]
    [Column("payment_id")]
    public int PaymentId { get; set; }

    [Column("order_id")]
    public int OrderId { get; set; }

    
    [Column("total_amount", TypeName = "decimal(10,2)")]
    public decimal TotalAmount { get; set; }

    
    [Column("vat_amount", TypeName = "decimal(10,2)")]
    public decimal VatAmount { get; set; }

    [Column("transaction_ref")]
    [MaxLength(40)]
    public string? TransactionRef { get; set; }

    [Column("payment_method")]
    [MaxLength(12)]
    public string PaymentMethod { get; set; } = "";

    [Column("payment_status")]
    [MaxLength(10)]
    public string PaymentStatus { get; set; } = "Pending";

    
    [Column("payment_date")]
    public DateTime PaymentDate { get; set; }

    
    [Column("discount_amount", TypeName = "decimal(10,2)")]
    public decimal DiscountAmount { get; set; }

    
    public Order? Order { get; set; }
}
