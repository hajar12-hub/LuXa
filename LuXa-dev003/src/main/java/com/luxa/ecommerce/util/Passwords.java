package com.luxa.ecommerce.util;

import org.mindrot.jbcrypt.BCrypt; // si tu veux utiliser cette lib, ajoute-la au pom

public class Passwords {
    //un constructeur prive veut dire que perssonne ne peut creer un objet de cette classe
    private Passwords(){}
    public static String hashBCrypt(String raw){
        return BCrypt.hashpw(raw, BCrypt.gensalt(12));
    }
    //raw mot de passe en clair
    public static boolean check(String raw, String hashed){
        return BCrypt.checkpw(raw, hashed);
    }
}
