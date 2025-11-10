package com.luxa.ecommerce.dao;


import com.luxa.ecommerce.model.ContactMessage;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public class ContactMessageDAO {
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("LuXaPU"); // ← même nom que dans persistence.xml

    private EntityManager em() { return emf.createEntityManager(); }

    public void save(ContactMessage m) {
        EntityManager em = em();
        try {
            em.getTransaction().begin();
            em.persist(m);
            em.getTransaction().commit();
        } finally { em.close(); }
    }

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
