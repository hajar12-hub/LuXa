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
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/catalogue")
public class CatalogueServlet extends HttpServlet {

    private ProductDAO productDao;
    private CategoryDAO categoryDao;

    @Override
    public void init() throws ServletException {
        this.productDao = new ProductDAOImpl();
        this.categoryDao = new CategoryDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Category> allCategories = categoryDao.findAll();

            // Récupération des paramètres de filtrage
            String categoryIdStr = req.getParameter("category");
            Integer categoryId = null;
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                } catch (NumberFormatException e) {
                    // Ignore invalid category ID
                }
            }

            // Filtres prix
            Double priceMin = parseDouble(req.getParameter("priceMin"));
            Double priceMax = parseDouble(req.getParameter("priceMax"));

            // Filtres matériaux
            String[] materialsParams = req.getParameterValues("materials");
            List<String> selectedMaterials = materialsParams != null ? Arrays.asList(materialsParams) : new ArrayList<>();

            // Récupération des produits avec filtres
            List<Product> allProducts = productDao.search(categoryId, null, priceMin, priceMax);

            // Application du filtre matériaux (filtrage en mémoire car le DAO ne le gère pas)
            List<Product> filteredProducts = allProducts;
            if (!selectedMaterials.isEmpty()) {
                filteredProducts = allProducts.stream()
                        .filter(p -> p.getMaterial() != null && selectedMaterials.contains(p.getMaterial()))
                        .collect(Collectors.toList());
            }

            // Récupération des matériaux disponibles pour les filtres
            Set<String> availableMaterials = allProducts.stream()
                    .map(Product::getMaterial)
                    .filter(Objects::nonNull)
                    .filter(m -> !m.trim().isEmpty())
                    .collect(Collectors.toSet());

            // Passage des données à la JSP
            req.setAttribute("pageTitle", "Notre Catalogue");
            req.setAttribute("products", filteredProducts);
            req.setAttribute("categories", allCategories);
            req.setAttribute("selectedCategoryId", categoryId);
            req.setAttribute("selectedPriceMin", priceMin);
            req.setAttribute("selectedPriceMax", priceMax);
            req.setAttribute("selectedMaterials", selectedMaterials);
            req.setAttribute("availableMaterials", availableMaterials);

            req.getRequestDispatcher("/WEB-INF/views/catalogue.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur lors de la récupération des produits.");
        }
    }

    private Double parseDouble(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}