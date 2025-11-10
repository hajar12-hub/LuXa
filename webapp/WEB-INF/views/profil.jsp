<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/_header.jsp"/>

<div class="container" style="max-width:720px;margin:30px auto;">
    <h2>Mon profil</h2>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/profil" accept-charset="UTF-8" novalidate>
        <!-- Username -->
        <div class="form-group" style="margin-bottom:12px;">
            <label>Nom d’utilisateur</label>
            <input name="username"
                   class="form-control"
                   required maxlength="150"
                   pattern="^[A-Za-z0-9._-]{3,150}$"
                   title="3 à 150 caractères : lettres, chiffres, . _ -"
                   value="${empty old_username ? user.username : old_username}" />
            <small>3 à 150 caractères (lettres, chiffres, . _ -).</small>
        </div>

        <!-- Email -->
        <div class="form-group" style="margin-bottom:12px;">
            <label>Email</label>
            <input type="email"
                   name="email"
                   class="form-control"
                   required maxlength="255"
                   autocomplete="email"
                   value="${empty old_email ? user.email : old_email}" />
            <small>L’adresse e-mail est insensible à la casse (nous la stockons en minuscule).</small>
            <!-- On garde la valeur d’origine pour détecter une modification côté client -->
            <input type="hidden" id="initialEmail" value="${fn:escapeXml(user.email)}" />
        </div>

        <!-- Mot de passe actuel (affiché uniquement si l’email change) -->
        <div id="currentPasswordBlock" class="form-group" style="margin-bottom:12px; display:none;">
            <label>Mot de passe actuel (requis si vous changez d’email)</label>
            <input type="password"
                   name="currentPassword"
                   class="form-control"
                   autocomplete="current-password"
                   placeholder="Votre mot de passe actuel" />
            <small>Pour votre sécurité, le changement d’e-mail nécessite votre mot de passe.</small>
        </div>

        <!-- Prénom (optionnel) -->
        <div class="form-group" style="margin-bottom:12px;">
            <label>Prénom (optionnel)</label>
            <input name="firstName" maxlength="100" class="form-control"
                   value="${empty old_firstName ? user.firstName : old_firstName}" />
        </div>

        <!-- Nom (optionnel) -->
        <div class="form-group" style="margin-bottom:12px;">
            <label>Nom (optionnel)</label>
            <input name="lastName" maxlength="100" class="form-control"
                   value="${empty old_lastName ? user.lastName : old_lastName}" />
        </div>

        <!-- Téléphone (optionnel) -->
        <div class="form-group" style="margin-bottom:12px;">
            <label>Téléphone (optionnel)</label>
            <input name="phoneNumber"
                   maxlength="50"
                   class="form-control"
                   placeholder="+212 XXX XX XX XX"
                   autocomplete="tel"
                   value="${empty old_phoneNumber ? user.phoneNumber : old_phoneNumber}" />
        </div>

        <!-- Adresse (optionnel) -->
        <div class="form-group" style="margin-bottom:12px;">
            <label>Adresse (optionnel)</label>
            <textarea name="address" rows="4" class="form-control"
                      placeholder="Rue, immeuble, ville, code postal...">${empty old_address ? user.address : old_address}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Enregistrer</button>
    </form>
</div>

<!-- Petite logique côté client : afficher le champ 'mot de passe actuel' si l'email est modifié -->
<script>
    (function () {
        var emailInput = document.querySelector('input[name="email"]');
        var initialEmail = document.getElementById('initialEmail')?.value || '';
        var block = document.getElementById('currentPasswordBlock');

        function togglePwdBlock() {
            var cur = (emailInput.value || '').trim().toLowerCase();
            var ini = (initialEmail || '').trim().toLowerCase();
            block.style.display = (cur !== ini) ? 'block' : 'none';
        }

        if (emailInput && block) {
            emailInput.addEventListener('input', togglePwdBlock);
            // init au chargement
            togglePwdBlock();
        }
    })();
</script>

<jsp:include page="/WEB-INF/views/_footer.jsp"/>
