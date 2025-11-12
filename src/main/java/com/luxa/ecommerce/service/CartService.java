/*package com.luxa.ecommerce.service;

import com.luxa.ecommerce.controller.cart.*;
import com.luxa.ecommerce.dao.ProductDAO;
import com.luxa.ecommerce.model.Product;
import java.math.BigDecimal;

public class CartService {
    private final ProductDAO productDAO = new ProductDAO();

    public void add(Cart cart, int productId, int qty){
        Product p = productDAO.findById(productId);
        if(p==null) throw new IllegalArgumentException("Produit introuvable");
        int stock = p.getStockQuantity()==null ? Integer.MAX_VALUE : p.getStockQuantity();
        BigDecimal price = p.getPrice();
        var item = new CartItemDTO(p.getId(), p.getName(), price, 0, null);
        cart.add(item, qty, stock);
    }
    public void update(Cart cart, int productId, int qty){
        Product p = productDAO.findById(productId); if(p==null) return;
        int stock = p.getStockQuantity()==null ? Integer.MAX_VALUE : p.getStockQuantity();
        cart.update(productId, qty, stock);
    }
    public void remove(Cart cart, int productId){ cart.remove(productId); }
    public void clear(Cart cart){ cart.clear(); }
}*/
