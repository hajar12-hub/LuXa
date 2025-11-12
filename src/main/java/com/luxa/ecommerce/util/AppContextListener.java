/*package com.luxa.ecommerce.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("=======================================================");
        System.out.println("===> L'APPLICATION backend3 DÉMARRE MAINTENANT ! <===");
        System.out.println("=======================================================");

        // --- NOUVELLE LIGNE TRÈS IMPORTANTE ---
        // On force l'initialisation de la connexion à la base de données
        try {
            System.out.println("===> Tentative d'initialisation de la connexion BDD...");
            JpaUtil.getEntityManagerFactory(); // Cette ligne va lire le persistence.xml
            System.out.println("===> Initialisation de la BDD réussie !");
        } catch (Exception e) {
            System.err.println("===> !!! ÉCHEC DE L'INITIALISATION DE LA BDD !!! <===");
            e.printStackTrace(); // AFFICHE L'ERREUR DÉTAILLÉE DANS LA CONSOLE
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("=====================================================");
        System.out.println("===> L'APPLICATION backend3 S'ARRÊTE MAINTENANT ! <===");
        System.out.println("=====================================================");

        // On ferme la connexion à la BDD proprement quand l'application s'arrête
        JpaUtil.closeEntityManagerFactory();
    }
}

 */
