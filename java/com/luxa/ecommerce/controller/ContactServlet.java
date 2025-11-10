package com.luxa.ecommerce.controller;

import com.luxa.ecommerce.dao.ContactMessageDAO;
import com.luxa.ecommerce.model.ContactMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name="ContactServlet", urlPatterns={"/contact"})
public class ContactServlet extends HttpServlet {
    private final ContactMessageDAO dao = new ContactMessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Récupérer un éventuel flash (succès) depuis la session
        HttpSession session = req.getSession(false);
        if (session != null) {
            Object flash = session.getAttribute("flashSuccess");
            if (flash != null) {
                req.setAttribute("flashSuccess", flash);
                session.removeAttribute("flashSuccess");
            }
        }
        req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String fullName = trim(req.getParameter("fullName"));
        String email    = trim(req.getParameter("email"));
        String subject  = trim(req.getParameter("subject"));
        String message  = trim(req.getParameter("message"));

        Map<String,String> errors = new HashMap<>();

        if (isBlank(fullName) || fullName.length() > 150) {
            errors.put("fullName", "Nom requis (≤ 150).");
        }
        if (isBlank(email) || email.length() > 180
                || !email.matches("^[\\w.!#$%&’*+/=?`{|}~^-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            errors.put("email", "Email invalide.");
        }
        if (isBlank(subject) || subject.length() > 200) {
            errors.put("subject", "Sujet requis (≤ 200).");
        }
        if (isBlank(message)) {
            errors.put("message", "Message requis.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("old_fullName", fullName);
            req.setAttribute("old_email", email);
            req.setAttribute("old_subject", subject);
            req.setAttribute("old_message", message);
            req.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(req, resp);
            return;
        }

        ContactMessage m = new ContactMessage();
        m.setFullName(fullName);
        m.setEmail(email);
        m.setSubject(subject);
        m.setMessage(message);
        dao.save(m);

        // PRG + flash success
        req.getSession().setAttribute("flashSuccess",
                "Merci ! Votre message a bien été envoyé. Notre équipe vous répondra rapidement.");
        resp.sendRedirect(req.getContextPath() + "/contact");
    }

    private static boolean isBlank(String s){ return s == null || s.trim().isEmpty(); }
    private static String trim(String s){ return s == null ? null : s.trim(); }
}
