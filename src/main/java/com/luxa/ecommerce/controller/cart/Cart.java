package com.luxa.ecommerce.controller.cart;

import com.luxa.ecommerce.dto.CartItemDTO;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

public class Cart implements Serializable {

    public static class Line implements Serializable {
        private final CartItemDTO item;
        private int qty;

        public Line(CartItemDTO item, int qty){
            this.item = item;
            this.qty = Math.max(0, qty);
        }
        public CartItemDTO getItem(){ return item; }
        public int getQty(){ return qty; }
        public void setQty(int qty){ this.qty = Math.max(0, qty); }

        public BigDecimal getLineTotal(){
            return item.getEffectiveUnitPrice()
                    .multiply(BigDecimal.valueOf(qty))
                    .setScale(2, RoundingMode.HALF_UP);
        }
    }

    // key = productId
    private final Map<Integer, Line> lines = new LinkedHashMap<>();

    public Collection<Line> getLines(){ return lines.values(); }

    public void add(CartItemDTO item, int qty, int stock){
        Line l = lines.get(item.getId());
        int newQty = (l == null ? 0 : l.getQty()) + Math.max(0, qty);
        if(stock != Integer.MAX_VALUE) newQty = Math.min(newQty, Math.max(0, stock));
        if(l == null){
            lines.put(item.getId(), new Line(item, newQty));
        } else {
            l.setQty(newQty);
        }
        if(newQty == 0) lines.remove(item.getId());
    }

    public void update(int productId, int qty, int stock){
        Line l = lines.get(productId);
        if(l == null) return;
        int newQty = Math.max(0, qty);
        if(stock != Integer.MAX_VALUE) newQty = Math.min(newQty, stock);
        l.setQty(newQty);
        if(newQty == 0) lines.remove(productId);
    }

    public void remove(int productId){ lines.remove(productId); }
    public void clear(){ lines.clear(); }

    public BigDecimal getSubtotal(){
        return lines.values().stream()
                .map(Line::getLineTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add)
                .setScale(2, RoundingMode.HALF_UP);
    }

    // Hook pour coupons / taxes plus tard
    public BigDecimal getTotal(){ return getSubtotal(); }
    public boolean isEmpty(){ return lines.isEmpty(); }
}
