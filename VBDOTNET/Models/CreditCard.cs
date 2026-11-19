
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Designly.Models.Concerns;

namespace Designly.Models;

[Table("credit_card")]
public class CreditCard : SqlServerModel
{
    
    [Key]
    [Column("card_id")]
    public int CardId { get; set; }

    [Column("customer_id")]
    public int CustomerId { get; set; }

    [Column("cardHolderName")]
    [MaxLength(60)]
    public string CardHolderName { get; set; } = "";

    [Column("lastFourDigits")]
    [MaxLength(4)]
    public string LastFourDigits { get; set; } = "";

    
    [Column("expiryDate")]
    [MaxLength(5)]
    public string ExpiryDate { get; set; } = "";

    [Column("cardType")]
    [MaxLength(12)]
    public string CardType { get; set; } = "";

    
    public Customer? Customer { get; set; }

    public string Label()
    {
        return CardType + " ···· " + LastFourDigits;
    }
}
