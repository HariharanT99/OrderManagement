using DAL.Interface;
using DAL.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL.Method
{
    public class OrderBL
    {
        private readonly ICDapper _dapper;

        public OrderBL(ICDapper dapper)
        {
            this._dapper = dapper;
        }

        public void CreateOrder(OrderViewModel products)
        {
            _dapper.CreateOrder(products);
        }
    }
}
