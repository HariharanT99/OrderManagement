using System;
using System.Collections.Generic;

#nullable disable

namespace OrderManagementSystem.Entities
{
    public partial class User
    {
        public User()
        {
            Orders = new HashSet<Order>();
            ShippingAddresses = new HashSet<ShippingAddress>();
        }

        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Dob { get; set; }
        public string MailId { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreatedAt { get; set; }
        public byte RoleId { get; set; }

        public virtual Role Role { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<ShippingAddress> ShippingAddresses { get; set; }
    }
}
