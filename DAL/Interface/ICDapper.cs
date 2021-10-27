using DAL.Entities;
using DAL.Method;
using DAL.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interface
{
    public interface ICDapper
    {
        List<Product> GetProducts();

        List<Product> GetCartItems(List<int> id);

        void CreateOrder(OrderViewModel products);
    }
}
