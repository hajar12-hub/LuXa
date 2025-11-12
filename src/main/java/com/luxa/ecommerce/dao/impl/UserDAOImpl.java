package com.luxa.ecommerce.dao.impl;

import com.luxa.ecommerce.dao.interfaces.UserDAO;
import com.luxa.ecommerce.model.User;
import com.luxa.ecommerce.util.JpaUtil;
import jakarta.persistence.*;

public class UserDAOImpl implements UserDAO {

    @Override
    public User findByEmail(String email){
        EntityManager em = JpaUtil.getEmf().createEntityManager();
        try {
            return em.createQuery(
                            "SELECT u FROM User u WHERE u.email = :e", User.class)
                    .setParameter("e", email)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally { em.close(); }
    }

    @Override
    public boolean existsByEmail(String email){
        EntityManager em = JpaUtil.getEmf().createEntityManager();
        try {
            Long c = em.createQuery("select count(u) from User u where u.email = :e", Long.class)
                    .setParameter("e", email)
                    .getSingleResult();
            return c > 0;
        } finally { em.close(); }
    }

    @Override
    public boolean existsByUsername(String username){
        EntityManager em = JpaUtil.getEmf().createEntityManager();
        try {
            Long c = em.createQuery("select count(u) from User u where u.username = :u", Long.class)
                    .setParameter("u", username)
                    .getSingleResult();
            return c > 0;
        } finally { em.close(); }
    }

    @Override
    public void save(User u){
        EntityManager em = JpaUtil.getEmf().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(u);
            tx.commit();
        } catch(Exception e){
            if(tx.isActive()) tx.rollback();
            throw e;
        } finally { em.close(); }
    }

    @Override
    public User findById(Integer id){
        EntityManager em = JpaUtil.getEmf().createEntityManager();
        try {
            return em.find(User.class, id);
        } finally { em.close(); }
    }

    @Override
    public void update(User u){
        EntityManager em = JpaUtil.getEmf().createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(u);
            tx.commit();
        } catch(Exception e){
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally { em.close(); }
    }

    @Override
    public boolean existsByUsernameIgnoreCase(String username){
        EntityManager em = JpaUtil.getEmf().createEntityManager();
        try {
            Long c = em.createQuery(
                            "select count(u) from User u where lower(u.username)=:x", Long.class)
                    .setParameter("x", username.toLowerCase())
                    .getSingleResult();
            return c != null && c > 0;
        } finally { em.close(); }
    }

    @Override
    public boolean existsByEmailIgnoreCase(String email){
        EntityManager em = JpaUtil.getEmf().createEntityManager();
        try {
            Long c = em.createQuery(
                            "select count(u) from User u where lower(u.email)=:x", Long.class)
                    .setParameter("x", email.toLowerCase())
                    .getSingleResult();
            return c != null && c > 0;
        } finally { em.close(); }
    }
}
