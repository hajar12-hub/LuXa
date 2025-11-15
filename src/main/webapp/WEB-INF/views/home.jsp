<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%
    String ctx = request.getContextPath();
%>
<jsp:include page="/WEB-INF/views/_header.jsp"/>

<!-- Lien spécifique pour la page d'accueil -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css">

<main class="home-page" style="background: #F5F0E8;">
    <%-- SECTION 1 : HERO BANNER ---%>
    <section class="hero-banner" style="background-image: url('<%= ctx %>/images/perle.jpg');">
        <div class="container-xl">
            <div class="hero-content">
                <h1 class="hero-title">LuXa</h1>
                <p class="hero-subtitle">L'excellence du luxe à portée de main</p>
                <div class="hero-buttons">
                    <a href="<%= ctx %>/catalogue" class="btn-hero">Découvrir</a>
                    <a href="<%= ctx %>/catalogue" class="btn-hero btn-hero-outline">Explorer</a>
                </div>
            </div>
        </div>
    </section>

    <%-- SECTION 2 : NOS UNIVERS (Catégories en grille) ---%>
    <section class="categories-section" >
        <div class="container-xl">
            <div class="section-header-center">
                <h2 class="section-title-center">Nos Univers</h2>
                <p class="section-subtitle-center">
                    Explorez nos trois collections d'exception, où chaque pièce
                    incarne la précision, la beauté et l'artisanat d'excellence.
                </p>
            </div>

            <div class="categories-grid">
                <c:forEach var="category" items="${categories}" varStatus="status">
                    <c:if test="${status.index < 3}">
                        <div class="category-card">
                            <div class="category-card-image">
                                <c:set var="categoryImageUrl" value="${category.imageUrl}"/>
                                <c:if test="${not empty categoryImageUrl}">
                                    <c:choose>
                                        <c:when test="${fn:startsWith(categoryImageUrl, '/images/')}">
                                            <c:set var="categoryImageUrl" value="${pageContext.request.contextPath}${categoryImageUrl}"/>
                                        </c:when>
                                        <c:when test="${fn:startsWith(categoryImageUrl, 'images/')}">
                                            <c:set var="categoryImageUrl" value="${pageContext.request.contextPath}/${categoryImageUrl}"/>
                                        </c:when>
                                    </c:choose>
                                </c:if>
                                <img src="${not empty categoryImageUrl ? categoryImageUrl : 'https://images.unsplash.com/photo-1611652022417-a551be9e1a89?w=800&auto=format&fit=crop'}" 
                                     alt="${category.name}"
                                     onerror="this.src='https://images.unsplash.com/photo-1611652022417-a551be9e1a89?w=800&auto=format&fit=crop'">
                            </div>
                            <div class="category-card-content">
                                <h3 class="category-card-title">${category.name}</h3>
                                <p class="category-card-description">
                                    <c:choose>
                                        <c:when test="${category.name == 'Joaillerie'}">Haute joaillerie et pierres d'exception</c:when>
                                        <c:when test="${category.name == 'Horlogerie'}">Montres de manufacture et complications</c:when>
                                        <c:when test="${category.name == 'Lunettes'}">Lunettes de créateur et savoir-faire artisanal</c:when>
                                        <c:otherwise>${not empty category.description ? category.description : 'Découvrez notre collection'}</c:otherwise>
                                    </c:choose>
                                </p>
                                <a href="<%= ctx %>/catalogue?category=${category.id}" class="category-card-link">Découvrir</a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                
                <%-- Fallback si pas de catégories en base --%>
                <c:if test="${empty categories or categories.size() < 3}">
                    <c:set var="hasJoaillerie" value="false"/>
                    <c:set var="hasHorlogerie" value="false"/>
                    <c:set var="hasLunettes" value="false"/>
                    <c:forEach var="cat" items="${categories}">
                        <c:if test="${cat.name == 'Joaillerie'}"><c:set var="hasJoaillerie" value="true"/></c:if>
                        <c:if test="${cat.name == 'Horlogerie'}"><c:set var="hasHorlogerie" value="true"/></c:if>
                        <c:if test="${cat.name == 'Lunettes'}"><c:set var="hasLunettes" value="true"/></c:if>
                    </c:forEach>
                    
                    <c:if test="${!hasJoaillerie}">
                        <div class="category-card">
                            <div class="category-card-image">
                                <img src="${pageContext.request.contextPath}/images/bague4.jpg" 
                                     alt="Joaillerie"
                                     onerror="this.src='https://images.unsplash.com/photo-1611652022417-a551be9e1a89?w=800&auto=format&fit=crop'">
                            </div>
                            <div class="category-card-content">
                                <h3 class="category-card-title">Joaillerie</h3>
                                <p class="category-card-description">Haute joaillerie et pierres d'exception</p>
                                <a href="<%= ctx %>/catalogue" class="category-card-link">Découvrir</a>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${!hasHorlogerie}">
                        <div class="category-card">
                            <div class="category-card-image">
                                <img src="${pageContext.request.contextPath}/images/montre1.jpg" 
                                     alt="Horlogerie"
                                     onerror="this.src='https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&auto=format&fit=crop'">
                            </div>
                            <div class="category-card-content">
                                <h3 class="category-card-title">Horlogerie</h3>
                                <p class="category-card-description">Montres de manufacture et complications</p>
                                <a href="<%= ctx %>/catalogue" class="category-card-link">Découvrir</a>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${!hasLunettes}">
                        <div class="category-card">
                            <div class="category-card-image">
                                <img src="${pageContext.request.contextPath}/images/lunettes.jpg" 
                                     alt="Lunettes"
                                     onerror="this.src='https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=800&auto=format&fit=crop'">
                            </div>
                            <div class="category-card-content">
                                <h3 class="category-card-title">Lunettes</h3>
                                <p class="category-card-description">Lunettes de créateur et savoir-faire artisanal</p>
                                <a href="<%= ctx %>/catalogue" class="category-card-link">Découvrir</a>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </div>
        </div>
    </section>

    <%-- SECTION 3 : NOS CRÉATIONS (Produits) ---%>
    <c:if test="${not empty featuredProducts}">
        <section class="featured-products-section">
            <div class="container-xl">
                <div class="section-header-center">
                    <h2 class="section-title-center">Nos Créations</h2>
                </div>
                <div class="products-grid-home">
                    <c:forEach var="product" items="${featuredProducts}" end="7">
                        <div class="product-card-home">
                            <a href="<%= ctx %>/product/${product.id}" class="product-card-link">
                                <div class="product-image-wrapper-home">
                                    <c:set var="mainImage" value="${null}"/>
                                    <c:forEach var="image" items="${product.images}">
                                        <c:if test="${image.main}">
                                            <c:set var="mainImage" value="${image.url}"/>
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
                                    
                                    <img src="${mainImage != null ? mainImage : 'https://via.placeholder.com/400x400'}" 
                                         alt="${product.name}" 
                                         class="product-image-home"
                                         onerror="this.src='https://via.placeholder.com/400x400'">
                                </div>
                                <div class="product-card-body-home">
                                    <h3 class="product-name-home">${product.name}</h3>
                                    <div class="product-price-home">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencyCode="MAD" minFractionDigits="2"/>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>

    <%-- SECTION 4 : EXPERTISE (Stats) ---%>
    <section class="expertise-section">
        <div class="container-xl">
            <div class="expertise-grid">
                <div class="expertise-item">
                    <div class="expertise-number">50+</div>
                    <h4 class="expertise-title">Années d'Excellence</h4>
                    <p class="expertise-description">
                        Un demi-siècle de savoir-faire et d'expertise joaillière
                    </p>
                </div>
                <div class="expertise-item">
                    <div class="expertise-number">100%</div>
                    <h4 class="expertise-title">Pierres Certifiées</h4>
                    <p class="expertise-description">
                        Chaque pierre est authentifiée et certifiée par des experts
                    </p>
                </div>
                <div class="expertise-item">
                    <div class="expertise-number">24/7</div>
                    <h4 class="expertise-title">Service Client Premium</h4>
                    <p class="expertise-description">
                        Un conseiller dédié à votre écoute en permanence
                    </p>
                </div>
            </div>
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/views/_footer.jsp"/>
