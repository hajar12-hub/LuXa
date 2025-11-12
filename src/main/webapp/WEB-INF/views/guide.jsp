<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guide de Taille & de Conservation | LuXa</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/guide.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/_header.jsp"/>

<main class="guide-page">
    <div class="guide-container">
        <section class="guide-section">
            <h1 class="guide-section-title">GUIDE DE TAILLE</h1>
            
            <div class="guide-content">
                <h2 class="guide-subtitle">Bagues</h2>
                <ol class="guide-list">
                    <li>Enroulez un fil autour de votre doigt.</li>
                    <li>Marquez l'endroit où le fil se rejoint.</li>
                    <li>Mesurez la longueur (en millimètres).</li>
                    <li>Reportez cette mesure sur notre tableau de correspondance.</li>
                </ol>
                
                <div class="table-wrapper">
                    <table class="guide-table">
                        <thead>
                            <tr>
                                <th>Tour de doigt (mm)</th>
                                <th>Taille FR</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td>44–46</td><td>4</td></tr>
                            <tr><td>47–49</td><td>5</td></tr>
                            <tr><td>50–52</td><td>6</td></tr>
                            <tr><td>53–55</td><td>7</td></tr>
                            <tr><td>56–58</td><td>8</td></tr>
                            <tr><td>59–61</td><td>9</td></tr>
                            <tr><td>62–64</td><td>10</td></tr>
                        </tbody>
                    </table>
                </div>
                
                <p class="guide-tip">💡 Astuce : mesurez votre doigt en fin de journée, jamais à froid — il est alors à sa taille naturelle.</p>
                
                <h2 class="guide-subtitle">Bracelets</h2>
                <p class="guide-text">Mesurez votre poignet avec un mètre ruban sans serrer.<br>
                Ajoutez 1 à 2 cm pour obtenir votre taille idéale.</p>
                
                <div class="table-wrapper">
                    <table class="guide-table">
                        <thead>
                            <tr>
                                <th>Tour de poignet (cm)</th>
                                <th>Taille du bracelet</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td>14–15</td><td>XS</td></tr>
                            <tr><td>16–17</td><td>S</td></tr>
                            <tr><td>18–19</td><td>M</td></tr>
                            <tr><td>20–21</td><td>L</td></tr>
                            <tr><td>22+</td><td>XL</td></tr>
                        </tbody>
                    </table>
                </div>
                
                <p class="guide-tip">🩶 Un bracelet doit épouser le poignet sans le comprimer.</p>
                
                <h2 class="guide-subtitle">Colliers</h2>
                
                <div class="table-wrapper">
                    <table class="guide-table">
                        <thead>
                            <tr>
                                <th>Style</th>
                                <th>Longueur (cm)</th>
                                <th>Effet</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr><td>Ras du cou</td><td>35–40</td><td>Met en valeur le cou</td></tr>
                            <tr><td>Standard</td><td>45–50</td><td>Polyvalent</td></tr>
                            <tr><td>Long</td><td>55–65</td><td>Élégant, fluide</td></tr>
                            <tr><td>Sautoir</td><td>70+</td><td>Accent mode, superposition</td></tr>
                        </tbody>
                    </table>
                </div>
                
                <p class="guide-tip">✨ Superposez plusieurs longueurs pour un effet moderne.</p>
                
                <h2 class="guide-subtitle">Montres</h2>
                <ul class="guide-list">
                    <li>Mesurez la circonférence du poignet.</li>
                    <li>Privilégiez un cadran :
                        <ul class="guide-sublist">
                            <li>≤ 36 mm pour un style discret</li>
                            <li>37–42 mm pour un style classique</li>
                            <li>&gt; 43 mm pour un style audacieux</li>
                        </ul>
                    </li>
                </ul>
            </div>
        </section>
        
        <section class="guide-section">
            <h1 class="guide-section-title">GUIDE DE CONSERVATION</h1>
            
            <div class="guide-content">
                <h2 class="guide-subtitle">1. Rangement</h2>
                <ul class="guide-list">
                    <li>Rangez chaque bijou séparément (poche, écrin ou pochette douce).</li>
                    <li>Évitez le contact entre les métaux pour prévenir les rayures.</li>
                    <li>Gardez-les dans un endroit sec et tempéré, à l'abri du soleil direct.</li>
                </ul>
                
                <h2 class="guide-subtitle">2. Bonnes pratiques au quotidien</h2>
                <ul class="guide-list">
                    <li>Mettez vos accessoires après le maquillage, le parfum ou la laque.</li>
                    <li>Retirez-les avant de dormir pour éviter les chocs et déformations.</li>
                    <li>Vérifiez régulièrement les fermoirs et attaches.</li>
                </ul>
            </div>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/views/_footer.jsp"/>

</body>
</html>

