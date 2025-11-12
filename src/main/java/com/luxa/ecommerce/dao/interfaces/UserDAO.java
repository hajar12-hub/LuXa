package com.luxa.ecommerce.dao.interfaces;

import com.luxa.ecommerce.model.User;

public interface UserDAO {
    User findByEmail(String email);
    boolean existsByEmail(String email);
    boolean existsByUsername(String username);
    void save(User u);
    User findById(Integer id);
    void update(User u);
    boolean existsByUsernameIgnoreCase(String username);
    boolean existsByEmailIgnoreCase(String email);
}
