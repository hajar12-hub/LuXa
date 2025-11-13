/*package com.luxa.ecommerce.util;

import java.math.BigDecimal;
import java.util.*;

public class Cart {
    private final Map<Integer, CartItemDTO> items = new LinkedHashMap<>();
    public Collection<CartItemDTO> getItems(){ return items.values(); }
    public int getCount(){ return items.values().stream().mapToInt(CartItemDTO::getQty).sum(); }
    public BigDecimal getSubtotal(){
        return items.values().stream().map(CartItemDTO::lineTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
    public void add(CartItemDTO item, int qtyToAdd, int maxStock){
        var ex = items.get(item.getProductId());
        int newQty = (ex==null?0:ex.getQty()) + qtyToAdd;
        if(newQty<1) newQty=1;
        if(maxStock>0 && newQty>maxStock) newQty=maxStock;
        if(ex==null){ item.setQty(newQty); items.put(item.getProductId(), item); }
        else { ex.setQty(newQty); }
    }
    public void update(Integer productId, int qty, int maxStock){
        var it = items.get(productId); if(it==null) return;
        if(qty<1) qty=1; if(maxStock>0 && qty>maxStock) qty=maxStock; it.setQty(qty);
    }
    public void remove(Integer productId){ items.remove(productId); }
    public void clear(){ items.clear(); }
}*/
