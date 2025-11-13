/*package com.luxa.ecommerce.controller.cart;

import com.luxa.ecommerce.cart.Cart;
import com.luxa.ecommerce.cart.CartUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="CartViewServlet", urlPatterns={"/cart"})
public class CartViewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Cart cart = CartUtils.getOrCreate(req.getSession());
        req.setAttribute("cart", cart);
        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
    }
}*/
