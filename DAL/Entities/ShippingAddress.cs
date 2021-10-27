using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

#nullable disable

namespace DAL.Entities
{
    [Table("ShippingAddress")]
    public partial class ShippingAddress
    {
        public ShippingAddress()
        {
            Orders = new HashSet<Order>();
        }

        [Key]
        public int ShippingAddressId { get; set; }
        public int UserId { get; set; }
        [Required]
        [StringLength(60)]
        public string Address { get; set; }

        [ForeignKey(nameof(UserId))]
        [InverseProperty("ShippingAddresses")]
        public virtual User User { get; set; }
        [InverseProperty(nameof(Order.ShippingAddress))]
        public virtual ICollection<Order> Orders { get; set; }
    }
}
