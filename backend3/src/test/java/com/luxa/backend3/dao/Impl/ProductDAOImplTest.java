package com.luxa.backend3.dao.Impl;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import com.luxa.backend3.dao.interfaces.ProductDAO;
import com.luxa.backend3.model.Category;
import com.luxa.backend3.model.Product;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ProductDAOImplTest {

    private static ProductDAO productDao;
    private static Product testProduct;

    @BeforeAll
    public static void setUp() {
        productDao = new ProductDAOImpl();
    }

    @Test
    @Order(1)
    @DisplayName("Devrait sauvegarder un nouveau produit dans la BDD")
    void testSave() {
        Category category = new Category();
        category.setId(1); 

        Product newProduct = new Product();
        newProduct.setName("Test Product JUnit");
        newProduct.setDescription("A product created for testing purposes.");
        newProduct.setPrice(99.99);
        newProduct.setStockQuantity(50);
        newProduct.setCategory(category);

        productDao.save(newProduct);
        testProduct = newProduct;

        assertNotNull(testProduct.getId());
    }

    @Test
    @Order(2)
    @DisplayName("Devrait trouver le produit par son ID")
    void testFindById() {
        Integer productId = testProduct.getId();
        Optional<Product> foundProductOpt = productDao.findById(productId);
        assertTrue(foundProductOpt.isPresent());
        assertEquals("Test Product JUnit", foundProductOpt.get().getName());
    }

    @Test
    @Order(3)
    @DisplayName("Devrait mettre à jour un produit existant")
    void testUpdate() {
        String updatedName = "Updated Product Name";
        testProduct.setName(updatedName);
        productDao.update(testProduct);

        Optional<Product> updatedProductOpt = productDao.findById(testProduct.getId());
        assertTrue(updatedProductOpt.isPresent());
        assertEquals(updatedName, updatedProductOpt.get().getName());
    }
    
    @Test
    @Order(4)
    @DisplayName("Devrait trouver tous les produits")
    void testFindAll() {
        List<Product> allProducts = productDao.findAll();
        assertNotNull(allProducts);
        assertFalse(allProducts.isEmpty());
    }

    @Test
    @Order(5)
    @DisplayName("Devrait trouver les produits par ID de catégorie")
    void testFindByCategoryId() {
        Integer categoryIdWithProducts = 1;
        List<Product> productsByCategory = productDao.findByCategoryId(categoryIdWithProducts);
        
        assertNotNull(productsByCategory);
        assertFalse(productsByCategory.isEmpty());
        
        for (Product p : productsByCategory) {
            assertEquals(categoryIdWithProducts, p.getCategory().getId());
        }
    }

    @Test
    @Order(6)
    @DisplayName("Devrait supprimer le produit de test")
    void testDelete() {
        Integer productId = testProduct.getId();
        productDao.delete(productId);
        Optional<Product> deletedProductOpt = productDao.findById(productId);
        assertFalse(deletedProductOpt.isPresent());
    }
}