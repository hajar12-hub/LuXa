package com.luxa.ecommerce.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;


@Entity  // Dit à Hibernate : "Cette classe est une entité à sauvegarder"
@Table(name = "users") //associé a cette table
public class User {

    // ✅ ID
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // ✅ NOM D’UTILISATEUR
    @Column(length = 150, nullable = false, unique = true)
    private String username;

    // ✅ EMAIL
    @Column(length = 255, nullable = false, unique = true)
    private String email;

    // ✅ MOT DE PASSE HASHÉ
    @Column(name = "password_hash", length = 255, nullable = false)
    private String passwordHash;

    // ✅ PRENOM
    @Column(name = "first_name", length = 100)
    private String firstName;

    // ✅ NOM
    @Column(name = "last_name", length = 100)
    private String lastName;

    // ✅ ROLE
    @Column(length = 50)
    private String role = "USER";

    // ✅ ADRESSE (TEXT)
    @Column(columnDefinition = "TEXT")
    private String address;

    // ✅ NUMÉRO DE TÉLÉPHONE
    @Column(name = "phone_number", length = 50)
    private String phoneNumber;

    // ✅ DATE DE CREATION
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // ✅ Auto-assignation de created_at
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    @Enumerated(EnumType.STRING)
    @Column(
            columnDefinition = "ENUM('ACTIVE','INACTIVE','PENDING','SUSPENDED','DELETED')",
            nullable = false
    )
    private Status status = Status.ACTIVE; // valeur par défaut côté Java (en plus du DEFAULT SQL)

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }



    // ✅ ---------- GETTERS & SETTERS ----------

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
