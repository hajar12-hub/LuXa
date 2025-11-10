// ProfilServlet.java
package com.luxa.ecommerce.controller;

import com.luxa.ecommerce.dao.UserDAO;
import com.luxa.ecommerce.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet(name="ProfilServlet", urlPatterns={"/profil"})
public class ProfilServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer userId = (Integer) req.getSession().getAttribute("authUserId");
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User u = userDAO.findById(userId);
        if (u == null) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("user", u);
        req.getRequestDispatcher("/WEB-INF/views/profil.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Integer userId = (Integer) req.getSession().getAttribute("authUserId");
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User u = userDAO.findById(userId);
        if (u == null) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // --- Inputs (normalisés) ---
        String username  = trim(req.getParameter("username"));
        String emailRaw  = trim(req.getParameter("email"));
        String email     = emailRaw == null ? null : emailRaw.toLowerCase(); // normalisation
        String firstName = blankToNull(req.getParameter("firstName"));
        String lastName  = blankToNull(req.getParameter("lastName"));
        String address   = blankToNull(req.getParameter("address"));
        String phone     = blankToNull(req.getParameter("phoneNumber"));

        // ⚠️ demandé seulement si email change
        String currentPassword = req.getParameter("currentPassword");

        // --- Validations format ---
        if (!isValidUsername(username)) {
            fail(req, resp, u, "Nom d’utilisateur invalide (3–150, lettres/chiffres . _ -)");
            return;
        }
        if (!isValidEmail(email)) {
            fail(req, resp, u, "Email invalide.");
            return;
        }
        if (firstName != null && firstName.length() > 100) {
            fail(req, resp, u, "Prénom : 100 caractères maximum.");
            return;
        }
        if (lastName != null && lastName.length() > 100) {
            fail(req, resp, u, "Nom : 100 caractères maximum.");
            return;
        }
        if (phone != null && phone.length() > 50) {
            fail(req, resp, u, "Téléphone : 50 caractères maximum.");
            return;
        }

        // --- Unicité si modifiés ---
        boolean usernameChanged = !u.getUsername().equals(username);
        boolean emailChanged    = !u.getEmail().equalsIgnoreCase(email);

        if (usernameChanged && userDAO.existsByUsernameIgnoreCase(username)) {
            fail(req, resp, u, "Nom d’utilisateur déjà pris.");
            return;
        }
        if (emailChanged && userDAO.existsByEmailIgnoreCase(email)) {
            fail(req, resp, u, "Adresse e-mail déjà utilisée.");
            return;
        }

        // --- Si email change → exiger mot de passe actuel ---
        if (emailChanged) {
            if (isBlank(currentPassword)) {                 // 👈 use helper here
                fail(req, resp, u, "Mot de passe requis pour changer l’e-mail.");
                return;
            }
            if (!com.luxa.ecommerce.util.Passwords.check(currentPassword, u.getPasswordHash())) {
                fail(req, resp, u, "Mot de passe actuel incorrect.");
                return;
            }
        }

        // --- Appliquer ---
        u.setUsername(username);
        u.setEmail(email);
        u.setFirstName(firstName);
        u.setLastName(lastName);
        u.setAddress(address);
        u.setPhoneNumber(phone);

        try {
            userDAO.update(u);
            // MAJ session si username a changé
            if (usernameChanged) {
                req.getSession().setAttribute("authUsername", u.getUsername());
            }
            req.setAttribute("success", "Profil mis à jour avec succès.");
        } catch (Exception e) {
            // filet de sécurité si la DB a des contraintes UNIQUE et lève une exception
            String msg = (e.getMessage() != null && e.getMessage().toLowerCase().contains("duplicate"))
                    ? "Conflit d’unicité (email ou nom d’utilisateur déjà utilisé)."
                    : "Échec de la mise à jour. Réessaie.";
            req.setAttribute("error", msg);
        }

        req.setAttribute("user", u);
        req.getRequestDispatcher("/WEB-INF/views/profil.jsp").forward(req, resp);
    }

    // Helpers additionnels à placer dans la classe
    private static boolean isValidUsername(String s){
        return s != null && s.length() >= 3 && s.length() <= 150
                && s.matches("^[A-Za-z0-9._-]+$");
    }
    private void fail(HttpServletRequest req, HttpServletResponse resp, User u, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.setAttribute("user", u);
        req.getRequestDispatcher("/WEB-INF/views/profil.jsp").forward(req, resp);
    }

    private static String trim(String s){ return s==null? null : s.trim(); }
    private static boolean isBlank(String s){ return s==null || s.trim().isEmpty(); }
    private static String blankToNull(String s){ if (s == null) return null; String t = s.trim(); return t.isEmpty() ? null : t; }
    private static boolean isValidEmail(String email){ return email != null && email.matches("^[\\w._%+-]+@[\\w.-]+\\.[A-Za-z]{2,}$"); }
}