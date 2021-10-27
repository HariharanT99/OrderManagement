using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DAL.Data;
using DAL.Entities;
using BL.Facade;
using DAL.ViewModel;

namespace OrderManagementSystem.Controllers
{
    public class OrderController : Controller
    {
        private readonly FacadeBL _facadeBL;

        public OrderController(FacadeBL facadeBL)
        {
            _facadeBL = facadeBL;
        }

        [HttpGet]
        public IActionResult Cart(string products)
        {
            List<int> cartItems = new();
            var Id = products?.Split(',');

            if (Id != null)
            {
                foreach (var item in Id)
                {
                    if (item != "")
                    {
                        cartItems.Add(int.Parse(item));
                    }
                }
            }

            //List<OrderViewModel> Cart = new();

            if (cartItems != null)
            {
                ViewBag.Cart = _facadeBL.GetCartItems(cartItems);
            }

            return View();
        }

        [HttpPost]
        public IActionResult Cart(OrderViewModel products)
        {
            _facadeBL.CreateOrder(products);

            return View();
        }

        public IActionResult Orders()
        {
            return View();
        }


        public IActionResult CancelOrder(int id)
        {

            return View("Orders");
        }

        // GET: Order
        //public async Task<IActionResult> Index()
        //{
        //    var orderManagementSystemContext = _context.Orders.Include(o => o.ShippingAddress).Include(o => o.User);
        //    return View(await orderManagementSystemContext.ToListAsync());
        //}

        //// GET: Order/Details/5
        //public async Task<IActionResult> Details(int? id)
        //{
        //    if (id == null)
        //    {
        //        return NotFound();
        //    }

        //    var order = await _context.Orders
        //        .Include(o => o.ShippingAddress)
        //        .Include(o => o.User)
        //        .FirstOrDefaultAsync(m => m.OrderId == id);
        //    if (order == null)
        //    {
        //        return NotFound();
        //    }

        //    return View(order);
        //}

        //// GET: Order/Create
        //public IActionResult Create()
        //{
        //    ViewData["ShippingAddressId"] = new SelectList(_context.ShippingAddresses, "ShippingAddressId", "Address");
        //    ViewData["UserId"] = new SelectList(_context.Users, "UserId", "FirstName");
        //    return View();
        //}

        //// POST: Order/Create
        //// To protect from overposting attacks, enable the specific properties you want to bind to.
        //// For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> Create([Bind("OrderId,UserId,ShippingAddressId,CreatedAt,DeliveryDate,IsCancelled")] Order order)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        _context.Add(order);
        //        await _context.SaveChangesAsync();
        //        return RedirectToAction(nameof(Index));
        //    }
        //    ViewData["ShippingAddressId"] = new SelectList(_context.ShippingAddresses, "ShippingAddressId", "Address", order.ShippingAddressId);
        //    ViewData["UserId"] = new SelectList(_context.Users, "UserId", "FirstName", order.UserId);
        //    return View(order);
        //}

        //// GET: Order/Edit/5
        //public async Task<IActionResult> Edit(int? id)
        //{
        //    if (id == null)
        //    {
        //        return NotFound();
        //    }

        //    var order = await _context.Orders.FindAsync(id);
        //    if (order == null)
        //    {
        //        return NotFound();
        //    }
        //    ViewData["ShippingAddressId"] = new SelectList(_context.ShippingAddresses, "ShippingAddressId", "Address", order.ShippingAddressId);
        //    ViewData["UserId"] = new SelectList(_context.Users, "UserId", "FirstName", order.UserId);
        //    return View(order);
        //}

        //// POST: Order/Edit/5
        //// To protect from overposting attacks, enable the specific properties you want to bind to.
        //// For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> Edit(int id, [Bind("OrderId,UserId,ShippingAddressId,CreatedAt,DeliveryDate,IsCancelled")] Order order)
        //{
        //    if (id != order.OrderId)
        //    {
        //        return NotFound();
        //    }

        //    if (ModelState.IsValid)
        //    {
        //        try
        //        {
        //            _context.Update(order);
        //            await _context.SaveChangesAsync();
        //        }
        //        catch (DbUpdateConcurrencyException)
        //        {
        //            if (!OrderExists(order.OrderId))
        //            {
        //                return NotFound();
        //            }
        //            else
        //            {
        //                throw;
        //            }
        //        }
        //        return RedirectToAction(nameof(Index));
        //    }
        //    ViewData["ShippingAddressId"] = new SelectList(_context.ShippingAddresses, "ShippingAddressId", "Address", order.ShippingAddressId);
        //    ViewData["UserId"] = new SelectList(_context.Users, "UserId", "FirstName", order.UserId);
        //    return View(order);
        //}

        //// GET: Order/Delete/5
        //public async Task<IActionResult> Delete(int? id)
        //{
        //    if (id == null)
        //    {
        //        return NotFound();
        //    }

        //    var order = await _context.Orders
        //        .Include(o => o.ShippingAddress)
        //        .Include(o => o.User)
        //        .FirstOrDefaultAsync(m => m.OrderId == id);
        //    if (order == null)
        //    {
        //        return NotFound();
        //    }

        //    return View(order);
        //}

        //// POST: Order/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> DeleteConfirmed(int id)
        //{
        //    var order = await _context.Orders.FindAsync(id);
        //    _context.Orders.Remove(order);
        //    await _context.SaveChangesAsync();
        //    return RedirectToAction(nameof(Index));
        //}

        //private bool OrderExists(int id)
        //{
        //    return _context.Orders.Any(e => e.OrderId == id);
        //}
    }
}
