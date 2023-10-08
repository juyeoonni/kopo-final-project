package kr.ac.kopo.final_hanaasset360.converter;

// RSAKeyUtil.java

import java.io.*;
import java.security.*;

public class RSAKeyUtil {

    private static final String CURRENT_DIR = System.getProperty("user.dir");
    public static final String PUBLIC_KEY_FILE = CURRENT_DIR + File.separator + "publicKey";
    public static final String PRIVATE_KEY_FILE = CURRENT_DIR + File.separator + "privateKey";

    public static void generateAndSaveKeyPair() throws Exception {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(2048);
        KeyPair keyPair = keyPairGenerator.generateKeyPair();

        try (ObjectOutputStream publicKeyOS = new ObjectOutputStream(new FileOutputStream(PUBLIC_KEY_FILE))) {
            publicKeyOS.writeObject(keyPair.getPublic());
        }

        try (ObjectOutputStream privateKeyOS = new ObjectOutputStream(new FileOutputStream(PRIVATE_KEY_FILE))) {
            privateKeyOS.writeObject(keyPair.getPrivate());
        }

        System.out.println("Public key saved to: " + new File(PUBLIC_KEY_FILE).getAbsolutePath());
        System.out.println("Private key saved to: " + new File(PRIVATE_KEY_FILE).getAbsolutePath());
    }

    public static KeyPair loadKeyPair() throws Exception {
        System.out.println("Loading public key from: " + new File(PUBLIC_KEY_FILE).getAbsolutePath());
        System.out.println("Loading private key from: " + new File(PRIVATE_KEY_FILE).getAbsolutePath());
        try (ObjectInputStream publicKeyIS = new ObjectInputStream(new FileInputStream(PUBLIC_KEY_FILE));
             ObjectInputStream privateKeyIS = new ObjectInputStream(new FileInputStream(PRIVATE_KEY_FILE))) {
            return new KeyPair((PublicKey) publicKeyIS.readObject(), (PrivateKey) privateKeyIS.readObject());
        }
    }
}
