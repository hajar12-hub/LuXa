package com.luxa.ecommerce.dao.interfaces;

import com.luxa.ecommerce.model.Order;
import java.util.List;
import java.util.Optional;

public interface OrderDAO {
    void save(Order order);
    void update(Order order);
    void delete(Integer id);
    Optional<Order> findById(Integer id);
    List<Order> findAll();
    List<Order> findByUserId(Integer userId);
}





