package com.luxa.ecommerce.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "carts")
public class Carts {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // Relation optionnelle vers User
    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = true)
    private User user;

    @Column(name = "created_date")
    private LocalDateTime createdDate;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Relation avec les éléments du panier
    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CartItem> items;

    // --- Constructeurs --

    // --- Getters / Setters ---
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public LocalDateTime getCreatedDate() { return createdDate; }
    public void setCreatedDate(LocalDateTime createdDate) { this.createdDate = createdDate; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public List<CartItem> getItems() { return items; }
    public void setItems(List<CartItem> items) { this.items = items; }
}
