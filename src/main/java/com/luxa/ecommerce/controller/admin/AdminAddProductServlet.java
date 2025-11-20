package com.luxa.ecommerce.controller.admin;

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
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "AdminAddProductServlet", urlPatterns = {"/admin/products/new"})
public class AdminAddProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        this.productDAO = new ProductDAOImpl();
        this.categoryDAO = new CategoryDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        // Charger les catégories pour le formulaire
        List<Category> categories = categoryDAO.findAll();
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        try {
            // Si un ID est présent, rediriger vers le servlet d'édition
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/admin/products/edit?id=" + idStr);
                return;
            }

            String name = req.getParameter("name");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String stockQuantityStr = req.getParameter("stockQuantity");
            String categoryIdStr = req.getParameter("categoryId");

            Product p = new Product();
            p.setName(name);
            p.setDescription(description);
            
            if (priceStr != null && !priceStr.isEmpty()) {
                p.setPrice(new BigDecimal(priceStr));
            }
            
            if (stockQuantityStr != null && !stockQuantityStr.isEmpty()) {
                p.setStockQuantity(Integer.parseInt(stockQuantityStr));
            } else {
                p.setStockQuantity(0);
            }
            
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                Optional<Category> categoryOpt = categoryDAO.findById(Integer.parseInt(categoryIdStr));
                categoryOpt.ifPresent(p::setCategory);
            }

            productDAO.save(p);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Après ajout, on revient à la liste des produits admin
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}
