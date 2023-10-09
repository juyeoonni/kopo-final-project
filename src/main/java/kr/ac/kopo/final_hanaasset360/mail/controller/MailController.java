package kr.ac.kopo.final_hanaasset360.mail.controller;

import kr.ac.kopo.final_hanaasset360.user.repository.UserRepository;
import kr.ac.kopo.final_hanaasset360.mail.service.MailService;
import kr.ac.kopo.final_hanaasset360.user.vo.User;
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
        String repaymentAccount = payload.get("repaymentAccount");
        String name = payload.get("name");
        String subject = "[하나은행] 대출 실행 안내";
        String text = "하나은행 대출 실행 안내\n" +
                "김하나님 안녕하세요. 하나은행입니다.\n" +
                "2023년 10월 04일 에 받은 "+ name +"의 상환계좌("+ repaymentAccount + ") 상세 내역 및 약정서를 안내해 드립니다.\n" +
                "계약서류는 하나은행 앱을 통해 언제든지 조회 가능하며, 요청하실 경우 우편 또는 이메일로 제공받으실 수 있습니다. 또한, 하나은행 대면센터를 방문하시면 서면으로도 제공받을 수 있습니다.\n" +
                "\n" +
                "개인정보 보안을 위해 자세한 내용은 보안 메일로 첨부 드리오니, 보안 메일을 다운로드 하여 내용을 확인해주시길 바랍니다.\n" +
                "\n" +
                "감사합니다.\n" +
                "하나은행 드림.";
        String to = "";
        System.out.println(userId + " " + finance + " " + subject + " " + text);

            // 데이터베이스에서 userId에 해당하는 email을 찾습니다.
        User user = userRepository.findById(userId).orElse(null);
        if (user != null) {
            to = user.getEmail();
            System.out.println("to: " + to);
            mailService.sendSimpleMessage(to, subject, text);
        } else {
            return "redirect:/user-not-found";
        }
        return "redirect:/";
    }


    @PostMapping("/sendEmail/member")
    public String sendEmailMember(@RequestBody Map<String, String> payload) {
        System.out.println("sendEmail 메서드 호출");


        // payload에서 필요한 데이터를 추출합니다.
        String email = payload.get("email"); // 받는 사람 이메일 주소
        String subject = payload.get("subject"); // 이메일 제목
        String message = payload.get("message"); // 이메일 본문

        System.out.println(email + subject + message);

        // 이메일 전송 로직을 추가합니다.
        mailService.sendSimpleMessage(email, subject, message);

        return "redirect:/success"; // 이메일 전송 성공 시 리다이렉트할 페이지를 지정합니다.
    }

    @GetMapping("/mail/test")
    public String test() {
        return "/test/mailSender";
    }

}