<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/_header.jsp"/>

<div class="auth-wrap">
    <div class="card form-card">
        <h2>Connexion</h2>
        <p class="form-muted">Accédez à votre compte pour suivre vos commandes d’accessoires.</p>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login" class="row">
            <input class="input" name="email" placeholder="Email" value="${old_email != null ? old_email : ''}" required />

            <input class="input" type="password" name="password" placeholder="Mot de passe" required />
            <div class="actions">
                <a class="link" href="${pageContext.request.contextPath}/register">Créer un compte</a>
                <button class="btn" type="submit">Se connecter</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/_footer.jsp"/>