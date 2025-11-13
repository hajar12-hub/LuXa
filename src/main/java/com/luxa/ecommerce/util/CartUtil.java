/*package com.luxa.ecommerce.util;

import jakarta.servlet.http.HttpSession;

public final class CartUtil {
    private CartUtils(){}
    public static final String CART_KEY = "CART";
    public static Cart getOrCreate(HttpSession session){
        Cart c = (Cart) session.getAttribute(CART_KEY);
        if(c==null){ c = new Cart(); session.setAttribute(CART_KEY, c); }
        return c;
    }
}*/