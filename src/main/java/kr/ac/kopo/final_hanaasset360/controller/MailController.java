package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpServletRequest;
import kr.ac.kopo.final_hanaasset360.repository.UserRepository;
import kr.ac.kopo.final_hanaasset360.service.MailService;
import kr.ac.kopo.final_hanaasset360.vo.MailVO;
import kr.ac.kopo.final_hanaasset360.vo.User;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
public class MailController {

    @Autowired
    private MailService mailService;

    @Autowired
    private UserRepository userRepository;

    @RequestMapping(value = "/sendEmail", method = RequestMethod.POST)
    public String sendEmail(@RequestBody Map<String, String> payload) {
        System.out.println("sendMail들어옴");

        String userId = payload.get("userId");
        String finance = payload.get("finance");
        String subject = "Your loan application000000000000000000000";
        String text = "Your loan application is approved";
        String to = "";
        System.out.println(userId + " " + finance + " " + subject + " " + text);
        if ("하나은행".equals(finance)) {
            // 데이터베이스에서 userId에 해당하는 email을 찾습니다.
            User user = userRepository.findById(userId).orElse(null);
            if (user != null) {
                to = user.getEmail();
                System.out.println("to: " + to);
                mailService.sendSimpleMessage(to, subject, text);
            } else {
                return "redirect:/user-not-found";
            }
        }

        return "redirect:/";
    }

    @GetMapping("/mail/test")
    public String test() {
        return "/test/mailSender";
    }

}