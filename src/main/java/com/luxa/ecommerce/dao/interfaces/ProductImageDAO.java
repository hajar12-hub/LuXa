package com.luxa.ecommerce.dao.interfaces;

import java.util.List;
import java.util.Optional;

import com.luxa.ecommerce.model.ProductImage;

public interface ProductImageDAO {

    void save(ProductImage image);

    void update(ProductImage image);

    void delete(Integer id);

    Optional<ProductImage> findById(Integer id);

    List<ProductImage> findByProductId(Integer productId);
}
