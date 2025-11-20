package com.luxa.ecommerce.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name="LogoutServlet", urlPatterns={"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Invalider la session actuelle (efface toutes les données utilisateur)
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Supprimer éventuellement le cookie JSESSIONID (optionnel mais propre)
        Cookie cookie = new Cookie("JSESSIONID", "");
        cookie.setMaxAge(0);
        cookie.setPath(req.getContextPath());
        resp.addCookie(cookie);

        // Rediriger vers la page d'accueil ou de connexion
        resp.sendRedirect(req.getContextPath() + "/login");
    }

    // Optionnel : tu peux aussi autoriser POST
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
