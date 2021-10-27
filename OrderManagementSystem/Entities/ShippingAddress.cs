using System;
using System.Collections.Generic;

#nullable disable

namespace OrderManagementSystem.Entities
{
    public partial class ShippingAddress
    {
        public ShippingAddress()
        {
            Orders = new HashSet<Order>();
        }

        public int ShippingAddressId { get; set; }
        public int UserId { get; set; }
        public string Address { get; set; }

        public virtual User User { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
