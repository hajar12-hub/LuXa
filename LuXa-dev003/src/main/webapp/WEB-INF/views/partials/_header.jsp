<%
    String ctx = request.getContextPath();
    Integer cartCount = (Integer) request.getAttribute("cartCount");
    Integer authUserId = (Integer) session.getAttribute("authUserId");
    boolean loggedIn = (authUserId != null);
%>

<!-- 🔗 CSS global du site -->
<link rel="stylesheet" href="<%= ctx %>/assets/css/main.css">

<!-- Polices Google -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&family=Inter:wght@400;500&display=swap" rel="stylesheet">

<header class="luxa-header">
    <div class="luxa-container">
        <a href="<%= ctx %>/home" class="luxa-logo">
            Lu<span class="x-gold">X</span>a
        </a>

        <nav class="luxa-nav">
            <a href="<%= ctx %>/home" class="nav-link">Accueil</a>
            <a href="<%= ctx %>/products" class="nav-link">Catalogue</a>
            <a href="<%= ctx %>/guides" class="nav-link">Guide</a>
            <a href="${pageContext.request.contextPath}/contact" class="nav-link">Contact</a>
        </nav>

        <div class="luxa-actions">
            <button class="icon-btn" aria-label="Rechercher" type="button">
                <svg width="20" height="20" viewBox="0 0 24 24" stroke="currentColor" fill="none" class="icon">
                    <circle cx="11" cy="11" r="8"/>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"/>
                </svg>
            </button>

            <a href="<%= ctx %>/<%= loggedIn ? "profil" : "login" %>" class="icon-btn" aria-label="Profil">
                <svg width="20" height="20" viewBox="0 0 24 24" stroke="currentColor" fill="none" class="icon">
                    <path d="M20 21a8 8 0 1 0-16 0"/>
                    <circle cx="12" cy="7" r="4"/>
                </svg>
            </a>

            <a href="<%= ctx %>/cart" class="icon-btn cart" aria-label="Panier">
                <svg width="20" height="20" viewBox="0 0 24 24" stroke="currentColor" fill="none" class="icon">
                    <path d="M6 2l1 2h10l1-2"/>
                    <path d="M6 6h12l-1 12H7L6 6z"/>
                    <circle cx="9" cy="22" r="1"/>
                    <circle cx="17" cy="22" r="1"/>
                </svg>
                <% if (cartCount != null && cartCount > 0) { %>
                    <span class="badge"><%= cartCount %></span>
                <% } %>
            </a>

            <% if (loggedIn) { %>
                <a href="<%= ctx %>/logout" class="auth-btn">Déconnexion</a>
            <% } else { %>
                <a href="<%= ctx %>/login" class="auth-btn">Connexion</a>
            <% } %>

            <% String authRole = (String) session.getAttribute("authRole"); %>
            <% if ("ADMIN".equals(authRole)) { %>
                <a href="<%= ctx %>/admin" class="auth-btn">Administration</a>
            <% } %>
        </div>
    </div>
</header>
