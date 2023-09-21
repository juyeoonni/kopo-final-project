package kr.ac.kopo.final_hanaasset360.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import kr.ac.kopo.final_hanaasset360.message.SmsResponse;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public interface SmsService {
    public SmsResponse sendSms(String recipientPhoneNumber, String content) throws JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, URISyntaxException;
    public String makeSignature(Long time) throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException;
    public boolean verifyOuath(String ouathNum, String userResponseOuathNum);

}
