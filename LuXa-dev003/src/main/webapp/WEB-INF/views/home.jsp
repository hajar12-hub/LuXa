<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="partials/_header.jsp" %>

<!-- Lien spécifique pour la page d’accueil -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/home.css">

<main>
    <%-- SECTION 1 : HERO / INTRO ---%>
    <section class="page-intro-section">
        <div class="container-xl">
            <h1>Bienvenue sur LuXa</h1>
            <p>Découvrez nos collections uniques de produits raffinés et élégants.<br>
               Chaque pièce est pensée pour inspirer le luxe, le confort et la créativité.</p>
            <div class="intro-buttons">
                <a href="${pageContext.request.contextPath}/produits?categorie=joaillerie" class="btn-intro">Explorer</a>
                <a href="${pageContext.request.contextPath}/guides" class="btn-intro">Nos Guides</a>
            </div>
        </div>
    </section>

    <%-- SECTION 2 : NOS UNIVERS --%>
    <section id="nos-univers-section" class="section-padding">
        <div class="container-xl">
            <div class="section-header">
                <h2 class="section-title">Nos Univers</h2>
                <p class="section-subtitle">
                    Explorez nos collections d'exception, où chaque pièce incarne la précision, la beauté et l'artisanat.
                </p>
            </div>

            <div class="category-list-container">

                <!-- Catégorie 1 : Joaillerie -->
                <div class="category-item">
                    <div class="category-item-image">
                        <img src="https://images.unsplash.com/photo-1611652022417-a551be9e1a89?w=800" alt="Joaillerie">
                    </div>
                    <div class="category-item-content">
                        <h3 class="category-item-title">Joaillerie</h3>
                        <p>Des créations uniques qui célèbrent les moments précieux de la vie.</p>
                        <a href="#" class="category-item-link">Découvrir</a>
                    </div>
                </div>

                <!-- Catégorie 2 : Horlogerie -->
                <div class="category-item">
                    <div class="category-item-image">
                        <img src="https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=800" alt="Horlogerie">
                    </div>
                    <div class="category-item-content">
                        <h3 class="category-item-title">Horlogerie</h3>
                        <p>La maîtrise du temps alliée à une esthétique intemporelle.</p>
                        <a href="#" class="category-item-link">Découvrir</a>
                    </div>
                </div>

                <!-- Catégorie 3 : Lunettes -->
                <div class="category-item">
                    <div class="category-item-image">
                        <img src="https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800" alt="Lunettes">
                    </div>
                    <div class="category-item-content">
                        <h3 class="category-item-title">Lunettes</h3>
                        <p>Un regard affirmé avec des montures d'exception.</p>
                        <a href="#" class="category-item-link">Découvrir</a>
                    </div>
                </div>

            </div>
        </div>
    </section>
</main>

<%@ include file="partials/_footer.jsp" %>
