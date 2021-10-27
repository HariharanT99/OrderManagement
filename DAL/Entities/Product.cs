using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

#nullable disable

namespace DAL.Entities
{
    [Table("Product")]
    public partial class Product
    {
        public Product()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }

        [Key]
        public int ProductId { get; set; }
        public int CategoryId { get; set; }
        [Required]
        [StringLength(20)]
        public string ProductName { get; set; }
        public int ProductInHand { get; set; }
        public int ProductOnOrder { get; set; }
        [Column(TypeName = "smallmoney")]
        public decimal Price { get; set; }
        [Column(TypeName = "datetime")]
        public DateTime PriceUpdatedAt { get; set; }
        public bool IsActive { get; set; }

        [ForeignKey(nameof(CategoryId))]
        [InverseProperty("Products")]
        public virtual Category Category { get; set; }
        [InverseProperty(nameof(OrderDetail.Product))]
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
