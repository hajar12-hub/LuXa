package com.luxa.ecommerce.dao.interfaces;

import java.util.List;
import java.util.Optional;

import com.luxa.ecommerce.model.Product;

public interface ProductDAO {

    void save(Product product);

    void update(Product product);

    void delete(Integer id);

    Optional<Product> findById(Integer id);

    List<Product> findAll();

    List<Product> findByCategoryId(Integer categoryId);

    List<Product> search(Integer categoryId, String keyword, Double minPrice, Double maxPrice);
}