package com.luxa.ecommerce.controller.cart;

import com.luxa.ecommerce.service.CartService;
import com.luxa.ecommerce.util.CartUtils;
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
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            String productIdStr = req.getParameter("productId");
            String qtyStr = req.getParameter("qty");
            if (qtyStr == null || qtyStr.isEmpty()) {
                qtyStr = req.getParameter("quantity");
            }

            if (productIdStr == null || productIdStr.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du produit manquant");
                return;
            }

            if (qtyStr == null || qtyStr.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quantité manquante");
                return;
            }

            int productId = Integer.parseInt(productIdStr);
            int qty = Integer.parseInt(qtyStr);

            if (qty < 0) {
                qty = 0;
            }

            var cart = CartUtils.getOrCreateCart(req.getSession());
            cartService.update(cart, productId, qty);
            
            // Sauvegarder le panier dans la session
            req.getSession().setAttribute("cart", cart);

            resp.sendRedirect(req.getContextPath() + "/cart");

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètres invalides");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la mise à jour du panier");
        }
    }
}
