package com.luxa.ecommerce.controller.admin;

import com.luxa.ecommerce.dao.impl.CategoryDAOImpl;
import com.luxa.ecommerce.dao.impl.ProductDAOImpl;
import com.luxa.ecommerce.dao.impl.ProductImageDAOImpl;
import com.luxa.ecommerce.dao.interfaces.CategoryDAO;
import com.luxa.ecommerce.dao.interfaces.ProductDAO;
import com.luxa.ecommerce.dao.interfaces.ProductImageDAO;
import com.luxa.ecommerce.model.Category;
import com.luxa.ecommerce.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminProductsServlet", urlPatterns = {"/admin/products"})
public class AdminProductsServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private ProductImageDAO productImageDAO;

    @Override
    public void init() throws ServletException {
        this.productDAO = new ProductDAOImpl();
        this.categoryDAO = new CategoryDAOImpl();
        this.productImageDAO = new ProductImageDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        try {
            // Charger tous les produits avec leurs catégories et images
            List<Product> products = productDAO.findAll();
            
            // Debug: afficher le nombre de produits
            System.out.println("DEBUG AdminProductsServlet: Nombre de produits trouvés: " + (products != null ? products.size() : 0));
            
            // Initialiser les images pour chaque produit pour éviter LazyInitializationException
            // On charge les images séparément et on les assigne aux produits
            for (Product p : products) {
                // Charger les images pour ce produit
                try {
                    List<com.luxa.ecommerce.model.ProductImage> images = productImageDAO.findByProductId(p.getId());
                    p.setImages(images);
                } catch (Exception ex) {
                    System.err.println("Erreur lors du chargement des images pour le produit " + p.getId() + ": " + ex.getMessage());
                    // Initialiser avec une liste vide si erreur
                    p.setImages(new java.util.ArrayList<>());
                }
            }
            
            req.setAttribute("products", products);

            // Charger les catégories pour le filtre éventuel
            List<Category> categories = categoryDAO.findAll();
            req.setAttribute("categories", categories);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("ERREUR AdminProductsServlet: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement des produits: " + e.getMessage());
            req.setAttribute("products", new java.util.ArrayList<>());
        }

        req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp")
                .forward(req, resp);
    }
}

