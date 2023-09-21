package kr.ac.kopo.final_hanaasset360.controller;

import kr.ac.kopo.final_hanaasset360.service.MailService;
import kr.ac.kopo.final_hanaasset360.vo.MailVO;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@AllArgsConstructor
public class MailController {
    private final MailService mailService;

    @GetMapping("/mail")
    public String dispMail() {
        return "mail";
    }

    @PostMapping("/mail")
    public void execMail(MailVO mailDto) {
        mailService.mailSend(mailDto);
    }


    @GetMapping("/mail/test")
    public String mailTest() {
        return "/test/mailSender";
    }
}