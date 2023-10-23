package kr.ac.kopo.final_hanaasset360.mail.service;

public interface MailService {
    void sendSimpleMessage(String to, String subject, String text);
}
