package com.luxa.ecommerce.dao.impl;

import com.luxa.ecommerce.dao.interfaces.OrderDAO;
import com.luxa.ecommerce.model.Order;
import com.luxa.ecommerce.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public void save(Order order) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(order);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Order order) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(order);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Order order = em.find(Order.class, id);
            if (order != null) {
                em.remove(order);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Order> findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            Order order = em.find(Order.class, id);
            return Optional.ofNullable(order);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Order> query = em.createQuery("SELECT o FROM Order o ORDER BY o.orderDate DESC", Order.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order> findByUserId(Integer userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Order> query = em.createQuery(
                    "SELECT o FROM Order o WHERE o.user.id = :userId ORDER BY o.orderDate DESC", Order.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}

