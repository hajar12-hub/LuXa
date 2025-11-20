<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gérer les Images - Administration LuXa</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/main.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/admin.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/_header.jsp"/>

<main class="admin-dashboard">
    <div class="admin-container">
        <!-- Header -->
        <div class="admin-header">
            <div>
                <h1 class="admin-title">Gérer les Images</h1>
                <p class="admin-subtitle">
                    <c:if test="${not empty product}">
                        Produit : <strong>${product.name}</strong>
                    </c:if>
                </p>
            </div>
        </div>

        <!-- Message d'erreur si présent -->
        <c:if test="${not empty error}">
            <div class="admin-alert admin-alert-error">
                <svg viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width: 20px; height: 20px;">
                    <circle cx="12" cy="12" r="10"/>
                    <line x1="12" y1="8" x2="12" y2="12"/>
                    <line x1="12" y1="16" x2="12.01" y2="16"/>
                </svg>
                ${error}
            </div>
        </c:if>

        <c:if test="${not empty product}">
            <!-- Formulaire d'ajout d'image -->
            <div class="admin-card" style="margin-bottom: 32px;">
                <h2 class="admin-card-title">Ajouter une image</h2>
                <form method="post" action="<%= ctx %>/admin/products/images" class="admin-image-form">
                    <input type="hidden" name="productId" value="${product.id}"/>
                    <input type="hidden" name="action" value="add"/>
                    <div style="display: grid; grid-template-columns: 1fr auto; gap: 12px; align-items: end;">
                        <div>
                            <label for="imageUrl" style="display: block; margin-bottom: 8px; font-weight: 500; color: #1A1A1A;">URL de l'image</label>
                            <input type="text" 
                                   id="imageUrl" 
                                   name="imageUrl" 
                                   placeholder="/images/produit.jpg" 
                                   required
                                   style="width: 100%; padding: 12px; border: 2px solid rgba(26,26,26,.1); border-radius: 8px; font-size: 14px;"/>
                        </div>
                        <button type="submit" class="admin-btn admin-btn-primary">
                            <svg class="admin-btn-icon" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="12" y1="5" x2="12" y2="19"/>
                                <line x1="5" y1="12" x2="19" y2="12"/>
                            </svg>
                            Ajouter
                        </button>
                    </div>
                </form>
            </div>

            <!-- Liste des images existantes -->
            <div class="admin-card">
                <h2 class="admin-card-title">Images du produit</h2>
                <c:choose>
                    <c:when test="${empty product.images}">
                        <p style="text-align: center; padding: 40px; color: rgba(26,26,26,.6);">
                            Aucune image pour ce produit.
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div class="admin-images-grid">
                            <c:forEach var="image" items="${product.images}">
                                <div class="admin-image-item">
                                    <div class="admin-image-preview">
                                        <img src="<%= ctx %>${image.url}" 
                                             alt="${image.altText != null ? image.altText : product.name}"
                                             onerror="this.src='<%= ctx %>/images/placeholder.jpg'"/>
                                        <c:if test="${image.main}">
                                            <span class="admin-image-badge">Principale</span>
                                        </c:if>
                                    </div>
                                    <div class="admin-image-info">
                                        <p style="margin: 0 0 8px 0; font-size: 12px; color: rgba(26,26,26,.6); word-break: break-all;">
                                            ${image.url}
                                        </p>
                                        <form method="post" action="<%= ctx %>/admin/products/images" style="display: inline;">
                                            <input type="hidden" name="productId" value="${product.id}"/>
                                            <input type="hidden" name="imageId" value="${image.id}"/>
                                            <input type="hidden" name="action" value="delete"/>
                                            <button type="submit" 
                                                    class="admin-btn admin-btn-secondary"
                                                    style="width: 100%; padding: 8px; font-size: 13px;"
                                                    onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette image ?');">
                                                <svg class="admin-btn-icon" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width: 14px; height: 14px;">
                                                    <polyline points="3 6 5 6 21 6"/>
                                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
                                                </svg>
                                                Supprimer
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- Lien retour -->
        <div style="margin-top: 32px; text-align: center;">
            <a href="<%= ctx %>/admin/products" class="admin-btn admin-btn-secondary">
                <svg class="admin-btn-icon" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M19 12H5"/>
                    <polyline points="12 19 5 12 12 5"/>
                </svg>
                Retour à la liste des produits
            </a>
        </div>
    </div>
</main>

</body>
</html>

