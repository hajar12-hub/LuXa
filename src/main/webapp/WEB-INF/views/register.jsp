<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Créer un compte — LuXa</title>
    <!-- CSS global -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"/>
</head>
<body>

<jsp:include page="partials/_header.jsp"/>

<main class="auth-wrap">
    <section class="form-card">
        <h2>Créer un compte</h2>
        <p class="form-muted">Renseignez vos informations pour ouvrir votre compte.</p>

        <c:if test="${not empty globalError}">
            <div class="error">${globalError}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/register" accept-charset="UTF-8">
            <div class="fgroup">
                <label for="username">Nom d’utilisateur</label>
                <input id="username" name="username" class="input" value="${old_username}" required />
                <c:if test="${not empty errors.username}">
                    <div class="error" style="margin-top:8px">${errors.username}</div>
                </c:if>
            </div>

            <div class="fgroup">
                <label for="email">Email</label>
                <input id="email" type="email" name="email" class="input" value="${old_email}" required />
                <c:if test="${not empty errors.email}">
                    <div class="error" style="margin-top:8px">${errors.email}</div>
                </c:if>
            </div>

            <div class="fgroup">
                <label for="password">Mot de passe</label>
                <input id="password" type="password" name="password" class="input" required />
                <c:if test="${not empty errors.password}">
                    <div class="error" style="margin-top:8px">${errors.password}</div>
                </c:if>
            </div>

            <div class="fgroup">
                <label for="confirmPassword">Confirmer le mot de passe</label>
                <input id="confirmPassword" type="password" name="confirmPassword" class="input" required />
                <c:if test="${not empty errors.confirmPassword}">
                    <div class="error" style="margin-top:8px">${errors.confirmPassword}</div>
                </c:if>
            </div>

            <div class="actions">
                <button type="submit" class="btn">S’inscrire</button>
                <a class="link" href="${pageContext.request.contextPath}/login">Déjà un compte ?</a>
            </div>
        </form>
    </section>
</main>

<jsp:include page="partials/_footer.jsp"/>

</body>
</html>
