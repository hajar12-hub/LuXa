package com.luxa.ecommerce.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Objects;

public class CartItemDTO implements Serializable {
    private final int id;
    private final String name;
    private final BigDecimal unitPrice;
    private final int discountPercent;
    private final String imageUrl;

    public CartItemDTO(int id, String name, BigDecimal unitPrice, int discountPercent, String imageUrl) {
        this.id = id;
        this.name = name;
        this.unitPrice = unitPrice == null ? BigDecimal.ZERO : unitPrice;
        this.discountPercent = Math.max(0, discountPercent);
        this.imageUrl = imageUrl;
    }

    public int getId(){ return id; }
    public String getName(){ return name; }
    public BigDecimal getUnitPrice(){ return unitPrice; }
    public int getDiscountPercent(){ return discountPercent; }
    public String getImageUrl(){ return imageUrl; }

    public BigDecimal getEffectiveUnitPrice(){
        if (discountPercent <= 0) return unitPrice.setScale(2, RoundingMode.HALF_UP);
        BigDecimal factor = BigDecimal.valueOf(100 - discountPercent).movePointLeft(2);
        return unitPrice.multiply(factor).setScale(2, RoundingMode.HALF_UP);
    }

    @Override public boolean equals(Object o){ return (o instanceof CartItemDTO c) && c.id == id; }
    @Override public int hashCode(){ return Objects.hash(id); }
}
