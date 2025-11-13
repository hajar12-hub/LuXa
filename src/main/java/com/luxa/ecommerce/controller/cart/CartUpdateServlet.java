/*package com.luxa.ecommerce.controller.cart;

import com.luxa.ecommerce.cart.CartUtils;
import com.luxa.ecommerce.service.CartService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="CartUpdateServlet", urlPatterns={"/cart/update"})
public class CartUpdateServlet extends HttpServlet {
    private final CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int qty = Integer.parseInt(req.getParameter("qty"));

        var cart = CartUtils.getOrCreate(req.getSession());
        cartService.update(cart, productId, qty);

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}*/
