package com.luxa.ecommerce.dao.impl;


import java.util.List;
import java.util.Optional;

import com.luxa.ecommerce.dao.interfaces.ProductDAO;
import com.luxa.ecommerce.model.Product;
import com.luxa.ecommerce.util.JpaUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public void save(Product product) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(product);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            
            // Si le produit a un ID, on le recharge d'abord pour s'assurer qu'il est géré
            if (product.getId() != null) {
                Product managedProduct = em.find(Product.class, product.getId());
                if (managedProduct != null) {
                    // Mettre à jour les propriétés du produit géré
                    managedProduct.setName(product.getName());
                    managedProduct.setDescription(product.getDescription());
                    managedProduct.setPrice(product.getPrice());
                    managedProduct.setStockQuantity(product.getStockQuantity());
                    managedProduct.setMaterial(product.getMaterial());
                    managedProduct.setSizeOrLength(product.getSizeOrLength());
                    
                    // Gérer la catégorie : si elle existe, la recharger dans la session
                    if (product.getCategory() != null && product.getCategory().getId() != null) {
                        com.luxa.ecommerce.model.Category category = em.find(com.luxa.ecommerce.model.Category.class, product.getCategory().getId());
                        managedProduct.setCategory(category);
                    } else {
                        managedProduct.setCategory(null);
                    }
                    
                    // Les images et variants sont gérés séparément, on ne les modifie pas ici
                    // Pas besoin de merge car managedProduct est déjà géré
                } else {
                    // Si le produit n'existe pas, on le crée
                    em.persist(product);
                }
            } else {
                // Si pas d'ID, on crée un nouveau produit
                em.persist(product);
            }
            
            tx.commit();
            System.out.println("DEBUG ProductDAOImpl.update: Produit mis à jour avec succès - ID: " + product.getId());
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            System.err.println("ERREUR ProductDAOImpl.update: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-lancer l'exception pour que le servlet puisse la gérer
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
            Product product = em.find(Product.class, id);
            if (product != null) {
                em.remove(product);
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
    public Optional<Product> findById(Integer id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            // Ne charger que la catégorie pour éviter MultipleBagFetchException
            // Les images et variants seront chargés séparément si nécessaire
            String jpqlProduct = "SELECT DISTINCT p FROM Product p " +
                    "LEFT JOIN FETCH p.category " +
                    "WHERE p.id = :id";
            TypedQuery<Product> queryProduct = em.createQuery(jpqlProduct, Product.class);
            queryProduct.setParameter("id", id);
            Product product = queryProduct.getSingleResult();
            return Optional.ofNullable(product);
        } catch (NoResultException e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }


    @Override
    public List<Product> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            // Utiliser une requête simple pour éviter les problèmes avec MultipleBagFetchException
            // On charge d'abord les produits avec leurs catégories
            String jpql = "SELECT DISTINCT p FROM Product p " +
                    "LEFT JOIN FETCH p.category";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            List<Product> products = query.getResultList();
            
            // Charger les images séparément pour chaque produit si nécessaire
            // (Les images seront chargées en lazy loading si nécessaire)
            return products;
        } catch (Exception e) {
            System.err.println("ERREUR ProductDAOImpl.findAll(): " + e.getMessage());
            e.printStackTrace();
            // En cas d'erreur, essayer une requête encore plus simple
            try {
                String simpleJpql = "SELECT p FROM Product p";
                TypedQuery<Product> simpleQuery = em.createQuery(simpleJpql, Product.class);
                return simpleQuery.getResultList();
            } catch (Exception e2) {
                System.err.println("ERREUR ProductDAOImpl.findAll() (requête simple): " + e2.getMessage());
                e2.printStackTrace();
                return new java.util.ArrayList<>();
            }
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findByCategoryId(Integer categoryId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT DISTINCT p FROM Product p " +
                    "LEFT JOIN FETCH p.category " +
                    "LEFT JOIN FETCH p.images " +
                    "WHERE p.category.id = :categoryId";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setParameter("categoryId", categoryId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> search(Integer categoryId, String keyword, Double minPrice, Double maxPrice) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder(
                    "SELECT DISTINCT p FROM Product p " +
                            "LEFT JOIN FETCH p.category " +
                            "LEFT JOIN FETCH p.images WHERE 1=1");

            if (categoryId != null) {
                jpql.append(" AND p.category.id = :categoryId");
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append(" AND (LOWER(p.name) LIKE LOWER(:keyword) OR LOWER(p.description) LIKE LOWER(:keyword))");
            }
            if (minPrice != null) {
                jpql.append(" AND p.price >= :minPrice");
            }
            if (maxPrice != null) {
                jpql.append(" AND p.price <= :maxPrice");
            }

            TypedQuery<Product> query = em.createQuery(jpql.toString(), Product.class);

            if (categoryId != null) {
                query.setParameter("categoryId", categoryId);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword + "%");
            }
            if (minPrice != null) {
                query.setParameter("minPrice", minPrice);
            }
            if (maxPrice != null) {
                query.setParameter("maxPrice", maxPrice);
            }

            return query.getResultList();
        } finally {
            em.close();
        }
    }
}

