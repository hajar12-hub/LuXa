<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%
    String ctx = request.getContextPath();
%>
<jsp:include page="/WEB-INF/views/_header.jsp"/>

<main class="product-detail-wrap">
    <c:if test="${empty product}">
        <div class="container-xl">
            <div class="error-message">
                <h2>Produit non trouvé</h2>
                <p>Le produit que vous recherchez n'existe pas ou n'est plus disponible.</p>
                <a href="<%= ctx %>/catalogue" class="btn btn-secondary">Retour au catalogue</a>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty product}">
        <div class="container-xl">
            <!-- Breadcrumb -->
            <nav class="breadcrumb-nav">
                <a href="<%= ctx %>/home">Accueil</a>
                <span>/</span>
                <a href="<%= ctx %>/catalogue">Catalogue</a>
                <span>/</span>
                <c:if test="${not empty product.categoryName}">
                    <a href="<%= ctx %>/catalogue?category=${product.categoryId}">${product.categoryName}</a>
                    <span>/</span>
                </c:if>
                <span class="current">${product.name}</span>
            </nav>

            <div class="product-detail-grid">
                <!-- Colonne Images -->
                <div class="product-images">
                    <div class="main-image-container">
                        <c:set var="mainImage" value="${null}"/>
                        <c:forEach var="img" items="${product.images}">
                            <c:if test="${img.main}">
                                <c:set var="mainImage" value="${img.url}"/>
                            </c:if>
                        </c:forEach>
                        <c:if test="${mainImage == null and not empty product.images}">
                            <c:set var="mainImage" value="${product.images[0].url}"/>
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
                        
                        <img id="mainImage" src="${mainImage != null ? mainImage : 'https://via.placeholder.com/600x600'}" 
                             alt="${product.name}" class="main-image"
                             onerror="this.src='https://via.placeholder.com/600x600'">
                    </div>
                    
                    <c:if test="${not empty product.images and product.images.size() > 1}">
                        <div class="thumbnail-list">
                            <c:forEach var="img" items="${product.images}">
                                <c:set var="thumbUrl" value="${img.url}"/>
                                <c:if test="${not empty thumbUrl}">
                                    <c:choose>
                                        <c:when test="${fn:startsWith(thumbUrl, '/images/')}">
                                            <c:set var="thumbUrl" value="${pageContext.request.contextPath}${thumbUrl}"/>
                                        </c:when>
                                        <c:when test="${fn:startsWith(thumbUrl, 'images/')}">
                                            <c:set var="thumbUrl" value="${pageContext.request.contextPath}/${thumbUrl}"/>
                                        </c:when>
                                    </c:choose>
                                </c:if>
                                <button class="thumbnail-btn" data-image="${thumbUrl}" aria-label="Voir image ${img.id}">
                                    <img src="${thumbUrl}" alt="Miniature ${img.id}" class="thumbnail"
                                         onerror="this.src='https://via.placeholder.com/100x100'">
                                </button>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>

                <!-- Colonne Informations -->
                <div class="product-info">
                    <div class="product-category">${product.categoryName}</div>
                    <h1 class="product-title">${product.name}</h1>
                    
                    <div class="product-price-section">
                        <span class="product-price">
                            <fmt:formatNumber value="${product.price}" type="currency" currencyCode="MAD" minFractionDigits="2"/>
                        </span>
                        <c:if test="${product.stockQuantity != null and product.stockQuantity > 0}">
                            <span class="stock-badge in-stock">En stock (${product.stockQuantity} disponible${product.stockQuantity > 1 ? 's' : ''})</span>
                        </c:if>
                        <c:if test="${product.stockQuantity == null or product.stockQuantity == 0}">
                            <span class="stock-badge out-of-stock">Rupture de stock</span>
                        </c:if>
                    </div>

                    <c:if test="${not empty product.description}">
                        <div class="product-description">
                            <h3>Description</h3>
                            <p>${product.description}</p>
                        </div>
                    </c:if>

                    <!-- Variantes -->
                    <c:if test="${not empty product.variants}">
                        <div class="product-variants">
                            <h3>Variantes disponibles</h3>
                            <div class="variant-list">
                                <c:forEach var="variant" items="${product.variants}">
                                    <div class="variant-item">
                                        <div class="variant-info">
                                            <span class="variant-name">${variant.name}</span>
                                            <c:if test="${not empty variant.sku}">
                                                <span class="variant-sku">SKU: ${variant.sku}</span>
                                            </c:if>
                                        </div>
                                        <div class="variant-details">
                                            <span class="variant-price">
                                                <fmt:formatNumber value="${variant.price}" type="currency" currencyCode="MAD" minFractionDigits="2"/>
                                            </span>
                                            <c:if test="${variant.stockQuantity != null and variant.stockQuantity > 0}">
                                                <span class="variant-stock">Stock: ${variant.stockQuantity}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <!-- Actions -->
                    <div class="product-actions">
                        <div class="quantity-selector">
                            <label for="quantity">Quantité</label>
                            <div class="quantity-controls">
                                <button type="button" class="qty-btn" id="decreaseQty" aria-label="Diminuer">−</button>
                                <input type="number" id="quantity" name="quantity" value="1" min="1" 
                                       max="${product.stockQuantity != null ? product.stockQuantity : 999}" 
                                       class="qty-input">
                                <button type="button" class="qty-btn" id="increaseQty" aria-label="Augmenter">+</button>
                            </div>
                        </div>

                        <form method="post" action="<%= ctx %>/cart/add" class="add-to-cart-form">
                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="hidden" name="quantity" id="hiddenQuantity" value="1">
                            <button type="submit" class="btn btn-primary btn-add-cart" 
                                    ${product.stockQuantity == null or product.stockQuantity == 0 ? 'disabled' : ''}>
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M6 2l1 2h10l1-2"/>
                                    <path d="M6 6h12l-1 12H7L6 6z"/>
                                    <circle cx="9" cy="22" r="1"/>
                                    <circle cx="17" cy="22" r="1"/>
                                </svg>
                                Ajouter au panier
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</main>

<script>
    // Gestion des miniatures d'images
    document.querySelectorAll('.thumbnail-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            let imageUrl = this.getAttribute('data-image');
            // S'assurer que le context path est inclus si nécessaire
            if (imageUrl && imageUrl.startsWith('/images/') && !imageUrl.startsWith('<%= ctx %>')) {
                imageUrl = '<%= ctx %>' + imageUrl;
            }
            document.getElementById('mainImage').src = imageUrl;
            document.querySelectorAll('.thumbnail-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // Gestion de la quantité
    const qtyInput = document.getElementById('quantity');
    const hiddenQtyInput = document.getElementById('hiddenQuantity');
    const decreaseBtn = document.getElementById('decreaseQty');
    const increaseBtn = document.getElementById('increaseQty');
    const maxQty = parseInt(qtyInput.getAttribute('max')) || 999;

    decreaseBtn.addEventListener('click', () => {
        let val = parseInt(qtyInput.value) || 1;
        if (val > 1) {
            val--;
            qtyInput.value = val;
            hiddenQtyInput.value = val;
        }
    });

    increaseBtn.addEventListener('click', () => {
        let val = parseInt(qtyInput.value) || 1;
        if (val < maxQty) {
            val++;
            qtyInput.value = val;
            hiddenQtyInput.value = val;
        }
    });

    qtyInput.addEventListener('change', function() {
        let val = parseInt(this.value) || 1;
        if (val < 1) val = 1;
        if (val > maxQty) val = maxQty;
        this.value = val;
        hiddenQtyInput.value = val;
    });
</script>

<jsp:include page="/WEB-INF/views/_footer.jsp"/>
