<%
    String ctx = request.getContextPath();
%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<footer class="luxa-footer">
    <div class="luxa-foot-container">
        <div class="luxa-foot-grid">
            <!-- Col 1 : Brand -->
            <div class="foot-col">
                <a class="foot-brand" href="<%= ctx %>/home">
                    Lu<span class="x-gold">X</span>a
                </a>
                <p class="foot-tagline">L'excellence du luxe à portée de main.</p>
            </div>

            <!-- Col 2 : Boutique -->
            <div class="foot-col">
                <h4 class="foot-title">Boutique</h4>
                <ul class="foot-list">
                    <li><a href="<%= ctx %>/products">Tous les Produits</a></li>
                    <li><a href="<%= ctx %>/products?sort=new">Nouveautés</a></li>
                    <li><a href="<%= ctx %>/products?filter=best">Best Sellers</a></li>
                </ul>
            </div>

            <!-- Col 3 : Aide -->
            <div class="foot-col">
                <h4 class="foot-title">Aide</h4>
                <ul class="foot-list">
                    <li><a href="<%= ctx %>/contact">Contact</a></li>
                    <li><a href="<%= ctx %>/shipping">Livraison</a></li>
                    <li><a href="<%= ctx %>/returns">Retours</a></li>
                </ul>
            </div>

            <!-- Col 4 : Réseaux -->
            <div class="foot-col">
                <h4 class="foot-title">Suivez-nous</h4>
                <div class="socials">
                    <a href="#" class="icon-btn" aria-label="Instagram">
                        <!-- Instagram -->
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="2" y="2" width="20" height="20" rx="5"></rect>
                            <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                            <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                        </svg>
                    </a>
                    <a href="#" class="icon-btn" aria-label="Facebook">
                        <!-- Facebook -->
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path>
                        </svg>
                    </a>
                    <a href="#" class="icon-btn" aria-label="Twitter">
                        <!-- Twitter/X -->
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 4l16 16M20 4L4 20"></path>
                        </svg>
                    </a>
                </div>
            </div>
        </div>

        <hr class="foot-sep" />
        <p class="foot-copy">© 2025 LuXa. Tous droits réservés.</p>
    </div>
</footer>
