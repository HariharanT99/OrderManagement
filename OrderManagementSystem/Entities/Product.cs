using System;
using System.Collections.Generic;

#nullable disable

namespace OrderManagementSystem.Entities
{
    public partial class Product
    {
        public Product()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }

        public int ProductId { get; set; }
        public int CategoryId { get; set; }
        public string ProductName { get; set; }
        public int ProductInHand { get; set; }
        public int ProductOnOrder { get; set; }
        public decimal Price { get; set; }
        public DateTime PriceUpdatedAt { get; set; }
        public bool IsActive { get; set; }

        public virtual Category Category { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
