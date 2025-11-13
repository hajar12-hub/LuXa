<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    String ctx = request.getContextPath();
%>
<jsp:include page="partials/_header.jsp"/>

<div class="contact-wrap">
    <h1 class="contact-title">Contactez-Nous</h1>
    <p class="contact-lead">Notre équipe d'experts est à votre disposition pour répondre à toutes vos questions.</p>

    <c:if test="${not empty flashSuccess}">
        <div class="contact-flash">${flashSuccess}</div>
    </c:if>

    <div class="contact-grid">
        <!-- Colonne Informations -->
        <section class="contact-card">
            <h3 class="contact-section-title">Informations</h3>

            <div class="contact-info">
                <div class="label">Adresse</div>
                <div>Boulevard Hassan II<br>80000 Agadir, Maroc</div>
            </div>

            <div class="contact-info">
                <div class="label">Téléphone</div>
                <div>+212 1 23 45 67 89</div>
            </div>

            <div class="contact-info">
                <div class="label">Email</div>
                <div>contact@luxa-luxury.com</div>
            </div>

            <div class="contact-info">
                <div class="label">Horaires</div>
                <div>Lundi–Samedi : 10h00–19h00<br>Dimanche : Fermé</div>
            </div>
        </section>

        <!-- Colonne Formulaire -->
        <section class="contact-card">
            <h3 class="contact-section-title">Envoyez-nous un Message</h3>

            <form method="post" action="<%= ctx %>/contact" novalidate>
                <div class="fgroup">
                    <label>Nom complet</label>
                    <input class="input" name="fullName" maxlength="150" value="${old_fullName}" required>
                    <c:if test="${not empty errors.fullName}">
                        <div class="field-error">${errors.fullName}</div>
                    </c:if>
                </div>

                <div class="fgroup">
                    <label>Email</label>
                    <input class="input" type="email" name="email" maxlength="180" value="${old_email}" required>
                    <c:if test="${not empty errors.email}">
                        <div class="field-error">${errors.email}</div>
                    </c:if>
                </div>

                <div class="fgroup">
                    <label>Sujet</label>
                    <input class="input" name="subject" maxlength="200" value="${old_subject}" required>
                    <c:if test="${not empty errors.subject}">
                        <div class="field-error">${errors.subject}</div>
                    </c:if>
                </div>

                <div class="fgroup">
                    <label>Message</label>
                    <textarea class="input contact-textarea" name="message" required>${old_message}</textarea>
                    <c:if test="${not empty errors.message}">
                        <div class="field-error">${errors.message}</div>
                    </c:if>
                </div>

                <button class="btn" type="submit">Envoyer</button>
            </form>
        </section>
    </div>
</div>

<jsp:include page="partials/_footer.jsp"/>
