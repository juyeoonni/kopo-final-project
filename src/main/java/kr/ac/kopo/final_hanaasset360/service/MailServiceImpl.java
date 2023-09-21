package kr.ac.kopo.final_hanaasset360.service;

import jakarta.mail.Message;
import jakarta.mail.internet.MimeMessage;
import kr.ac.kopo.final_hanaasset360.vo.MailVO;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class MailServiceImpl implements MailService{
    private JavaMailSender mailSender;
    private static final String FROM_ADDRESS = "qwe2846@naver.com";

    public void mailSend(MailVO mailDto) {
//        MimeMessage message = mailSender.createMimeMessage();
//        message.addRecipients(Message.RecipientType.TO, ADMIN_ADDRESS);
//        message.setSubject("[이케이하나관광 견적요청]");
//        String text = "";
//        text += form.getName() + " " + form.getPhone() + "\n";
//        text += form.getTravelType() + " " + form.getVehicleType() + " " + form.getVehicleNumber() + "\n";
//        text += form.getDepartPlace() + " ~ " + form.getArrivalPlace() + "\n";
//        text += "경유지(" + form.getStopPlace() + ")\n";
//        text += form.getDepartDate() + " ~ " + form.getArrivalDate() + "\n";
//        message.setText(text, "utf-8");
//        message.setFrom(new InternetAddress(ADMIN_ADDRESS, form.getName()));
//        mailSender.send(message);
    }
}
