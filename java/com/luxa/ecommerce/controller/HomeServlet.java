package com.luxa.ecommerce.controller;

import jakarta.servlet.annotation.WebServlet;
import com.luxa.ecommerce.dao.UserDAO;
import com.luxa.ecommerce.model.User;
import com.luxa.ecommerce.util.Passwords;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet(name="HomeServlet", urlPatterns={"/home"})
public class HomeServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}