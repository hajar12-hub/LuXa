package com.luxa.ecommerce.controller.admin;

import com.luxa.ecommerce.dao.impl.ProductDAOImpl;
import com.luxa.ecommerce.dao.impl.ProductImageDAOImpl;
import com.luxa.ecommerce.dao.interfaces.ProductDAO;
import com.luxa.ecommerce.dao.interfaces.ProductImageDAO;
import com.luxa.ecommerce.model.Product;
import com.luxa.ecommerce.model.ProductImage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "AdminProductImagesServlet", urlPatterns = {"/admin/products/images"})
public class AdminProductImagesServlet extends HttpServlet {

    private ProductDAO productDAO;
    private ProductImageDAO productImageDAO;

    @Override
    public void init() throws ServletException {
        this.productDAO = new ProductDAOImpl();
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
                    req.setAttribute("product", product);
                } else {
                    req.setAttribute("error", "Produit introuvable.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du chargement des images.");
        }

        req.getRequestDispatcher("/WEB-INF/views/admin/product-images.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");

        try {
            String productIdStr = req.getParameter("productId");
            String imageUrl = req.getParameter("imageUrl");
            String action = req.getParameter("action");

            if ("add".equals(action) && productIdStr != null && imageUrl != null && !imageUrl.isEmpty()) {
                Integer productId = Integer.parseInt(productIdStr);
                Optional<Product> productOpt = productDAO.findById(productId);
                
                if (productOpt.isPresent()) {
                    ProductImage image = new ProductImage();
                    image.setProduct(productOpt.get());
                    image.setUrl(imageUrl);
                    productImageDAO.save(image);
                }
            } else if ("delete".equals(action)) {
                String imageIdStr = req.getParameter("imageId");
                if (imageIdStr != null && !imageIdStr.isEmpty()) {
                    productImageDAO.delete(Integer.parseInt(imageIdStr));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String productId = req.getParameter("productId");
        resp.sendRedirect(req.getContextPath() + "/admin/products/images?id=" + productId);
    }
}

