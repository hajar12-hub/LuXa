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
                    
                    // Gérer la catégorie : recharger depuis la base si nécessaire
                    if (product.getCategory() != null && product.getCategory().getId() != null) {
                        com.luxa.ecommerce.model.Category category = em.find(com.luxa.ecommerce.model.Category.class, product.getCategory().getId());
                        if (category != null) {
                            managedProduct.setCategory(category);
                        } else {
                            // La catégorie n'existe plus, la retirer
                            managedProduct.setCategory(null);
                        }
                    } else {
                        // Pas de catégorie spécifiée, la retirer
                        managedProduct.setCategory(null);
                    }
                    
                    // Les images et variants sont gérés séparément, on ne les modifie pas ici
                    // Les modifications sont automatiquement synchronisées avec la base de données au commit
                    
                    // Forcer le flush pour s'assurer que les modifications sont bien synchronisées
                    em.flush();
                    System.out.println("DEBUG ProductDAOImpl.update: Flush effectué pour le produit ID: " + product.getId());
                } else {
                    // Si le produit n'existe pas, on le crée
                    em.persist(product);
                }
            } else {
                // Si pas d'ID, on crée un nouveau produit
                em.persist(product);
            }
            
            tx.commit();
            System.out.println("DEBUG ProductDAOImpl.update: Transaction commitée avec succès pour le produit ID: " + product.getId());
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
            // Charger les produits avec leurs catégories et leurs images
            // Note: category est @ManyToOne (pas une collection), donc pas de MultipleBagFetchException
            String jpql = "SELECT DISTINCT p FROM Product p " +
                    "LEFT JOIN FETCH p.category " +
                    "LEFT JOIN FETCH p.images";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            List<Product> products = query.getResultList();
            return products;
        } catch (Exception e) {
            System.err.println("ERREUR ProductDAOImpl.findAll(): " + e.getMessage());
            e.printStackTrace();
            // En cas d'erreur (ex: MultipleBagFetchException), essayer sans les images
            try {
                String jpqlWithoutImages = "SELECT DISTINCT p FROM Product p " +
                        "LEFT JOIN FETCH p.category";
                TypedQuery<Product> queryWithoutImages = em.createQuery(jpqlWithoutImages, Product.class);
                return queryWithoutImages.getResultList();
            } catch (Exception e2) {
                System.err.println("ERREUR ProductDAOImpl.findAll() (sans images): " + e2.getMessage());
                e2.printStackTrace();
                // En dernier recours, requête simple
                try {
                    String simpleJpql = "SELECT p FROM Product p";
                    TypedQuery<Product> simpleQuery = em.createQuery(simpleJpql, Product.class);
                    return simpleQuery.getResultList();
                } catch (Exception e3) {
                    System.err.println("ERREUR ProductDAOImpl.findAll() (requête simple): " + e3.getMessage());
                    e3.printStackTrace();
                    return new java.util.ArrayList<>();
                }
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

