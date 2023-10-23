package kr.ac.kopo.final_hanaasset360.converter;

import javax.crypto.Cipher;
import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.Base64;

public class RSAUtil {
    private static PublicKey publicKey;
    private static PrivateKey privateKey;

    static {
        try {
            KeyPair keyPair = RSAKeyUtil.loadKeyPair();
            publicKey = keyPair.getPublic();
            privateKey = keyPair.getPrivate();
            System.out.println("Public Key: " + Base64.getEncoder().encodeToString(publicKey.getEncoded()));
            System.out.println("Private Key: " + Base64.getEncoder().encodeToString(privateKey.getEncoded()));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String encrypt(String data) {
        try {
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            return Base64.getEncoder().encodeToString(cipher.doFinal(data.getBytes(StandardCharsets.UTF_8)));
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String decrypt(String encryptedData) {
        try {
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            return new String(cipher.doFinal(Base64.getDecoder().decode(encryptedData)), StandardCharsets.UTF_8);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
