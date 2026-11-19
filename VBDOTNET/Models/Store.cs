
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;

[Table("store")]
public class Store : SqlServerModel
{
    
    [Key]
    [Column("store_id")]
    public int StoreId { get; set; }

    [Column("STadmin_id")]
    public int StAdminId { get; set; }

    [Column("store_name")]
    [MaxLength(100)]
    public string StoreName { get; set; } = "";

    
    [Column("commercial_reg")]
    [MaxLength(10)]
    public string CommercialReg { get; set; } = "";

    [Column("city")]
    [MaxLength(50)]
    public string City { get; set; } = "";

    [Column("address")]
    [MaxLength(250)]
    public string Address { get; set; } = "";

    [Column("phone")]
    [MaxLength(16)]
    public string Phone { get; set; } = "";

    
    [Column("avg_rating", TypeName = "decimal(2,1)")]
    public decimal? AvgRating { get; set; }

    [Column("store_status")]
    [MaxLength(10)]
    public string StoreStatus { get; set; } = "Pending";

    
    public StoreAdmin? Owner { get; set; }

    
    public List<Product> Products { get; set; } = new();

    
    public List<StoreReview> Reviews { get; set; } = new();

    
    [NotMapped]
    public int? ReviewsCount { get; set; }

    
    [NotMapped]
    public int? ProductsCount { get; set; }

    
    public static IQueryable<Store> ScopeActive(IQueryable<Store> q)
    {
        return q.Where(s => s.StoreStatus == "Active");
    }

    public bool IsActive()
    {
        return StoreStatus == "Active";
    }

    
    public int ReviewCount()
    {
        
        return ReviewsCount ?? Reviews.Count;
    }
}
