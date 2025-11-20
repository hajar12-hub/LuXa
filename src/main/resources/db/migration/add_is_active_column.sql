-- Script SQL pour ajouter la colonne is_active à la table products
-- Exécutez ce script si la colonne n'existe pas encore dans votre base de données

-- Pour MySQL/MariaDB
ALTER TABLE products 
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;

-- Si la commande IF NOT EXISTS n'est pas supportée, utilisez :
-- ALTER TABLE products ADD COLUMN is_active BOOLEAN DEFAULT TRUE;

-- Mettre à jour les produits existants pour qu'ils soient actifs par défaut
UPDATE products SET is_active = TRUE WHERE is_active IS NULL;

