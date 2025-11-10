-- =================================================================
--  E-COMMERCE ACCESSOIRES – BASE DE DONNÉES (VERSION AMÉLIORÉE)
-- =================================================================

CREATE DATABASE IF NOT EXISTS backend3_accessoires CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE backend3_accessoires;

SET NAMES utf8mb4;
SET time_zone = '+00:00';

-- ===============================
-- 1️⃣ TABLE : USERS
-- ===============================
CREATE TABLE IF NOT EXISTS users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(150),
  email VARCHAR(255) NOT NULL UNIQUE, -- AMÉLIORATION: L'email est obligatoire et doit être unique.
  password_hash VARCHAR(255),
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  role VARCHAR(50),
  address TEXT,
  phone_number VARCHAR(20),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 2️⃣ TABLE : CATEGORIES
-- ===============================
CREATE TABLE IF NOT EXISTS categories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL, -- AMÉLIORATION: Une catégorie doit avoir un nom.
  description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 3️⃣ TABLE : PRODUCTS
-- ===============================
CREATE TABLE IF NOT EXISTS products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL, -- AMÉLIORATION: Un produit doit avoir un nom.
  description TEXT,
  price DECIMAL(10,2) NOT NULL, -- AMÉLIORATION: Un produit doit avoir un prix.
  stock_quantity INT DEFAULT 0, -- AMÉLIORATION: Valeur par défaut pour éviter les NULLs.
  material VARCHAR(120),
  size_or_length VARCHAR(120),
  category_id INT,
  CONSTRAINT fk_products_category
    FOREIGN KEY (category_id) REFERENCES categories(id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 4️⃣ TABLE : PRODUCT_VARIANTS
-- ===============================
CREATE TABLE IF NOT EXISTS product_variants (
  id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT NOT NULL, -- AMÉLIORATION: Une variante doit être liée à un produit.
  sku VARCHAR(100) UNIQUE, -- AMÉLIORATION: Le SKU est un identifiant unique de stock.
  name VARCHAR(255),
  price DECIMAL(10,2),
  stock_quantity INT,
  weight_grams INT,
  color VARCHAR(100),
  size VARCHAR(100),
  material VARCHAR(120),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_variants_product
    FOREIGN KEY (product_id) REFERENCES products(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 5️⃣ TABLE : PRODUCT_IMAGES
-- ===============================
CREATE TABLE IF NOT EXISTS product_images (
  id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT NOT NULL, -- AMÉLIORATION: Une image doit être liée à un produit.
  url VARCHAR(1024) NOT NULL, -- AMÉLIORATION: L'URL est obligatoire.
  alt_text VARCHAR(255),
  position INT DEFAULT 0,
  is_main BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_prod_images_product
    FOREIGN KEY (product_id) REFERENCES products(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 6️⃣ TABLE : PROMOS
-- ===============================
CREATE TABLE IF NOT EXISTS promos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(100) NOT NULL UNIQUE, -- AMÉLIORATION: Le code est obligatoire et unique.
  discount_percentage DECIMAL(10,2) NOT NULL, -- AMÉLIORATION: Le pourcentage est obligatoire.
  start_date DATETIME,
  end_date DATETIME,
  is_active BOOLEAN DEFAULT FALSE, -- AMÉLIORATION: Valeur par défaut.
  minimum_order_amount DECIMAL(10,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 7️⃣ TABLE : ORDERS
-- ===============================
CREATE TABLE IF NOT EXISTS orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(10,2) NOT NULL, -- AMÉLIORATION: Le total est obligatoire.
  status ENUM('pending','confirmed','processing','shipped','delivered','cancelled') DEFAULT 'pending',
  shipping_address TEXT,
  billing_address TEXT,
  payment_status ENUM('pending','paid','failed','refunded') DEFAULT 'pending',
  tracking_number VARCHAR(150),
  user_id INT,
  promo_id INT,
  CONSTRAINT fk_orders_user
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_orders_promo
    FOREIGN KEY (promo_id) REFERENCES promos(id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 8️⃣ TABLE : ORDERITEM
-- ===============================
CREATE TABLE IF NOT EXISTS orderitem (
  id INT PRIMARY KEY AUTO_INCREMENT,
  quantity INT NOT NULL,
  price_at_order DECIMAL(10,2) NOT NULL,
  order_id INT NOT NULL,
  product_id INT, -- Laissé NULLable pour ON DELETE SET NULL
  CONSTRAINT fk_orderitem_order
    FOREIGN KEY (order_id) REFERENCES orders(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_orderitem_product
    FOREIGN KEY (product_id) REFERENCES products(id)
    ON DELETE SET NULL ON UPDATE CASCADE -- AMÉLIORATION: Garde l'historique si un produit est supprimé.
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 9️⃣ TABLE : CARTS
-- ===============================
CREATE TABLE IF NOT EXISTS carts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT UNIQUE, -- AMÉLIORATION: UNIQUE pour garantir la relation 1-to-1.
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_carts_user
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE ON UPDATE CASCADE -- AMÉLIORATION: Si l'user est supprimé, son panier l'est aussi.
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 🔟 TABLE : CARTITEM
-- ===============================
CREATE TABLE IF NOT EXISTS cartitem (
  id INT PRIMARY KEY AUTO_INCREMENT,
  quantity INT NOT NULL,
  cart_id INT NOT NULL,
  product_id INT NOT NULL,
  CONSTRAINT fk_cartitem_cart
    FOREIGN KEY (cart_id) REFERENCES carts(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_cartitem_product
    FOREIGN KEY (product_id) REFERENCES products(id)
    ON DELETE CASCADE ON UPDATE CASCADE -- AMÉLIORATION: Si un produit est supprimé, il disparaît des paniers.
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 11️⃣ TABLE : PAYMENTS
-- ===============================
CREATE TABLE IF NOT EXISTS payments (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  status ENUM('pending','paid','failed','refunded') DEFAULT 'pending',
  amount DECIMAL(10,2) NOT NULL,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_payments_order
    FOREIGN KEY (order_id) REFERENCES orders(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- 12️⃣ TABLE : CONTACT_MESSAGES
-- ===============================
CREATE TABLE IF NOT EXISTS contact_messages (
  id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(150),
  email VARCHAR(180),
  subject VARCHAR(200),
  message TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ===============================
-- ✅ INDEXES (OPTIMISATION)
-- ===============================
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orderitem_order ON orderitem(order_id);
CREATE INDEX idx_cart_user ON carts(user_id);
CREATE INDEX idx_cartitem_cart ON cartitem(cart_id);
CREATE INDEX idx_payments_order ON payments(order_id);

-- NOTE: L'index sur users(email) est automatiquement créé par la contrainte UNIQUE.