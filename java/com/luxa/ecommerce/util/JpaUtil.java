package com.luxa.ecommerce.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("LuXaPU");

    public static EntityManagerFactory getEmf() { return emf; }
}
