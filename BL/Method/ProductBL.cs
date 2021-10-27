using DAL.Entities;
using DAL.Interface;
using DAL.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL.Method
{
    public class ProductBL
    {
        private readonly ICDapper _dapper;

        public ProductBL(ICDapper dapper)
        {
            this._dapper = dapper;
        }

        public List<Product> GetProducts()
        {
            List<Product> products = _dapper.GetProducts();

            return products;
        }

        public List<Product> GetCartItems(List<int> id)
        {
            List<Product> products = _dapper.GetCartItems(id);

            return products;
        }
    }
}
