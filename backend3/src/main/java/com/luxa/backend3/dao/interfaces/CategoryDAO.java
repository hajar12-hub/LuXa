package com.luxa.backend3.dao.interfaces;

import java.util.List;
import java.util.Optional;

import com.luxa.backend3.model.Category;

public interface CategoryDAO {

    void save(Category category);

    void update(Category category);

    void delete(Integer id);

    Optional<Category> findById(Integer id);

    List<Category> findAll();
}