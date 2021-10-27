using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

#nullable disable

namespace DAL.Entities
{
    [Table("User")]
    [Index(nameof(MailId), Name = "UQ__User__09A8749B6C2D350B", IsUnique = true)]
    public partial class User
    {
        public User()
        {
            Orders = new HashSet<Order>();
            ShippingAddresses = new HashSet<ShippingAddress>();
        }

        [Key]
        public int UserId { get; set; }
        [Required]
        [StringLength(18)]
        public string FirstName { get; set; }
        [StringLength(18)]
        public string LastName { get; set; }
        [Column("DOB", TypeName = "date")]
        public DateTime Dob { get; set; }
        [Required]
        [StringLength(30)]
        public string MailId { get; set; }
        public bool IsActive { get; set; }
        [Column(TypeName = "datetime")]
        public DateTime CreatedAt { get; set; }
        public byte RoleId { get; set; }

        [ForeignKey(nameof(RoleId))]
        [InverseProperty("Users")]
        public virtual Role Role { get; set; }
        [InverseProperty(nameof(Order.User))]
        public virtual ICollection<Order> Orders { get; set; }
        [InverseProperty(nameof(ShippingAddress.User))]
        public virtual ICollection<ShippingAddress> ShippingAddresses { get; set; }
    }
}
