<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Produits - Administration LuXa</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/main.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/admin.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/_header.jsp"/>

<main class="admin-dashboard">
    <div class="admin-container">
        <!-- Header -->
        <div class="admin-header">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
                <div>
                    <h1 class="admin-title">Gestion des Produits</h1>
                    <p class="admin-subtitle">Gérez votre catalogue de produits : ajoutez, modifiez, supprimez et activez/désactivez vos articles.</p>
                </div>
                <a href="<%= ctx %>/admin/products/new" class="admin-btn admin-btn-primary">
                    <svg class="admin-btn-icon" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="12" y1="5" x2="12" y2="19"/>
                        <line x1="5" y1="12" x2="19" y2="12"/>
                    </svg>
                    Ajouter un produit
                </a>
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

        <!-- Debug: Afficher le nombre de produits -->
        <c:if test="${not empty products}">
            <div style="margin-bottom: 16px; padding: 12px; background: #eaf6ec; border-radius: 8px; color: #135f2a; font-size: 0.875rem;">
                <strong>${products.size()}</strong> produit(s) trouvé(s)
            </div>
        </c:if>

        <!-- Tableau des produits -->
        <div class="admin-table-container">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Nom</th>
                        <th>Prix</th>
                        <th>Catégorie</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty products}">
                            <tr>
                                <td colspan="7" class="admin-table-empty">
                                    <div style="text-align: center; padding: 40px;">
                                        <svg viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width: 48px; height: 48px; color: rgba(26,26,26,.3); margin-bottom: 16px;">
                                            <path d="M6 2l1 2h10l1-2"/>
                                            <path d="M6 6h12l-1 12H7L6 6z"/>
                                            <circle cx="9" cy="22" r="1"/>
                                            <circle cx="17" cy="22" r="1"/>
                                        </svg>
                                        <p style="color: rgba(26,26,26,.6); margin: 0;">Aucun produit trouvé.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="product" items="${products}">
                                <tr>
                                    <td class="admin-table-id">${product.id}</td>
                                    <td class="admin-table-image">
                                        <c:choose>
                                            <c:when test="${not empty product.images and product.images.size() > 0}">
                                                <img src="<%= ctx %>${product.images[0].url}" 
                                                     alt="${product.name}" 
                                                     onerror="this.src='<%= ctx %>/images/placeholder.jpg'"/>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="admin-table-image-placeholder">
                                                    <svg viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                                                        <circle cx="8.5" cy="8.5" r="1.5"/>
                                                        <polyline points="21 15 16 10 5 21"/>
                                                    </svg>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-table-name">
                                        <strong>${product.name}</strong>
                                        <c:if test="${not empty product.description}">
                                            <p class="admin-table-description">${fn:substring(product.description, 0, 60)}${fn:length(product.description) > 60 ? '...' : ''}</p>
                                        </c:if>
                                    </td>
                                    <td class="admin-table-price">
                                        <c:choose>
                                            <c:when test="${product.price != null}">
                                                <fmt:formatNumber value="${product.price}" type="currency" currencyCode="EUR" currencySymbol="€" minFractionDigits="2"/>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: rgba(26,26,26,.5);">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-table-category">
                                        <c:choose>
                                            <c:when test="${not empty product.category}">
                                                <span class="admin-badge admin-badge-category">${product.category.name}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="admin-badge admin-badge-category" style="opacity: 0.5;">Aucune</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-table-stock">
                                        <c:choose>
                                            <c:when test="${product.stockQuantity > 0}">
                                                <span class="admin-badge admin-badge-success">${product.stockQuantity}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="admin-badge admin-badge-danger">0</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="admin-table-actions">
                                        <div class="admin-actions-group">
                                            <a href="<%= ctx %>/admin/products/edit?id=${product.id}" 
                                               class="admin-action-btn admin-action-edit" 
                                               title="Modifier">
                                                <svg viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
                                                </svg>
                                            </a>
                                            <a href="<%= ctx %>/admin/products/images?id=${product.id}" 
                                               class="admin-action-btn admin-action-images" 
                                               title="Gérer les images">
                                                <svg viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                                                    <circle cx="8.5" cy="8.5" r="1.5"/>
                                                    <polyline points="21 15 16 10 5 21"/>
                                                </svg>
                                            </a>
                                            <form method="post" action="<%= ctx %>/admin/products/delete" style="display: inline;" 
                                                  onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce produit ? Cette action est irréversible.');">
                                                <input type="hidden" name="id" value="${product.id}"/>
                                                <button type="submit" 
                                                        class="admin-action-btn admin-action-delete" 
                                                        title="Supprimer">
                                                    <svg viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <polyline points="3 6 5 6 21 6"/>
                                                        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
                                                        <line x1="10" y1="11" x2="10" y2="17"/>
                                                        <line x1="14" y1="11" x2="14" y2="17"/>
                                                    </svg>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Lien retour -->
        <div style="margin-top: 32px; text-align: center;">
            <a href="<%= ctx %>/admin" class="admin-btn admin-btn-secondary">
                <svg class="admin-btn-icon" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M19 12H5"/>
                    <polyline points="12 19 5 12 12 5"/>
                </svg>
                Retour au dashboard
            </a>
        </div>
    </div>
</main>

</body>
</html>

