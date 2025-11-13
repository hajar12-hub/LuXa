# Configuration de la Base de Données MySQL - LuXa

## ⚠️ IMPORTANT : Configuration requise avant de lancer l'application

### 1. Vérifier que MySQL est installé et démarré

Assurez-vous que MySQL est installé et que le service est en cours d'exécution.

### 2. Créer la base de données

Exécutez le script SQL suivant dans MySQL (via MySQL Workbench, phpMyAdmin, ou la ligne de commande) :

```sql
-- Ouvrir MySQL et exécuter le fichier :
src/main/resources/bd/shema.sql
```

Ou manuellement :
```sql
CREATE DATABASE IF NOT EXISTS backend3_accessoires CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE backend3_accessoires;
```

Puis exécutez le contenu complet de `shema.sql` pour créer toutes les tables.

### 3. Insérer les données de test (optionnel)

Pour avoir des données de test :
```sql
-- Exécuter le fichier :
src/main/resources/bd/insert-data.sql
```

### 4. Configurer les identifiants MySQL dans persistence.xml

**Fichier à modifier :** `src/main/resources/META-INF/persistence.xml`

**Lignes à modifier (lignes 29-30) :**
```xml
<property name="jakarta.persistence.jdbc.user" value="root"/>
<property name="jakarta.persistence.jdbc.password" value="VOTRE_MOT_DE_PASSE"/>
```

**Remplacez :**
- `root` par votre nom d'utilisateur MySQL (si différent)
- `VOTRE_MOT_DE_PASSE` par votre mot de passe MySQL

**Exemples :**
- Si votre MySQL n'a pas de mot de passe : `value=""`
- Si votre mot de passe est `monpassword123` : `value="monpassword123"`
- Si votre utilisateur est `luxa_user` : `value="luxa_user"`

### 5. Vérifier la connexion

Après avoir modifié `persistence.xml`, redémarrez l'application. Si vous obtenez toujours une erreur "Access denied", vérifiez :

1. **Le mot de passe MySQL est correct** dans `persistence.xml`
2. **L'utilisateur MySQL a les droits** sur la base `backend3_accessoires`
3. **MySQL écoute sur le port 3306** (par défaut)
4. **La base de données existe** et contient les tables

### 6. Tester la connexion manuellement (optionnel)

Vous pouvez tester la connexion avec cette commande MySQL :
```bash
mysql -u root -p backend3_accessoires
```

Si cela fonctionne, utilisez les mêmes identifiants dans `persistence.xml`.

---

## 📝 Résumé des fichiers importants

- **Schéma de base de données :** `src/main/resources/bd/shema.sql`
- **Données de test :** `src/main/resources/bd/insert-data.sql`
- **Configuration JPA :** `src/main/resources/META-INF/persistence.xml`

## 🔧 Nom de la base de données

Le nom de la base de données utilisé est : **`backend3_accessoires`**

Ce nom doit être identique dans :
- `shema.sql` (ligne 5)
- `persistence.xml` (ligne 27, dans l'URL JDBC)

