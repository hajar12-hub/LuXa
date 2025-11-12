package com.luxa.ecommerce.controller;

import com.luxa.ecommerce.dao.interfaces.UserDAO;   // <-- utilise l'interface
import com.luxa.ecommerce.dao.impl.UserDAOImpl;
import com.luxa.ecommerce.model.User;
import com.luxa.ecommerce.util.Passwords;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

// Si tu as web.xml, l'annotation est optionnelle.
@WebServlet(name="LoginServlet", urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        //accepte tout caractere
        req.setCharacterEncoding("UTF-8");

        //Récupérer les données du formulaire
        String email = trim(req.getParameter("email"));
        String password = req.getParameter("password");
        //je part a la BD et je cherche user a partir de son email
        User u = userDAO.findByEmail(email);

        // on vérifie d'abord si utilisateur existe dans base (car c login)
        //ici avec check je compare le code taper et le code qui est renvoyé dans la base de donné
        //méthode retourne boolean
        if (u != null && Passwords.check(password, u.getPasswordHash())) {
            //cas succés
            //il crée de session

            //detruit l`ancienne session
            HttpSession old = req.getSession(false);
            if (old != null) old.invalidate();
            //cree une nouvelle + fixer le temp
            HttpSession session = req.getSession(true);
            session.setMaxInactiveInterval( 60 * 60); // 1 jour

            // --- Stocker minimum ---
            session.setAttribute("authUserId", u.getId());
            session.setAttribute("authUsername", u.getUsername());
            session.setAttribute("authRole", u.getRole());
            //donne redirection,on dit que user est connecté va maintenant a home
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        } else {
            //cas echec
            //il ne crée pas de session
            req.setAttribute("error", "Email ou mot de passe invalides");
            req.setAttribute("old_email", email);
            //Il ne redirige pas. Il "fait suivre" (forward) à la page login.jsp (la même page de formulaire).
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        }
    }
    //helpers
    private static String trim(String s){ return s==null? null : s.trim(); }

}
