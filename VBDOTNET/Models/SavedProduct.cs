
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;


[Table("saved_product")]
public class SavedProduct : SqlServerModel
{
    
    [Key]
    [Column("saved_id")]
    public int SavedId { get; set; }

    [Column("customer_id")]
    public int CustomerId { get; set; }

    [Column("product_id")]
    public int ProductId { get; set; }

    
    [Column("saved_date")]
    public DateTime SavedDate { get; set; }

    
    public Product? Product { get; set; }

    
    public Customer? Customer { get; set; }
}
