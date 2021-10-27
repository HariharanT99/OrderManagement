using System;
using System.Collections.Generic;

#nullable disable

namespace OrderManagementSystem.Entities
{
    public partial class OrderDetail
    {
        public int OrderDetailId { get; set; }
        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public decimal OrderPrice { get; set; }
        public bool IsCancelled { get; set; }

        public virtual Order Order { get; set; }
        public virtual Product Product { get; set; }
    }
}
