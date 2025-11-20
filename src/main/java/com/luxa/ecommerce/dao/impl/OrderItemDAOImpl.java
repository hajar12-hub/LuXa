package com.luxa.ecommerce.dao.impl;

import com.luxa.ecommerce.dao.interfaces.OrderItemDAO;
import com.luxa.ecommerce.model.OrderItem;
import com.luxa.ecommerce.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;

public class OrderItemDAOImpl implements OrderItemDAO {

    @Override
    public void save(OrderItem orderItem) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(orderItem);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(OrderItem orderItem) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(orderItem);
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
            OrderItem orderItem = em.find(OrderItem.class, id);
            if (orderItem != null) {
                em.remove(orderItem);
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
    public Optional<OrderItem> findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            OrderItem orderItem = em.find(OrderItem.class, id);
            return Optional.ofNullable(orderItem);
        } finally {
            em.close();
        }
    }

    @Override
    public List<OrderItem> findByOrderId(Integer orderId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<OrderItem> query = em.createQuery(
                    "SELECT oi FROM OrderItem oi WHERE oi.order.id = :orderId", OrderItem.class);
            query.setParameter("orderId", orderId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}

