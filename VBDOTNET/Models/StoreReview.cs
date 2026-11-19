
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;

[Table("store_review")]
public class StoreReview : SqlServerModel
{
    
    [Key]
    [Column("review_id")]
    public int ReviewId { get; set; }

    [Column("customer_id")]
    public int CustomerId { get; set; }

    [Column("store_id")]
    public int StoreId { get; set; }

    
    [Column("star_rating")]
    public int StarRating { get; set; }

    [Column("comment")]
    [MaxLength(1000)]
    public string? Comment { get; set; }

    
    [Column("review_date")]
    public DateTime ReviewDate { get; set; }

    
    public Store? Store { get; set; }

    
    public Customer? Customer { get; set; }
}
