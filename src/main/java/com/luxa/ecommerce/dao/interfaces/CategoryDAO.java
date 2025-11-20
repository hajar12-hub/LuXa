package com.luxa.ecommerce.dao.interfaces;

import com.luxa.ecommerce.model.Category;
import java.util.List;
import java.util.Optional;

public interface CategoryDAO {

    void save(Category category);

    void update(Category category);

    void delete(Integer id);

    Optional<Category> findById(Integer id);

    List<Category> findAll();
}