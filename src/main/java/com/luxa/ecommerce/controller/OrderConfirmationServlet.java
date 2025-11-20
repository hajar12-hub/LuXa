package com.luxa.ecommerce.controller;

import com.luxa.ecommerce.dao.impl.OrderDAOImpl;
import com.luxa.ecommerce.dao.interfaces.OrderDAO;
import com.luxa.ecommerce.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        this.orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Vérifier que l'utilisateur est connecté
        Integer userId = (Integer) req.getSession().getAttribute("authUserId");
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Récupérer l'ID de la commande
        String orderIdStr = req.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        try {
            Integer orderId = Integer.parseInt(orderIdStr);
            Order order = orderDAO.findById(orderId)
                    .orElse(null);

            // Vérifier que la commande appartient à l'utilisateur connecté
            if (order == null || !order.getUser().getId().equals(userId)) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            req.setAttribute("order", order);
            req.getRequestDispatcher("/WEB-INF/views/order-confirmation.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}

