using DAL.Entities;
using DAL.Interface;
using DAL.ViewModel;
using Dapper;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Method
{
    public class CDapper: ICDapper
    {
        private readonly string _connectionString;

        public CDapper(string connectionString)
        {
            this._connectionString = connectionString;
        }

        //Get Products

        public List<Product> GetProducts()
        {
            List<Product> products = new();
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                products = connection.Query<Product>("exec uspGetProduct").ToList();
            }

            return products;
        }

        public List<Product> GetCartItems(List<int> id)
        {
            List<Product> products = new();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                foreach (var item in id)
                {
                    var product = connection.Query<Product>("exec uspGetCartItem @ID", new { @ID = item}).FirstOrDefault();
                    products.Add(product);

                }
            }

            return products;
        }

        public void CreateOrder(OrderViewModel products)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var orderId = connection.Query<int>("exec uspAddOrder").FirstOrDefault();

                foreach (var Id in products.ProductId)
                {
                    connection.Query("exec uspAddOrderDetail @OrderId, @ProductId", new { @OrderId = orderId, @ProductId = Id});
                }
            }

        }


        public void CancelOrder(int orderId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Query<int>("exec spCancelOrder");
            }
        }
    }
}
