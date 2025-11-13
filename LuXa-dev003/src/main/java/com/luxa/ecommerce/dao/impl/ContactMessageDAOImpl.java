package com.luxa.ecommerce.dao.impl;

import com.luxa.ecommerce.dao.interfaces.ContactMessageDAO;
import com.luxa.ecommerce.model.ContactMessage;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;
import java.util.Optional;

import com.luxa.ecommerce.dao.interfaces.CategoryDAO;
import com.luxa.ecommerce.model.Category;
import com.luxa.ecommerce.util.JpaUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class ContactMessageDAOImpl implements ContactMessageDAO {

    // Même logique que ton DAO actuel : EMF statique créé depuis "LuXaPU"
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("LuXaPU"); // ← même nom que dans persistence.xml

    private EntityManager em() { return emf.createEntityManager(); }

    @Override
    public void save(ContactMessage m) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            em.persist(m);
            em.getTransaction().commit();
        } finally { em.close(); }
    }

    @Override
    public List<ContactMessage> findLatest(int max) {
        EntityManager em = em();
        try {
            return em.createQuery(
                    "SELECT m FROM ContactMessage m ORDER BY m.createdAt DESC",
                    ContactMessage.class
            ).setMaxResults(max).getResultList();
        } finally { em.close(); }
    }
}
