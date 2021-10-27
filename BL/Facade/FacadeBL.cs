using BL.Method;
using DAL.Entities;
using DAL.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL.Facade
{
    public class FacadeBL
    {
        private readonly ProductBL _productBL;
        private readonly OrderBL _orderBL;

        public FacadeBL(ProductBL productBL, OrderBL orderBL)
        {
            this._productBL = productBL;
            this._orderBL = orderBL;
        }


        public List<Product> GetProducts()
        {
            List<Product> products = _productBL.GetProducts();

            return products;
        }

        public List<Product> GetCartItems(List<int> id)
        {
            List<Product> products = _productBL.GetCartItems(id);

            return products;
        }

        public void CreateOrder(OrderViewModel products)
        {
            _orderBL.CreateOrder(products);

        }
    }
}
