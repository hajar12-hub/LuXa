package com.luxa.backend3.dao.Impl;

import java.util.List;
import java.util.Optional;

import com.luxa.backend3.dao.interfaces.ProductVariantDAO;
import com.luxa.backend3.model.ProductVariant;
import com.luxa.backend3.util.JpaUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class ProductVariantDAOImpl implements ProductVariantDAO {

    @Override
    public void save(ProductVariant variant) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(variant);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(ProductVariant variant) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(variant);
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
            ProductVariant variant = em.find(ProductVariant.class, id);
            if (variant != null) {
                em.remove(variant);
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
    public Optional<ProductVariant> findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return Optional.ofNullable(em.find(ProductVariant.class, id));
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<ProductVariant> findBySku(String sku) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<ProductVariant> query = em.createQuery(
                "SELECT v FROM ProductVariant v WHERE v.sku = :sku", ProductVariant.class);
            query.setParameter("sku", sku);
            return Optional.of(query.getSingleResult());
        } catch (NoResultException e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    @Override
    public List<ProductVariant> findByProductId(Integer productId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            
            TypedQuery<ProductVariant> query = em.createQuery(
                "SELECT v FROM ProductVariant v WHERE v.product.id = :productId", ProductVariant.class);
            query.setParameter("productId", productId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}