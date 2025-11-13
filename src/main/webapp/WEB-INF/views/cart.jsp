<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%
    String ctx = request.getContextPath();
%>
<jsp:include page="partials/_header.jsp"/>

<main class="cart-wrap">
    <div class="container-xl">
        <h1 class="cart-title">Mon Panier</h1>

        <c:if test="${empty cartItems or cartItems.size() == 0}">
            <div class="cart-empty">
                <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" class="empty-icon">
                    <path d="M6 2l1 2h10l1-2"/>
                    <path d="M6 6h12l-1 12H7L6 6z"/>
                    <circle cx="9" cy="22" r="1"/>
                    <circle cx="17" cy="22" r="1"/>
                </svg>
                <h2>Votre panier est vide</h2>
                <p>Découvrez nos collections et ajoutez des articles à votre panier.</p>
                <a href="<%= ctx %>/catalogue" class="btn btn-primary">Explorer le catalogue</a>
            </div>
        </c:if>

        <c:if test="${not empty cartItems and cartItems.size() > 0}">
            <div class="cart-grid">
                <!-- Colonne Articles -->
                <div class="cart-items">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item" data-product-id="${item.productId}">
                            <div class="item-image">
                                <c:if test="${not empty item.imageUrl}">
                                    <img src="${item.imageUrl}" alt="${item.name}">
                                </c:if>
                                <c:if test="${empty item.imageUrl}">
                                    <img src="https://via.placeholder.com/150x150" alt="${item.name}">
                                </c:if>
                            </div>

                            <div class="item-details">
                                <h3 class="item-name">
                                    <a href="<%= ctx %>/product/${item.productId}">${item.name}</a>
                                </h3>
                                <div class="item-price-unit">
                                    <fmt:formatNumber value="${item.unitPrice}" type="currency" currencyCode="MAD" minFractionDigits="2"/>
                                </div>
                            </div>

                            <div class="item-quantity">
                                <form method="post" action="<%= ctx %>/cart/update" class="qty-form">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <div class="quantity-controls">
                                        <button type="button" class="qty-btn qty-decrease" aria-label="Diminuer">−</button>
                                        <input type="number" name="quantity" value="${item.qty}" min="1" 
                                               class="qty-input" data-product-id="${item.productId}">
                                        <button type="button" class="qty-btn qty-increase" aria-label="Augmenter">+</button>
                                    </div>
                                </form>
                            </div>

                            <div class="item-total">
                                <span class="item-total-label">Total</span>
                                <span class="item-total-price">
                                    <fmt:formatNumber value="${item.lineTotal}" type="currency" currencyCode="MAD" minFractionDigits="2"/>
                                </span>
                            </div>

                            <div class="item-actions">
                                <form method="post" action="<%= ctx %>/cart/remove" class="remove-form">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <button type="submit" class="btn-remove" aria-label="Retirer du panier">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <line x1="18" y1="6" x2="6" y2="18"/>
                                            <line x1="6" y1="6" x2="18" y2="18"/>
                                        </svg>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Colonne Récapitulatif -->
                <div class="cart-summary">
                    <div class="summary-card">
                        <h2 class="summary-title">Récapitulatif</h2>
                        
                        <div class="summary-row">
                            <span>Sous-total</span>
                            <span class="summary-value">
                                <fmt:formatNumber value="${cartSubtotal}" type="currency" currencyCode="MAD" minFractionDigits="2"/>
                            </span>
                        </div>

                        <div class="summary-row">
                            <span>Livraison</span>
                            <span class="summary-value">Gratuite</span>
                        </div>

                        <hr class="summary-separator">

                        <div class="summary-row summary-total">
                            <span>Total</span>
                            <span class="summary-value">
                                <fmt:formatNumber value="${cartSubtotal}" type="currency" currencyCode="MAD" minFractionDigits="2"/>
                            </span>
                        </div>

                        <a href="<%= ctx %>/checkout" class="btn btn-primary btn-checkout">
                            Passer la commande
                        </a>

                        <a href="<%= ctx %>/catalogue" class="link-continue">
                            ← Continuer mes achats
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</main>

<script>
    // Gestion de la quantité dans le panier
    document.querySelectorAll('.qty-input').forEach(input => {
        const productId = input.getAttribute('data-product-id');
        const form = input.closest('.qty-form');
        const decreaseBtn = input.parentElement.querySelector('.qty-decrease');
        const increaseBtn = input.parentElement.querySelector('.qty-increase');

        decreaseBtn.addEventListener('click', () => {
            let val = parseInt(input.value) || 1;
            if (val > 1) {
                val--;
                input.value = val;
                form.submit();
            }
        });

        increaseBtn.addEventListener('click', () => {
            let val = parseInt(input.value) || 1;
            val++;
            input.value = val;
            form.submit();
        });

        input.addEventListener('change', function() {
            let val = parseInt(this.value) || 1;
            if (val < 1) val = 1;
            this.value = val;
            form.submit();
        });
    });
</script>

<jsp:include page="partials/_footer.jsp"/>

