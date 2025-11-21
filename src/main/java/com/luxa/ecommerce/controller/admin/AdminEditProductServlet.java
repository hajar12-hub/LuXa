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
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "AdminEditProductServlet", urlPatterns = {"/admin/products/edit"})
public class AdminEditProductServlet extends HttpServlet {

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
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                Integer id = Integer.parseInt(idStr);
                Optional<Product> productOpt = productDAO.findById(id);
                
                if (productOpt.isPresent()) {
                    Product product = productOpt.get();
                    
                    // Charger les images explicitement pour éviter LazyInitializationException
                    try {
                        List<com.luxa.ecommerce.model.ProductImage> images = productImageDAO.findByProductId(product.getId());
                        product.setImages(images);
                    } catch (Exception ex) {
                        System.err.println("Erreur lors du chargement des images pour le produit " + product.getId() + ": " + ex.getMessage());
                        product.setImages(new java.util.ArrayList<>());
                    }
                    
                    req.setAttribute("product", product);
                    System.out.println("DEBUG AdminEditProductServlet: Produit chargé - ID: " + product.getId() + ", Nom: " + product.getName());
                } else {
                    req.setAttribute("error", "Produit introuvable.");
                }
            } else {
                req.setAttribute("error", "ID du produit manquant.");
            }

            // Charger les catégories pour le formulaire
            List<Category> categories = categoryDAO.findAll();
            req.setAttribute("categories", categories);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("ERREUR AdminEditProductServlet: " + e.getMessage());
            req.setAttribute("error", "Erreur lors du chargement du produit: " + e.getMessage());
        }

        req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");

        try {
            String idStr = req.getParameter("id");
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String stockQuantityStr = req.getParameter("stockQuantity");
            String categoryIdStr = req.getParameter("categoryId");

            System.out.println("DEBUG AdminEditProductServlet POST: id=" + idStr + ", name=" + name);

            if (idStr != null && !idStr.isEmpty()) {
                Integer id = Integer.parseInt(idStr);
                Optional<Product> productOpt = productDAO.findById(id);
                
                if (productOpt.isPresent()) {
                    Product product = productOpt.get();
                    
                    System.out.println("DEBUG AdminEditProductServlet: Produit trouvé - ID: " + product.getId() + ", Nom actuel: " + product.getName());
                    
                    // Mettre à jour les champs - toujours mettre à jour même si null pour permettre de vider les champs
                    if (name != null) {
                        product.setName(name);
                        System.out.println("DEBUG AdminEditProductServlet: Nom mis à jour: " + name);
                    }
                    if (description != null) {
                        product.setDescription(description);
                        System.out.println("DEBUG AdminEditProductServlet: Description mise à jour");
                    }
                    
                    if (priceStr != null && !priceStr.isEmpty()) {
                        try {
                            BigDecimal newPrice = new BigDecimal(priceStr);
                            product.setPrice(newPrice);
                            System.out.println("DEBUG AdminEditProductServlet: Prix mis à jour: " + newPrice);
                        } catch (NumberFormatException e) {
                            System.err.println("Erreur format prix: " + priceStr);
                            throw new IllegalArgumentException("Format de prix invalide: " + priceStr, e);
                        }
                    }
                    
                    if (stockQuantityStr != null && !stockQuantityStr.isEmpty()) {
                        try {
                            Integer newStock = Integer.parseInt(stockQuantityStr);
                            product.setStockQuantity(newStock);
                            System.out.println("DEBUG AdminEditProductServlet: Stock mis à jour: " + newStock);
                        } catch (NumberFormatException e) {
                            System.err.println("Erreur format stock: " + stockQuantityStr);
                            throw new IllegalArgumentException("Format de stock invalide: " + stockQuantityStr, e);
                        }
                    }
                    
                    // Gérer la catégorie : si vide, retirer la catégorie, sinon la définir
                    if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                        try {
                            Integer categoryId = Integer.parseInt(categoryIdStr);
                            Optional<Category> categoryOpt = categoryDAO.findById(categoryId);
                            if (categoryOpt.isPresent()) {
                                product.setCategory(categoryOpt.get());
                                System.out.println("DEBUG AdminEditProductServlet: Catégorie mise à jour: " + categoryOpt.get().getName() + " (ID: " + categoryId + ")");
                            } else {
                                System.err.println("WARN AdminEditProductServlet: Catégorie introuvable avec ID: " + categoryId);
                                product.setCategory(null);
                            }
                        } catch (NumberFormatException e) {
                            System.err.println("Erreur format categoryId: " + categoryIdStr);
                            throw new IllegalArgumentException("Format de categoryId invalide: " + categoryIdStr, e);
                        }
                    } else {
                        // Si categoryIdStr est vide, retirer la catégorie
                        product.setCategory(null);
                        System.out.println("DEBUG AdminEditProductServlet: Catégorie retirée");
                    }
                    
                    // Afficher l'état du produit avant la sauvegarde
                    System.out.println("DEBUG AdminEditProductServlet: Avant update - Nom: " + product.getName() + 
                                     ", Prix: " + product.getPrice() + 
                                     ", Stock: " + product.getStockQuantity() + 
                                     ", Catégorie: " + (product.getCategory() != null ? product.getCategory().getName() : "null"));
                    
                    // Sauvegarder les modifications
                    productDAO.update(product);
                    System.out.println("DEBUG AdminEditProductServlet: Produit mis à jour avec succès");
                } else {
                    System.err.println("ERREUR AdminEditProductServlet: Produit introuvable avec ID: " + id);
                }
            } else {
                System.err.println("ERREUR AdminEditProductServlet: ID manquant dans la requête");
            }
        } catch (Exception e) {
            System.err.println("ERREUR AdminEditProductServlet POST: " + e.getMessage());
            e.printStackTrace();
            req.getSession().setAttribute("error", "Erreur lors de la mise à jour du produit: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}

