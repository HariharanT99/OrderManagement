using System;
using System.Collections.Generic;

#nullable disable

namespace OrderManagementSystem.Entities
{
    public partial class Order
    {
        public Order()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }

        public int OrderId { get; set; }
        public int UserId { get; set; }
        public int ShippingAddressId { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime DeliveryDate { get; set; }
        public bool IsCancelled { get; set; }

        public virtual ShippingAddress ShippingAddress { get; set; }
        public virtual User User { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
