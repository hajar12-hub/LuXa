package com.luxa.ecommerce.dao.interfaces;

import java.util.List;
import java.util.Optional;

import com.luxa.ecommerce.model.ProductVariant;

public interface ProductVariantDAO {

    void save(ProductVariant variant);

    void update(ProductVariant variant);

    void delete(Integer id);

    Optional<ProductVariant> findById(Integer id);

    Optional<ProductVariant> findBySku(String sku);

    List<ProductVariant> findByProductId(Integer productId);
}
