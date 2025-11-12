<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Votre Panier - LuXa</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/_header.jsp"/>

<div class="cart-page">
    <div class="cart-page-container">
        <c:choose>
            <c:when test="${empty cart.lines}">
                <!-- Empty Cart State -->
                <div class="cart-empty">
                    <div class="cart-empty-icon">🛍️</div>
                    <h2 class="cart-empty-title">Votre panier est vide</h2>
                    <p class="cart-empty-text">
                        Découvrez nos créations d'exception et trouvez la pièce parfaite.
                    </p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                        Découvrir nos Collections
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <h1 class="cart-page-title">Votre Panier</h1>
                
                <div class="cart-grid">
                    <!-- Cart Items -->
                    <div class="cart-items">
                        <c:forEach var="line" items="${cart.lines}">
                            <div class="cart-item">
                                <div class="cart-item-image">
                                    <c:choose>
                                        <c:when test="${not empty line.item.imageUrl}">
                                            <img src="${line.item.imageUrl}" alt="${line.item.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="cart-item-placeholder"></div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="cart-item-details">
                                    <p class="cart-item-category">Produit</p>
                                    <h3 class="cart-item-name">${line.item.name}</h3>
                                    <p class="cart-item-price">
                                        <fmt:formatNumber value="${line.item.effectiveUnitPrice}" type="currency" currencySymbol="€"/>
                                    </p>
                                    
                                    <div class="cart-item-controls">
                                        <div class="quantity-controls">
                                            <c:if test="${line.qty > 1}">
                                                <form action="${pageContext.request.contextPath}/cart/update" method="post" class="quantity-form">
                                                    <input type="hidden" name="productId" value="${line.item.id}">
                                                    <input type="hidden" name="qty" value="${line.qty - 1}">
                                                    <button type="submit" class="quantity-btn quantity-minus">−</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${line.qty <= 1}">
                                                <button type="button" class="quantity-btn quantity-minus" disabled>−</button>
                                            </c:if>
                                            <span class="quantity-value">${line.qty}</span>
                                            <form action="${pageContext.request.contextPath}/cart/update" method="post" class="quantity-form">
                                                <input type="hidden" name="productId" value="${line.item.id}">
                                                <input type="hidden" name="qty" value="${line.qty + 1}">
                                                <button type="submit" class="quantity-btn quantity-plus">+</button>
                                            </form>
                                        </div>
                                        
                                        <form action="${pageContext.request.contextPath}/cart/remove" method="post" class="remove-form">
                                            <input type="hidden" name="productId" value="${line.item.id}">
                                            <button type="submit" class="cart-item-remove" aria-label="Supprimer">
                                                🗑️
                                            </button>
                                        </form>
                                    </div>
                                </div>
                                
                                <div class="cart-item-total">
                                    <p class="cart-item-total-price">
                                        <fmt:formatNumber value="${line.lineTotal}" type="currency" currencySymbol="€"/>
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Cart Summary -->
                    <div class="cart-summary">
                        <div class="cart-summary-content">
                            <h3 class="cart-summary-title">Résumé de la Commande</h3>
                            
                            <div class="cart-summary-details">
                                <div class="summary-row">
                                    <span>Sous-total</span>
                                    <span>
                                        <fmt:formatNumber value="${cart.subtotal}" type="currency" currencySymbol="€"/>
                                    </span>
                                </div>
                                <div class="summary-row">
                                    <span>Livraison Assurée</span>
                                    <span>Gratuite</span>
                                </div>
                                <div class="summary-row">
                                    <span>Emballage Premium</span>
                                    <span>Offert</span>
                                </div>
                                
                                <div class="summary-divider"></div>
                                
                                <div class="summary-total">
                                    <span>Total</span>
                                    <span class="total-amount">
                                        <fmt:formatNumber value="${cart.total}" type="currency" currencySymbol="€"/>
                                    </span>
                                </div>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-checkout">
                                <span class="btn-checkout-text">Procéder au Paiement</span>
                                <span class="btn-checkout-glow"></span>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-continue">
                                Continuer vos achats
                            </a>
                            
                            <div class="cart-summary-footer">
                                <p>🔒 Paiement sécurisé</p>
                                <p>📦 Livraison assurée avec suivi</p>
                                <p>💎 Certificat d'authenticité inclus</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/views/_footer.jsp"/>

</body>
</html>
