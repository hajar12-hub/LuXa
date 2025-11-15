package com.luxa.ecommerce.controller;

import com.luxa.ecommerce.dao.impl.CategoryDAOImpl;
import com.luxa.ecommerce.dao.impl.ProductDAOImpl;
import com.luxa.ecommerce.dao.interfaces.CategoryDAO;
import com.luxa.ecommerce.dao.interfaces.ProductDAO;
import com.luxa.ecommerce.model.Category;
import com.luxa.ecommerce.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private ProductDAO productDao;
    private CategoryDAO categoryDao;

    @Override
    public void init() throws ServletException {
        this.productDao = new ProductDAOImpl();
        this.categoryDao = new CategoryDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        try {
            // Charger les catégories
            List<Category> categories = categoryDao.findAll();
            req.setAttribute("categories", categories);

            // Charger les produits (limiter à 6-8 pour la section "Nos Créations")
            List<Product> allProducts = productDao.findAll();
            List<Product> featuredProducts = allProducts.stream()
                    .limit(8)
                    .collect(java.util.stream.Collectors.toList());
            req.setAttribute("featuredProducts", featuredProducts);

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}