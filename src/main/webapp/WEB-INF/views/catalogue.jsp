<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<jsp:include page="partials/_header.jsp"/>

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
                            Toutes les catégories
                        </a>
                    </li>
                    <c:forEach var="category" items="${categories}">
                        <li class="category-item">
                            <a href="<%= ctx %>/catalogue?category=${category.id}" 
                               class="category-link ${selectedCategoryId == category.id ? 'active' : ''}">
                                ${category.name}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <form method="get" action="<%= ctx %>/catalogue" id="filterForm">
                <c:if test="${not empty selectedCategoryId}">
                    <input type="hidden" name="category" value="${selectedCategoryId}">
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
                                <c:forEach var="image" items="${product.images}">
                                    <c:if test="${image.main}">
                                        <c:set var="mainImage" value="${image.url}"/>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${mainImage == null and not empty product.images}">
                                    <c:set var="mainImage" value="${product.images[0].url}"/>
                                </c:if>

                                <a href="<%= ctx %>/product/${product.id}" class="product-image-link">
                                    <img src="${mainImage != null ? mainImage : 'https://via.placeholder.com/400x400'}" 
                                         alt="${product.name}" 
                                         class="product-image">
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
                                    <c:if test="${hasDiscount}">
                                        <%
                                            // Calcul du prix original (2.5x le prix actuel pour simuler une réduction)
                                            com.luxa.ecommerce.model.Product p = (com.luxa.ecommerce.model.Product) pageContext.getAttribute("product");
                                            java.math.BigDecimal originalPrice = p.getPrice().multiply(new java.math.BigDecimal("2.5"));
                                            pageContext.setAttribute("originalPrice", originalPrice);
                                        %>
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

<jsp:include page="partials/_footer.jsp"/>

</body>
</html>
