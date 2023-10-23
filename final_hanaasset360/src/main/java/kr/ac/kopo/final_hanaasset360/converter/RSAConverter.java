package kr.ac.kopo.final_hanaasset360.converter;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class RSAConverter implements AttributeConverter<String, String> {

    @Override
    public String convertToDatabaseColumn(String attribute) {
        try {
            return RSAUtil.encrypt(attribute);
        } catch (Exception e) {
            throw new RuntimeException("RSA encryption error", e);
        }
    }

    @Override
    public String convertToEntityAttribute(String dbData) {
        try {
            return RSAUtil.decrypt(dbData);
        } catch (Exception e) {
            throw new RuntimeException("RSA decryption error", e);
        }
    }
}