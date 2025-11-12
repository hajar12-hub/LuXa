package com.luxa.ecommerce.util;

import com.luxa.ecommerce.controller.cart.Cart;
import jakarta.servlet.http.HttpSession;

public final class CartUtils {
    private CartUtils(){}

    private static final String SESSION_KEY = "cart";

    public static Cart getOrCreate(HttpSession session){
        synchronized (session){
            Cart cart = (Cart) session.getAttribute(SESSION_KEY);
            if(cart == null){
                cart = new Cart();
                session.setAttribute(SESSION_KEY, cart);
            }
            return cart;
        }
    }

    // alias pour ton code existant
    public static Cart getOrCreateCart(HttpSession session){
        return getOrCreate(session);
    }

    public static void clearCart(HttpSession session){
        synchronized (session){
            session.removeAttribute(SESSION_KEY);
        }
    }
}
