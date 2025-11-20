<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%
    String ctx = request.getContextPath();
    boolean isEdit = request.getAttribute("product") != null;
    String formAction = isEdit ? ctx + "/admin/products/edit" : ctx + "/admin/products/new";
    String pageTitle = isEdit ? "Modifier un produit" : "Ajouter un produit";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><%= pageTitle %> - Administration LuXa</title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/main.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/admin.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/_header.jsp"/>

<main class="admin-dashboard">
    <div class="admin-container">
        <div class="admin-header">
            <h1 class="admin-title"><%= pageTitle %></h1>
            <p class="admin-subtitle">
                <%= isEdit ? "Modifiez les informations du produit." : "Remplissez les informations pour ajouter un nouveau produit." %>
            </p>
        </div>

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

        <div class="admin-card">
            <form action="<%= formAction %>" method="post" style="display: grid; gap: 24px;">
                <c:if test="${isEdit && product != null}">
                    <input type="hidden" name="id" value="${product.id}"/>
                </c:if>

                <div style="display: grid; gap: 16px;">
                    <div>
                        <label for="name" style="display: block; margin-bottom: 8px; font-weight: 500; color: #1A1A1A;">Nom du produit *</label>
                        <input type="text" 
                               id="name" 
                               name="name" 
                               value="${product != null ? product.name : ''}" 
                               required
                               style="width: 100%; padding: 12px; border: 2px solid rgba(26,26,26,.1); border-radius: 8px; font-size: 14px;"/>
                    </div>

                    <div>
                        <label for="description" style="display: block; margin-bottom: 8px; font-weight: 500; color: #1A1A1A;">Description</label>
                        <textarea id="description" 
                                  name="description" 
                                  rows="6"
                                  style="width: 100%; padding: 12px; border: 2px solid rgba(26,26,26,.1); border-radius: 8px; font-size: 14px; resize: vertical;">${product != null ? product.description : ''}</textarea>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                        <div>
                            <label for="price" style="display: block; margin-bottom: 8px; font-weight: 500; color: #1A1A1A;">Prix (€) *</label>
                            <input type="number" 
                                   step="0.01" 
                                   id="price" 
                                   name="price" 
                                   value="${product != null && product.price != null ? product.price : ''}" 
                                   required
                                   style="width: 100%; padding: 12px; border: 2px solid rgba(26,26,26,.1); border-radius: 8px; font-size: 14px;"/>
                        </div>

                        <div>
                            <label for="stockQuantity" style="display: block; margin-bottom: 8px; font-weight: 500; color: #1A1A1A;">Stock</label>
                            <input type="number" 
                                   id="stockQuantity" 
                                   name="stockQuantity" 
                                   value="${product != null && product.stockQuantity != null ? product.stockQuantity : 0}" 
                                   min="0"
                                   style="width: 100%; padding: 12px; border: 2px solid rgba(26,26,26,.1); border-radius: 8px; font-size: 14px;"/>
                        </div>
                    </div>

                    <div>
                        <label for="categoryId" style="display: block; margin-bottom: 8px; font-weight: 500; color: #1A1A1A;">Catégorie</label>
                        <select id="categoryId" 
                                name="categoryId"
                                style="width: 100%; padding: 12px; border: 2px solid rgba(26,26,26,.1); border-radius: 8px; font-size: 14px; background: white;">
                            <option value="">Aucune catégorie</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" ${product != null && product.category != null && product.category.id == category.id ? 'selected' : ''}>
                                    ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                </div>

                <div style="display: flex; gap: 12px; justify-content: flex-end; margin-top: 8px;">
                    <a href="<%= ctx %>/admin/products" class="admin-btn admin-btn-secondary">
                        Annuler
                    </a>
                    <button type="submit" class="admin-btn admin-btn-primary">
                        <svg class="admin-btn-icon" viewBox="0 0 24 24" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/>
                            <polyline points="17 21 17 13 7 13 7 21"/>
                            <polyline points="7 3 7 8 15 8"/>
                        </svg>
                        Enregistrer
                    </button>
                </div>
            </form>
        </div>

        <div style="margin-top: 24px; text-align: center;">
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
