package com.luxa.ecommerce.service;

import com.luxa.ecommerce.controller.cart.Cart;
import com.luxa.ecommerce.dao.impl.ProductDAOImpl;
import com.luxa.ecommerce.dao.impl.ProductImageDAOImpl;
import com.luxa.ecommerce.dao.interfaces.ProductDAO;
import com.luxa.ecommerce.dao.interfaces.ProductImageDAO;
import com.luxa.ecommerce.dto.CartItemDTO;
import com.luxa.ecommerce.model.Product;
import com.luxa.ecommerce.model.ProductImage;
import java.math.BigDecimal;
import java.util.List;

public class CartService {
    private final ProductDAO productDAO = new ProductDAOImpl();
    private final ProductImageDAO productImageDAO = new ProductImageDAOImpl();

    public void add(Cart cart, int productId, int qty){
        try {
            Product p = productDAO.findById(productId)
                    .orElseThrow(() -> new IllegalArgumentException("Produit introuvable"));
            
            // Charger les images explicitement pour éviter LazyInitializationException
            try {
                List<ProductImage> images = productImageDAO.findByProductId(p.getId());
                p.setImages(images);
            } catch (Exception ex) {
                System.err.println("Erreur lors du chargement des images pour le produit " + p.getId() + ": " + ex.getMessage());
                p.setImages(new java.util.ArrayList<>());
            }
            
            int stock = p.getStockQuantity()==null ? Integer.MAX_VALUE : p.getStockQuantity();
            BigDecimal price = p.getPrice();
            String imageUrl = getMainImageUrl(p);
            var item = new CartItemDTO(p.getId(), p.getName(), price, 0, imageUrl);
            cart.add(item, qty, stock);
        } catch (Exception e) {
            System.err.println("ERREUR CartService.add: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de l'ajout au panier: " + e.getMessage(), e);
        }
    }

    private String getMainImageUrl(Product product) {
        if (product.getImages() == null || product.getImages().isEmpty()) {
            return null;
        }
        return product.getImages().stream()
                .filter(img -> img.getMain() != null && img.getMain())
                .findFirst()
                .map(ProductImage::getUrl)
                .orElse(product.getImages().get(0).getUrl());
    }

    public void update(Cart cart, int productId, int qty){
        Product p = productDAO.findById(productId).orElse(null);
        if(p == null) return;
        int stock = p.getStockQuantity()==null ? Integer.MAX_VALUE : p.getStockQuantity();
        cart.update(productId, qty, stock);
    }

    public void remove(Cart cart, int productId){
        cart.remove(productId);
    }

    public void clear(Cart cart){
        cart.clear();
    }
}
