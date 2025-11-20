<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Administration LuXa</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/main.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/admin.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/_header.jsp"/>

<main class="admin-dashboard">
    <div class="admin-container">
        <!-- Header du Dashboard -->
        <div class="admin-header">
            <h1 class="admin-title">Espace d'administration LuXa</h1>
            <p class="admin-subtitle">Depuis cet espace, vous pouvez gérer le catalogue de produits.</p>
        </div>

        <!-- Grille des Cartes Admin -->
        <section class="admin-cards-grid">
            <!-- Carte Produits -->
            <div class="admin-card">
                <div class="admin-card-icon">
                    <svg viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M6 2l1 2h10l1-2"/>
                        <path d="M6 6h12l-1 12H7L6 6z"/>
                        <circle cx="9" cy="22" r="1"/>
                        <circle cx="17" cy="22" r="1"/>
                    </svg>
                </div>
                <h2 class="admin-card-title">Produits</h2>
                <p class="admin-card-description">Gérer les produits du catalogue, ajouter de nouveaux articles et modifier les existants.</p>
                <div class="admin-card-actions">
                    <a href="<%= ctx %>/admin/products" class="admin-btn admin-btn-primary">
                        <svg class="admin-btn-icon" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/>
                            <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/>
                        </svg>
                        Voir les produits
                    </a>
                    <a href="<%= ctx %>/admin/products/new" class="admin-btn admin-btn-secondary">
                        <svg class="admin-btn-icon" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="12" y1="5" x2="12" y2="19"/>
                            <line x1="5" y1="12" x2="19" y2="12"/>
                        </svg>
                        Ajouter un produit
                    </a>
                </div>
            </div>

        </section>
    </div>
</main>

</body>
</html>

