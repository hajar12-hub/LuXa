package com.luxa.ecommerce.dao.impl;


import java.util.List;
import java.util.Optional;

import com.luxa.ecommerce.dao.interfaces.ProductImageDAO;
import com.luxa.ecommerce.model.ProductImage;
import com.luxa.ecommerce.util.JpaUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class ProductImageDAOImpl implements ProductImageDAO {

    @Override
    public void save(ProductImage image) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(image);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(ProductImage image) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(image);
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
            ProductImage image = em.find(ProductImage.class, id);
            if (image != null) {
                em.remove(image);
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
    public Optional<ProductImage> findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return Optional.ofNullable(em.find(ProductImage.class, id));
        } finally {
            em.close();
        }
    }

    @Override
    public List<ProductImage> findByProductId(Integer productId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<ProductImage> query = em.createQuery(
                    "SELECT i FROM ProductImage i WHERE i.product.id = :productId", ProductImage.class);
            query.setParameter("productId", productId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}