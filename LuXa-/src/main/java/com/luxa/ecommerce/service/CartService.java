package com.luxa.ecommerce.service;

import com.luxa.ecommerce.controller.cart.Cart;
import com.luxa.ecommerce.dao.impl.ProductDAOImpl;
import com.luxa.ecommerce.dao.interfaces.ProductDAO;
import com.luxa.ecommerce.dto.CartItemDTO;
import com.luxa.ecommerce.model.Product;
import com.luxa.ecommerce.model.ProductImage;
import java.math.BigDecimal;

public class CartService {
    private final ProductDAO productDAO = new ProductDAOImpl();

    public void add(Cart cart, int productId, int qty){
        Product p = productDAO.findById(productId)
                .orElseThrow(() -> new IllegalArgumentException("Produit introuvable"));
        int stock = p.getStockQuantity()==null ? Integer.MAX_VALUE : p.getStockQuantity();
        BigDecimal price = p.getPrice();
        String imageUrl = getMainImageUrl(p);
        var item = new CartItemDTO(p.getId(), p.getName(), price, 0, imageUrl);
        cart.add(item, qty, stock);
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
