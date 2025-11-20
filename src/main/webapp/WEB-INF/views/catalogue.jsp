<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'Catalogue'} - LuXa</title>
    
    <!-- CSS global -->
    <link rel="stylesheet" href="<%= ctx %>/assets/css/main.css">
    <!-- CSS spécifique catalogue -->
    <link rel="stylesheet" href="<%= ctx %>/assets/css/catalogue.css">
    
    <!-- Polices Google -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&family=Inter:wght@400;500&display=swap" rel="stylesheet">
</head>
<body style="background: #F5F0E8;">

<jsp:include page="/WEB-INF/views/_header.jsp"/>

<main class="catalogue-wrap" style="background: #F5F0E8;">
    <div class="catalogue-container">
        <!-- Sidebar Filtres -->
        <aside class="catalogue-sidebar">
            <!-- Filtre Catégories -->
            <div class="filter-section">
                <h3>Catégories</h3>
                <ul class="category-list">
                    <li class="category-item">
                        <a href="<%= ctx %>/catalogue"
                           class="category-link ${empty selectedCategoryId ? 'active' : ''}">
                            <span class="category-text">Toutes les catégories</span>
                        </a>
                    </li>
                    <c:forEach var="category" items="${categories}">
                        <li class="category-item">
                            <a href="<%= ctx %>/catalogue?category=${category.id}"
                               class="category-link ${selectedCategoryId == category.id ? 'active' : ''}">
                                    <%-- On ne montre plus l'image de la catégorie ici
                                    <c:if test="${not empty category.imageUrl}">
                                        <img src="${category.imageUrl}"
                                             alt="${category.name}"
                                             class="category-image">
                                    </c:if>
                                    --%>
                                <span class="category-text">${category.name}</span>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>


            <form method="get" action="<%= ctx %>/catalogue" id="filterForm">
                <c:if test="${not empty selectedCategoryId}">
                    <input type="hidden" name="category" value="${selectedCategoryId}">
                </c:if>
                <c:if test="${not empty searchKeyword}">
                    <input type="hidden" name="keyword" value="${fn:escapeXml(searchKeyword)}">
                </c:if>

                <!-- Filtre Prix -->
                <div class="filter-section">
                    <h4>Prix</h4>
                    <div class="price-filter">
                        <div class="price-inputs">
                            <div class="price-input-group">
                                <label>Min (MAD)</label>
                                <input type="number" 
                                       name="priceMin" 
                                       class="price-input" 
                                       placeholder="0" 
                                       min="0" 
                                       step="10"
                                       value="${selectedPriceMin != null ? selectedPriceMin : ''}">
                            </div>
                            <div class="price-input-group">
                                <label>Max (MAD)</label>
                                <input type="number" 
                                       name="priceMax" 
                                       class="price-input" 
                                       placeholder="50000" 
                                       min="0" 
                                       step="10"
                                       value="${selectedPriceMax != null ? selectedPriceMax : ''}">
                            </div>
                        </div>
                        <c:if test="${not empty priceRange}">
                            <div class="price-range">${priceRange}</div>
                        </c:if>
                    </div>
                </div>

                <!-- Filtre Matériaux/Composants -->
                <c:if test="${not empty availableMaterials}">
                    <div class="filter-section">
                        <h4>Matériaux</h4>
                        <div class="material-filter">
                            <c:forEach var="material" items="${availableMaterials}">
                                <c:set var="isSelected" value="false"/>
                                <c:forEach var="selectedMat" items="${selectedMaterials}">
                                    <c:if test="${selectedMat == material}">
                                        <c:set var="isSelected" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <div class="material-checkbox">
                                    <input type="checkbox" 
                                           name="materials" 
                                           value="${material}" 
                                           id="material_${material}"
                                           ${isSelected ? 'checked' : ''}>
                                    <label for="material_${material}">${material}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <!-- Bouton Appliquer -->
                <button type="submit" class="apply-filters-btn">Appliquer les filtres</button>
                
                <!-- Lien réinitialiser -->
                <a href="<%= ctx %>/catalogue" class="category-link" style="text-align: center; margin-top: 12px; display: block;">
                    Réinitialiser
                </a>
            </form>
        </aside>

        <!-- Zone Produits -->
        <div class="catalogue-main">
            <div class="catalogue-header">
                <h1 class="catalogue-title">Nos Produits</h1>
                <c:if test="${not empty searchKeyword}">
                    <p class="catalogue-search-summary">
                        Résultats pour "<span>${fn:escapeXml(searchKeyword)}</span>"
                    </p>
                </c:if>
                <c:if test="${not empty products}">
                    <span class="catalogue-count">${products.size()} produit${products.size() > 1 ? 's' : ''}</span>
                </c:if>
            </div>

            <c:if test="${empty products}">
                <div class="catalogue-empty">
                    <h3>Aucun produit trouvé</h3>
                    <p>Aucun produit ne correspond à vos critères de recherche.</p>
                </div>
            </c:if>

            <c:if test="${not empty products}">
                <div class="products-grid">
                    <c:forEach var="product" items="${products}">
                        <div class="product-card">
                            <div class="product-image-wrapper">
                                <c:set var="mainImage" value="${null}"/>
                                <c:if test="${not empty product.images}">
                                    <c:forEach var="image" items="${product.images}">
                                        <c:if test="${image.main != null and image.main == true}">
                                            <c:set var="mainImage" value="${image.url}"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${mainImage == null}">
                                        <c:set var="mainImage" value="${product.images[0].url}"/>
                                    </c:if>
                                </c:if>
                                
                                <%-- Préfixer le context path si l'URL commence par /images/ --%>
                                <c:if test="${not empty mainImage}">
                                    <c:choose>
                                        <c:when test="${fn:startsWith(mainImage, '/images/')}">
                                            <c:set var="mainImage" value="${pageContext.request.contextPath}${mainImage}"/>
                                        </c:when>
                                        <c:when test="${fn:startsWith(mainImage, 'images/')}">
                                            <c:set var="mainImage" value="${pageContext.request.contextPath}/${mainImage}"/>
                                        </c:when>
                                    </c:choose>
                                </c:if>

                                <a href="<%= ctx %>/product/${product.id}" class="product-image-link">
                                    <img src="${mainImage != null and not empty mainImage ? mainImage : 'https://via.placeholder.com/400x400'}" 
                                         alt="${product.name}" 
                                         class="product-image"
                                         onerror="handleImageError(this, '${mainImage}')">
                                </a>

                                <c:if test="${not empty product.category}">
                                    <span class="product-category-badge">${fn:toUpperCase(product.category.name)}</span>
                                </c:if>
                                
                                <!-- Badge de réduction (simulé pour l'affichage) -->
                                <c:set var="hasDiscount" value="true"/>
                                <c:if test="${hasDiscount}">
                                    <span class="product-discount-badge">-${(60 + (product.id % 20))}%</span>
                                </c:if>
                            </div>

                            <div class="product-card-body">
                                <h3 class="product-name">
                                    <a href="<%= ctx %>/product/${product.id}" class="product-name-link">${product.name}</a>
                                </h3>

                                <div class="product-price-section">
                                    <c:if test="${hasDiscount and not empty product.price}">
                                        <%-- Calcul du prix original (2.5x le prix actuel) en utilisant EL --%>
                                        <c:set var="priceDouble" value="${product.price}"/>
                                        <c:set var="originalPrice" value="${priceDouble * 2.5}"/>
                                        <span class="product-price-old">
                                            <fmt:formatNumber value="${originalPrice}" type="currency" currencyCode="MAD" minFractionDigits="2"/>
                                        </span>
                                    </c:if>
                                    <span class="product-price">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencyCode="MAD" minFractionDigits="2"/>
                                    </span>
                                </div>

                                <div class="product-actions">
                                    <form method="post" action="<%= ctx %>/cart/add">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn-add-cart">
                                            Ajouter au panier
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/_footer.jsp"/>

<script>
    // Fonction pour gérer les erreurs de chargement d'images
    function handleImageError(img, originalSrc) {
        if (!originalSrc || originalSrc.includes('placeholder') || originalSrc.includes('via.placeholder')) {
            img.src = 'https://via.placeholder.com/400x400';
            return;
        }
        
        // Essayer différentes extensions si l'image ne charge pas
        const extensions = ['.png', '.jpg', '.jpeg', '.gif', '.webp'];
        const lastDot = originalSrc.lastIndexOf('.');
        
        if (lastDot === -1) {
            img.src = 'https://via.placeholder.com/400x400';
            return;
        }
        
        const currentExt = originalSrc.substring(lastDot).toLowerCase();
        const basePath = originalSrc.substring(0, lastDot);
        
        // Compter les tentatives pour éviter les boucles infinies
        let retryCount = parseInt(img.dataset.retryCount || '0');
        
        // Si l'extension actuelle est déjà dans la liste, commencer après elle
        const currentExtIndex = extensions.indexOf(currentExt);
        if (currentExtIndex >= 0 && retryCount === 0) {
            retryCount = currentExtIndex + 1;
        }
        
        if (retryCount < extensions.length) {
            // Essayer la prochaine extension
            const nextExt = extensions[retryCount];
            img.dataset.retryCount = (retryCount + 1).toString();
            img.src = basePath + nextExt;
        } else {
            // Si toutes les extensions ont été essayées, utiliser le placeholder
            img.src = 'https://via.placeholder.com/400x400';
        }
    }
</script>

</body>
</html>
