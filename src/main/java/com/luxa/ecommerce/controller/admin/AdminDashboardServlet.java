package com.luxa.ecommerce.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // TODO : plus tard, tu pourras ajouter des statistiques :
        // req.setAttribute("productCount", ...);
        // req.setAttribute("categoryCount", ...);
        // req.setAttribute("orderCount", ...);
        // req.setAttribute("userCount", ...);

        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
                .forward(req, resp);
    }
}
