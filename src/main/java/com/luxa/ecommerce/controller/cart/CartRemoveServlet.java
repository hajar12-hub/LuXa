package com.luxa.ecommerce.controller.cart;

import com.luxa.ecommerce.service.CartService;
import com.luxa.ecommerce.util.CartUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="CartRemoveServlet", urlPatterns={"/cart/remove"})
public class CartRemoveServlet extends HttpServlet {
    private final CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            String productIdStr = req.getParameter("productId");

            if (productIdStr == null || productIdStr.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du produit manquant");
                return;
            }

            int productId = Integer.parseInt(productIdStr);

            var cart = CartUtils.getOrCreateCart(req.getSession());
            cartService.remove(cart, productId);
            
            // Sauvegarder le panier dans la session
            req.getSession().setAttribute("cart", cart);

            resp.sendRedirect(req.getContextPath() + "/cart");

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du produit invalide");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la suppression du produit");
        }
    }
}
