package com.luxa.ecommerce.controller;

import com.luxa.ecommerce.controller.cart.Cart;
import com.luxa.ecommerce.dao.impl.OrderDAOImpl;
import com.luxa.ecommerce.dao.impl.ProductDAOImpl;
import com.luxa.ecommerce.dao.impl.UserDAOImpl;
import com.luxa.ecommerce.dao.interfaces.OrderDAO;
import com.luxa.ecommerce.dao.interfaces.ProductDAO;
import com.luxa.ecommerce.dao.interfaces.UserDAO;
import com.luxa.ecommerce.dto.CartItemDTO;
import com.luxa.ecommerce.model.Order;
import com.luxa.ecommerce.model.OrderItem;
import com.luxa.ecommerce.model.Product;
import com.luxa.ecommerce.model.User;
import com.luxa.ecommerce.util.CartUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private UserDAO userDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        this.orderDAO = new OrderDAOImpl();
        this.userDAO = new UserDAOImpl();
        this.productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            // Vérifier que l'utilisateur est connecté
            Integer userId = (Integer) req.getSession().getAttribute("authUserId");
            if (userId == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            // Récupérer le panier
            Cart cart = CartUtils.getOrCreateCart(req.getSession());
            if (cart.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            // Récupérer l'utilisateur
            User user = userDAO.findById(userId);
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            // Créer la commande
            Order order = new Order();
            order.setUser(user);
            order.setTotalAmount(cart.getTotal());
            order.setStatus(Order.OrderStatus.confirmed);
            order.setPaymentStatus(Order.PaymentStatus.paid);
            
            // Créer les OrderItems
            List<OrderItem> orderItems = new ArrayList<>();
            for (Cart.Line line : cart.getLines()) {
                CartItemDTO item = line.getItem();
                Product product = productDAO.findById(item.getId())
                        .orElseThrow(() -> new IllegalArgumentException("Produit introuvable: " + item.getId()));

                OrderItem orderItem = new OrderItem();
                orderItem.setProduct(product);
                orderItem.setQuantity(line.getQty());
                orderItem.setPriceAtOrder(item.getEffectiveUnitPrice());
                orderItem.setOrder(order);
                orderItems.add(orderItem);
            }

            // Définir les items dans la commande
            order.setOrderItems(orderItems);
            
            // Sauvegarder la commande (les items seront sauvegardés via cascade)
            orderDAO.save(order);

            // Vider le panier
            cart.clear();
            req.getSession().setAttribute("cart", cart);

            // Rediriger vers la page de confirmation avec l'ID de la commande
            resp.sendRedirect(req.getContextPath() + "/order-confirmation?orderId=" + order.getId());

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la création de la commande: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Rediriger vers le panier si accès en GET
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}

