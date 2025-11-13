/*package com.luxa.ecommerce.cart;

import java.math.BigDecimal;

public class CartItemDTO {
    private Integer productId;
    private String name;
    private BigDecimal unitPrice;
    private int qty;
    private String imageUrl; // optionnel

    public CartItemDTO(Integer productId, String name, BigDecimal unitPrice, int qty, String imageUrl) {
        this.productId = productId; this.name = name; this.unitPrice = unitPrice;
        this.qty = qty; this.imageUrl = imageUrl;
    }
    public Integer getProductId(){return productId;}
    public String getName(){return name;}
    public BigDecimal getUnitPrice(){return unitPrice;}
    public int getQty(){return qty;}
    public void setQty(int qty){this.qty = qty;}
    public BigDecimal lineTotal(){return unitPrice.multiply(BigDecimal.valueOf(qty));}
}*/
