package com.luxa.ecommerce.controller;

import com.luxa.ecommerce.dao.interfaces.UserDAO;   // <-- utilise l'interface
import com.luxa.ecommerce.dao.impl.UserDAOImpl;
import com.luxa.ecommerce.model.User;
import com.luxa.ecommerce.util.Passwords;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name="RegisterServlet", urlPatterns={"/register"})
public class RegisterServlet extends HttpServlet {

    // Idéalement : injecter via le contexte (Listener) ou CDI/Spring.
    private UserDAO userDAO;

    @Override
    public void init() {
        // ex: récupéré depuis ServletContext si tu l’as mis dans un listener
        Object dao = getServletContext().getAttribute("userDAO");
        this.userDAO = (dao instanceof UserDAO) ? (UserDAO) dao : new UserDAOImpl(); // fallback
    }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String username = trim(req.getParameter("username"));
        String email = lower(trim(req.getParameter("email")));
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirmPassword");

        Map<String,String> errors = new HashMap<>();

        // Validations
        if (isBlank(username) || username.length() < 3 || username.length() > 150) {
            errors.put("username", "Nom d’utilisateur : 3 à 150 caractères.");
        }
        if (!isValidEmail(email)) {
            errors.put("email", "Email invalide.");
        }
        if (!isStrongPassword(password)) {
            errors.put("password", "Mot de passe ≥ 8, avec majuscule, minuscule et chiffre.");
        }
        if (confirm == null || !confirm.equals(password)) {
            errors.put("confirmPassword", "Les mots de passe ne correspondent pas.");
        }

        // Unicité
        if (errors.isEmpty()) {
            if (userDAO.existsByEmail(email)) {
                errors.put("email", "Email déjà utilisé.");
            }
            if (userDAO.existsByUsername(username)){
                errors.put("username", "Nom d’utilisateur déjà pris.");
            }
        }

        if (!errors.isEmpty()) {
            // Repasser les valeurs non sensibles + erreurs à la JSP
            req.setAttribute("errors", errors);
            req.setAttribute("old_username", username);
            req.setAttribute("old_email", email);
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }

        // Persistance
        User u = new User();
        u.setUsername(username);
        u.setEmail(email);
        u.setPasswordHash(Passwords.hashBCrypt(password)); // BCrypt
        u.setRole("USER");
        u.setCreatedAt(LocalDateTime.now());

        try {
            userDAO.save(u);
        } catch (Exception e) {
            // Double sécurité si contrainte UNIQUE lève une exception
            req.setAttribute("globalError", "Impossible de créer le compte. Réessaie.");
            req.setAttribute("old_username", username);
            req.setAttribute("old_email", email);
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }



        // Choix 1 : rediriger vers la connexion
        //resp.sendRedirect(req.getContextPath() + "/login");

        // Choix 2 (option) : connecter directement, puis redirect profil
         HttpSession session = req.getSession(true);
         session.setAttribute("authUserId", u.getId());
         session.setAttribute("authUsername", u.getUsername());
        resp.sendRedirect(req.getContextPath() + "/home");
        return;
    }

    // --- Helpers ---
    private static String trim(String s){ return s==null? null : s.trim(); }
    private static String lower(String s){ return s==null? null : s.toLowerCase(); }
    private static boolean isBlank(String s){ return s==null || s.trim().isEmpty(); }

    private static boolean isValidEmail(String email){
        if (email == null) return false;
        return email.matches("^[\\w._%+-]+@[\\w.-]+\\.[A-Za-z]{2,}$");
    }

    private static boolean isStrongPassword(String pwd){
        if (pwd == null || pwd.length() < 8) return false;
        boolean hasUp=false, hasLow=false, hasDigit=false;
        for(char c : pwd.toCharArray()){
            if(Character.isUpperCase(c)) hasUp=true;
            else if(Character.isLowerCase(c)) hasLow=true;
            else if(Character.isDigit(c)) hasDigit=true;
        }
        return hasUp && hasLow && hasDigit;
    }
}
