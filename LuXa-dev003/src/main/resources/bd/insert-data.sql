-- =================================================================
--  SCRIPT D'INSERTION DE DONNÉES (VERSION AJUSTÉE)
-- =================================================================

-- Pour un redémarrage propre, on vide les tables.
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM cartitem;
DELETE FROM carts;
DELETE FROM orderitem;
DELETE FROM payments;
DELETE FROM orders;
DELETE FROM product_images;
DELETE FROM product_variants;
DELETE FROM products;
DELETE FROM categories;
DELETE FROM promos;
DELETE FROM users;
DELETE FROM contact_messages;
SET FOREIGN_KEY_CHECKS = 1;

-- ===============================
-- 1️⃣ INSERTION : CATEGORIES
-- ===============================
INSERT INTO categories (id, name, description)
VALUES
(1, 'Joaillerie', 'Bijoux de luxe, bagues, colliers et bracelets.'),
(2, 'Montres', 'Montres automatiques et de luxe pour hommes et femmes.'),
(3, 'Lunettes', 'Lunettes de soleil de créateur, montures de luxe.');

-- ===============================
-- 2️⃣ INSERTION : PRODUCTS
-- ===============================
-- Joaillerie
INSERT INTO products (id, name, description, price, stock_quantity, material, category_id)
VALUES
(1, 'Collier Étoile d’Or', 'Collier délicat en or 18 carats orné d’un pendentif en forme d’étoile.', 1250.00, 5, 'Or 18K', 1),
(2, 'Bracelet Perles Élégantes', 'Bracelet raffiné composé de perles naturelles et fermoir doré.', 980.00, 7, 'Perles et Or', 1),
(3, 'Bague Lune Argentée', 'Bague en argent massif avec pierre de lune naturelle.', 750.00, 6, 'Argent', 1),
(4, 'Boucles Cristal Céleste', 'Boucles d’oreilles serties de cristaux étincelants inspirés du ciel nocturne.', 650.00, 8, 'Cristal et Argent', 1),
(5, 'Collier Élégance Royale', 'Pièce majestueuse combinant or rose et pierres fines.', 2100.00, 4, 'Or Rose', 1),
(6, 'Bracelet Infini', 'Symbole d’éternité, ce bracelet en or jaune représente l’amour sans fin.', 890.00, 9, 'Or Jaune', 1),
(7, 'Bague Cœur Rubis', 'Bague romantique sertie d’un rubis en forme de cœur.', 1350.00, 5, 'Or Blanc', 1),
(8, 'Boucles Perles d’Aube', 'Élégantes boucles avec perles nacrées et finitions argentées.', 720.00, 10, 'Perles et Argent', 1),
(9, 'Collier Harmonie', 'Alliance parfaite de diamants et d’or blanc, symbole d’équilibre.', 2450.00, 3, 'Or Blanc et Diamant', 1),
(10, 'Bracelet Minimal Chic', 'Design épuré pour un style moderne et raffiné.', 560.00, 12, 'Or Rose', 1);

-- Montres
INSERT INTO products (id, name, description, price, stock_quantity, material, category_id)
VALUES
(11, 'Montre Célestia', 'Montre élégante à cadran bleu profond et bracelet en cuir.', 1850.00, 6, 'Acier et Cuir', 2),
(12, 'Montre Argent Vintage', 'Style rétro avec cadran rond et boîtier argenté poli.', 1450.00, 5, 'Acier', 2),
(13, 'Montre Solaire Or Rose', 'Fonctionne à l’énergie solaire avec un design féminin moderne.', 1720.00, 7, 'Or Rose et Cuir', 2),
(14, 'Montre Sport Chrono', 'Chronographe robuste avec résistance à l’eau jusqu’à 100 m.', 1350.00, 8, 'Acier', 2),
(15, 'Montre Noire Élégance', 'Design minimaliste noir mat, parfait pour les tenues formelles.', 1990.00, 6, 'Acier', 2),
(16, 'Montre Lunaire Argentée', 'Phase de lune visible, boîtier en acier inoxydable.', 2200.00, 4, 'Acier', 2),
(17, 'Montre Connectée Luxe', 'Technologie moderne dans un corps de montre traditionnelle.', 2450.00, 5, 'Acier et Cuir', 2),
(18, 'Montre Océan Bleu', 'Inspirée de la mer, bracelet bleu et cadran argent.', 1600.00, 7, 'Acier et Cuir', 2),
(19, 'Montre Quartz Dorée', 'Mécanisme précis, boîtier doré et cadran nacré.', 1280.00, 9, 'Acier Doré', 2),
(20, 'Montre Automatique Prestige', 'Système automatique visible à travers le fond transparent.', 3100.00, 3, 'Acier', 2);

-- Lunettes
INSERT INTO products (id, name, description, price, stock_quantity, material, category_id)
VALUES
(21, 'Lunettes Soleil Riviera', 'Monture dorée et verres bruns dégradés, style estival.', 490.00, 12, 'Métal', 3),
(22, 'Lunettes Vision Noire', 'Monture noire épaisse, style rétro chic.', 420.00, 10, 'Acétate', 3),
(23, 'Lunettes Aviator Argent', 'Classiques intemporelles à monture argentée.', 580.00, 8, 'Métal', 3),
(24, 'Lunettes Cat Eyes Rose', 'Monture en œil de chat avec reflets rosés et modernes.', 530.00, 9, 'Acétate', 3),
(25, 'Lunettes Transparence', 'Design épuré avec monture transparente et légère.', 460.00, 10, 'Acétate', 3),
(26, 'Lunettes Carrées Chic', 'Monture carrée minimaliste adaptée aux visages fins.', 510.00, 7, 'Acétate', 3),
(27, 'Lunettes Solaires Polarisées', 'Protection UV400 avec monture métallique.', 590.00, 11, 'Métal', 3),
(28, 'Lunettes Classique Beige', 'Monture beige douce, parfaite pour un look neutre.', 440.00, 12, 'Acétate', 3),
(29, 'Lunettes Rondes Dorées', 'Style rétro doré avec verres légèrement teintés.', 560.00, 8, 'Métal', 3),
(30, 'Lunettes Futuristes Noires', 'Design audacieux avec finition miroir noir brillant.', 620.00, 6, 'Acétate et Métal', 3);

-- ===============================
-- 3️⃣ INSERTION : PRODUCT_IMAGES
-- ===============================
INSERT INTO product_images (product_id, url, alt_text, is_main)
VALUES
-- Joaillerie
(1, '/images/bg1.png', 'Collier Étoile d’Or', TRUE),
(2, '/images/joaillerie/bracelet-perles.jpg', 'Bracelet Perles Élégantes', TRUE),
(3, '/images/joaillerie/bague-lune.jpg', 'Bague Lune Argentée', TRUE),
(4, '/images/joaillerie/boucles-cristal.jpg', 'Boucles Cristal Céleste', TRUE),
(5, '/images/joaillerie/collier-royal.jpg', 'Collier Élégance Royale', TRUE),
(6, '/images/joaillerie/bracelet-infini.jpg', 'Bracelet Infini', TRUE),
(7, '/images/joaillerie/bague-rubis.jpg', 'Bague Cœur Rubis', TRUE),
(8, '/images/joaillerie/boucles-perles-aube.jpg', 'Boucles Perles d’Aube', TRUE),
(9, '/images/joaillerie/collier-harmonie.jpg', 'Collier Harmonie', TRUE),
(10, '/images/joaillerie/bracelet-minimal.jpg', 'Bracelet Minimal Chic', TRUE),

-- Montres
(11, '/images/montres/celestia.jpg', 'Montre Célestia', TRUE),
(12, '/images/montres/vintage.jpg', 'Montre Argent Vintage', TRUE),
(13, '/images/montres/solaire.jpg', 'Montre Solaire Or Rose', TRUE),
(14, '/images/montres/sport.jpg', 'Montre Sport Chrono', TRUE),
(15, '/images/montres/noire.jpg', 'Montre Noire Élégance', TRUE),
(16, '/images/montres/lunaire.jpg', 'Montre Lunaire Argentée', TRUE),
(17, '/images/montres/connectee.jpg', 'Montre Connectée Luxe', TRUE),
(18, '/images/montres/ocean.jpg', 'Montre Océan Bleu', TRUE),
(19, '/images/montres/quartz.jpg', 'Montre Quartz Dorée', TRUE),
(20, '/images/montres/prestige.jpg', 'Montre Automatique Prestige', TRUE),

-- Lunettes
(21, '/images/lunettes/riviera.jpg', 'Lunettes Soleil Riviera', TRUE),
(22, '/images/lunettes/vision-noire.jpg', 'Lunettes Vision Noire', TRUE),
(23, '/images/lunettes/aviator.jpg', 'Lunettes Aviator Argent', TRUE),
(24, '/images/lunettes/cateyes.jpg', 'Lunettes Cat Eyes Rose', TRUE),
(25, '/images/lunettes/transparente.jpg', 'Lunettes Transparence', TRUE),
(26, '/images/lunettes/carre.jpg', 'Lunettes Carrées Chic', TRUE),
(27, '/images/lunettes/polarisees.jpg', 'Lunettes Solaires Polarisées', TRUE),
(28, '/images/lunettes/beige.jpg', 'Lunettes Classique Beige', TRUE),
(29, '/images/lunettes/rondes.jpg', 'Lunettes Rondes Dorées', TRUE),
(30, '/images/lunettes/futuristes.jpg', 'Lunettes Futuristes Noires', TRUE);

-- ===============================
-- Finalisation
-- ===============================
ALTER TABLE categories AUTO_INCREMENT = 4;
ALTER TABLE products AUTO_INCREMENT = 31;
ALTER TABLE product_images AUTO_INCREMENT = 31;

SELECT 'Données de test ajustées et insérées avec succès.' AS message;
