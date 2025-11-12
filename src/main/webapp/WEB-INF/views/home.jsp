<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="/WEB-INF/views/_header.jsp"/>

<div class="home-container">
    <div class="hero-section">
        <h1>Bienvenue sur LuXa</h1>
        <p>Votre boutique d’accessoires de luxe • Élégance • Qualité • Style</p>

        <a href="${pageContext.request.contextPath}/login" class="btn-primary">Se connecter</a>
        <a href="${pageContext.request.contextPath}/register" class="btn-secondary">Créer un compte</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/_footer.jsp"/>
