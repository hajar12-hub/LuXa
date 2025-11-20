<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <%-- ========================================= --%>
        <%-- SECTION ADDITIONNELLE : VENTE FLASH / COMPTE À REBOURS --%>
        <%-- ========================================= --%>
        <section class="flash-sale-section">
            <div class="container-xl">
                <div class="section-header-center">
                    <h2 class="section-title-center" style="font-size: 2.8rem;">Faites Vite !</h2>
                    <p class="section-subtitle-center">
                        Profitez d'offres exceptionnelles sur nos montres avant qu'elles ne disparaissent
                    </p>
                </div>

                <!-- Compte à rebours -->
                <div class="countdown-container" id="countdown">
                    <div class="time-block">
                        <span class="time-number" id="days">00</span>
                        <span class="time-label">Jours</span>
                    </div>
                    <div class="time-separator">:</div>
                    <div class="time-block">
                        <span class="time-number" id="hours">10</span>
                        <span class="time-label">Heures</span>
                    </div>
                    <div class="time-separator">:</div>
                    <div class="time-block">
                        <span class="time-number" id="minutes">32</span>
                        <span class="time-label">Min</span>
                    </div>
                    <div class="time-separator">:</div>
                    <div class="time-block">
                        <span class="time-number" id="seconds">47</span>
                        <span class="time-label">Sec</span>
                    </div>
                </div>

                <!-- Grille produits Flash (Statique pour l'exemple visuel) -->
                <div class="products-grid-home">

                    <!-- Produit 1 -->
                    <div class="product-card-home">
                        <a href="<%= ctx %>/catalogue" class="product-card-link">
                            <div class="product-image-wrapper-home">
                                <span class="discount-badge">-32%</span>
                                <img src="<%= ctx %>/images/bague1.jpg"
                                     alt="Bague Solitaire"
                                     class="product-image-home"
                                     onerror="this.src='https://images.unsplash.com/photo-1605100804763-247f67b3557e?auto=format&fit=crop&w=500'">
                            </div>
                            <div class="product-card-body-home">
                                <div style="color:#666; font-size:0.85rem; margin-bottom:5px;">Joaillerie</div>
                                <h3 class="product-name-home">Bague Solitaire Diamant Éternité</h3>
                                <div class="price-container">
                                    <span class="old-price">24 050 DH</span>
                                    <span class="new-price">18 500 DH</span>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- Produit 2 -->
                    <div class="product-card-home">
                        <a href="<%= ctx %>/catalogue" class="product-card-link">
                            <div class="product-image-wrapper-home">
                                <span class="discount-badge">-29%</span>
                                <img src="<%= ctx %>/images/colier5.jpg"
                                     alt="Collier Rivière"
                                     class="product-image-home"
                                     onerror="this.src='https://images.unsplash.com/photo-1611591437281-460bfbe1220a?auto=format&fit=crop&w=500'">
                            </div>
                            <div class="product-card-body-home">
                                <div style="color:#666; font-size:0.85rem; margin-bottom:5px;">Joaillerie</div>
                                <h3 class="product-name-home">Collier Rivière Saphir</h3>
                                <div class="price-container">
                                    <span class="old-price">41 600 DH</span>
                                    <span class="new-price">32 000 DH</span>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- Produit 3 -->
                    <div class="product-card-home">
                        <a href="<%= ctx %>/catalogue" class="product-card-link">
                            <div class="product-image-wrapper-home">
                                <span class="discount-badge">-31%</span>
                                <img src="<%= ctx %>/images/boucle3.jpg"
                                     alt="Boucles Émeraude"
                                     class="product-image-home"
                                     onerror="this.src='https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&w=500'">
                            </div>
                            <div class="product-card-body-home">
                                <div style="color:#666; font-size:0.85rem; margin-bottom:5px;">Joaillerie</div>
                                <h3 class="product-name-home">Boucles d'Oreilles Émeraude</h3>
                                <div class="price-container">
                                    <span class="old-price">16 640 DH</span>
                                    <span class="new-price">12 800 DH</span>
                                </div>
                            </div>
                        </a>
                    </div>

                    <!-- Produit 4 -->
                    <div class="product-card-home">
                        <a href="<%= ctx %>/catalogue" class="product-card-link">
                            <div class="product-image-wrapper-home">
                                <span class="discount-badge">-20%</span>
                                <img src="<%= ctx %>/images/bracelet3.png"
                                     alt="Bracelet Jonc"
                                     class="product-image-home"
                                     onerror="this.src='https://images.unsplash.com/photo-1599643478518-17488fbbcd75?auto=format&fit=crop&w=500'">
                            </div>
                            <div class="product-card-body-home">
                                <div style="color:#666; font-size:0.85rem; margin-bottom:5px;">Joaillerie</div>
                                <h3 class="product-name-home">Bracelet Jonc Or Rose Diamants</h3>
                                <div class="price-container">
                                    <span class="old-price">11 570 DH</span>
                                    <span class="new-price">8 900 DH</span>
                                </div>
                            </div>
                        </a>
                    </div>

                </div>
            </div>
        </section>

        <%-- Script pour faire fonctionner le compte à rebours --%>
        <script>
            // Définir la date de fin (dans 2 jours par exemple)
            const countDownDate = new Date().getTime() + (2 * 24 * 60 * 60 * 1000) + (10 * 60 * 60 * 1000);

            const x = setInterval(function() {
                const now = new Date().getTime();
                const distance = countDownDate - now;

                const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);

                // Mettre à jour les éléments HTML
                document.getElementById("days").innerHTML = days < 10 ? "0" + days : days;
                document.getElementById("hours").innerHTML = hours < 10 ? "0" + hours : hours;
                document.getElementById("minutes").innerHTML = minutes < 10 ? "0" + minutes : minutes;
                document.getElementById("seconds").innerHTML = seconds < 10 ? "0" + seconds : seconds;

                if (distance < 0) {
                    clearInterval(x);
                    document.getElementById("countdown").innerHTML = "EXPIRED";
                }
            }, 1000);
        </script>

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


    <%-- ========================================= --%>
    <%-- SECTION AVIS CLIENTS / TESTIMONIALS --%>
    <%-- ========================================= --%>
    <section class="testimonials-section">
        <div class="container-xl">
            <div class="section-header-center">
                <h2 class="section-title-center">Avis Clients</h2>
                <p class="section-subtitle-center">
                    Ce que nos clients disent de leur expérience LuXa
                </p>
            </div>

            <div class="testimonials-grid">
                <!-- Témoignage 1 -->
                <div class="testimonial-card">
                    <div class="quote-icon">"</div>
                    <div class="stars">
                        <span class="star">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                    </div>
                    <p class="testimonial-text">
                        "Une expérience d'achat exceptionnelle. La bague en diamant que j'ai commandée
                        dépasse toutes mes attentes. Le service client est irréprochable."
                    </p>
                    <div class="testimonial-author">
                        <img src="${pageContext.request.contextPath}/images/client1.jpg"
                             alt="Sophie Martins"
                             class="author-avatar"
                             onerror="this.src='https://ui-avatars.com/api/?name=Sophie+Martins&background=BFA181&color=fff&size=60'">
                        <div class="author-info">
                            <h4 class="author-name">Sophie Martins</h4>
                            <p class="author-title">Cliente VIP</p>
                        </div>
                    </div>
                </div>

                <!-- Témoignage 2 -->
                <div class="testimonial-card">
                    <div class="quote-icon">"</div>
                    <div class="stars">
                        <span class="star">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                    </div>
                    <p class="testimonial-text">
                        "Ma montre automatique est une merveille de précision. L'expertise de LuXa dans
                        l'horlogerie de luxe est indéniable. Je recommande sans hésitation."
                    </p>
                    <div class="testimonial-author">
                        <img src="${pageContext.request.contextPath}/images/client2.jpg"
                             alt="Marc Dubois"
                             class="author-avatar"
                             onerror="this.src='https://ui-avatars.com/api/?name=Marc+Dubois&background=BFA181&color=fff&size=60'">
                        <div class="author-info">
                            <h4 class="author-name">Marc Dubois</h4>
                            <p class="author-title">Collectionneur</p>
                        </div>
                    </div>
                </div>

                <!-- Témoignage 3 -->
                <div class="testimonial-card">
                    <div class="quote-icon">"</div>
                    <div class="stars">
                        <span class="star">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                        <span class="star">★</span>
                    </div>
                    <p class="testimonial-text">
                        "Les lunettes de créateur que j'ai achetées sont sublimes. La qualité est au rendez-vous
                        et le design est exactement ce que je recherchais."
                    </p>
                    <div class="testimonial-author">
                        <img src="${pageContext.request.contextPath}/images/client3.jpg"
                             alt="Isabelle Laurent"
                             class="author-avatar"
                             onerror="this.src='https://ui-avatars.com/api/?name=Isabelle+Laurent&background=BFA181&color=fff&size=60'">
                        <div class="author-info">
                            <h4 class="author-name">Isabelle Laurent</h4>
                            <p class="author-title">Passionnée de Mode</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%-- ========================================= --%>
    <%-- SECTION CADEAU / GIFT SECTION --%>
    <%-- ========================================= --%>
    <section class="gift-section">
        <div class="gift-overlay"></div>
        <div class="container-xl">
            <div class="gift-content">
                <h2 class="gift-title">Aucune idée de cadeau ?</h2>
                <p class="gift-subtitle">
                    Transformez chaque achat en une expérience de luxe inoubliable
                </p>
                <a href="${pageContext.request.contextPath}/catalogue" class="btn-gift">
                    TROUVER LE CADEAU PARFAIT
                </a>
            </div>
        </div>
    </section>
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
