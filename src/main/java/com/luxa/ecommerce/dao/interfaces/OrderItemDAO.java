package com.luxa.ecommerce.dao.interfaces;

import com.luxa.ecommerce.model.OrderItem;
import java.util.List;
import java.util.Optional;

public interface OrderItemDAO {
    void save(OrderItem orderItem);
    void update(OrderItem orderItem);
    void delete(Integer id);
    Optional<OrderItem> findById(Integer id);
    List<OrderItem> findByOrderId(Integer orderId);
}





