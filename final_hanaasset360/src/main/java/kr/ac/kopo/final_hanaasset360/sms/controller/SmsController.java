package kr.ac.kopo.final_hanaasset360.sms.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.message.MessageRequest;
import kr.ac.kopo.final_hanaasset360.message.SmsResponse;
import kr.ac.kopo.final_hanaasset360.sms.service.SmsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@RestController
@RequiredArgsConstructor
public class SmsController {

    private final SmsService smsService;

    @PostMapping("/sms/sendUser")
    public ResponseEntity<SmsResponse> test(@RequestBody MessageRequest request, HttpServletRequest sessionRequest) throws NoSuchAlgorithmException, URISyntaxException, UnsupportedEncodingException, InvalidKeyException, JsonProcessingException {
        System.out.println("sms 컨틀롤러 들어옴");

        SmsResponse data = smsService.sendSms(request.getRecipientPhoneNumber(), request.getContent());
        System.out.println("data"+request.getOuathNum());
        HttpSession session = sessionRequest.getSession();
        session.setAttribute("ouathNum",request.getOuathNum());
        return ResponseEntity.ok().body(data);
    }


    @PostMapping("/sms/verify")
    public String smsVerify(@RequestBody SmsResponse smsResponseDto,HttpServletRequest sessionRequest) {
        HttpSession session = sessionRequest.getSession();
        String ouathNum=(String)session.getAttribute("ouathNum");
        String userResponseOuathNum=smsResponseDto.getSmsConfirmNum();
        if (smsService.verifyOuath(ouathNum,userResponseOuathNum)){
            return "본인인증성공";
        }
        else{
            return "본인인증실패";
        }
    }

    @GetMapping("/sms/verifyPage")
    public String showVerifyPage() {
        return "/test/smsVerify"; // JSP 페이지 이름
    }
}
