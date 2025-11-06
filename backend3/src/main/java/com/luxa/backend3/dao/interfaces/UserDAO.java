package com.luxa.backend3.dao.interfaces;

import java.util.List;
import java.util.Optional;

import com.luxa.backend3.model.User;

public interface UserDAO {
    void save(User user);
    void update(User user);
    void delete(Integer id);
    Optional<User> findById(Integer id);
    Optional<User> findByEmail(String email);
    List<User> findAll();
}