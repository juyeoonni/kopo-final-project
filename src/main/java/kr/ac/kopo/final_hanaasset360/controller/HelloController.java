package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {
    @Autowired
    private UserServiceImpl userServiceImpl;
    @GetMapping("/")
    public String hello() {
        return "index";
    }

    @GetMapping("/login") // 추가된 부분
    public String login() {
        return "/mypage/login"; // "login"은 login.jsp의 이름입니다.
    }


    @GetMapping("/calculator")
    public String calculator() {
        return "/calculator/loanCalculator";
    }

    @GetMapping("/calculator/loanCalculator")
    public String loanCalculator() {
        return "/calculator/loanCalculator";
    }

    @GetMapping("/calculator/savings")
    public String savingsCalculator() {
        return "/calculator/savings";
    }

    @GetMapping("/calculator/deposit")
    public String depositCalculator() {
        return "/calculator/deposit";
    }

    @GetMapping("/calculator/incomededuction")
    public String incomedeductionCalculator() {
        return "/calculator/incomededuction";
    }

    @GetMapping("/loanSwitch/loanswitch")
    public String loanswitch() {
        return "/loanSwitch/loanswitch";
    }

    @GetMapping("/loanSwitch/loanSwitchIndex")
    public String loanSwitchIndex() {
        return "/loanSwitch/loanSwitchIndex";
    }

    @GetMapping("/loanProduct/loanProduct")
    public String loanproduct() {
        return "/loanProduct/loanProduct";
    }

    @GetMapping("/loanSwitch/loanSwitchStep2")
    public String loanSwitchStep2(Model model, HttpSession session) {
        // HttpSession에서 데이터를 가져와 Model에 추가
        model.addAttribute("selectedLoanProduct", session.getAttribute("selectedLoanProduct"));
        model.addAttribute("creditData", session.getAttribute("creditData"));
        model.addAttribute("selectedLoanData", session.getAttribute("selectedLoanData"));

        return "/loanSwitch/loanSwitchStep2";
    }



    @GetMapping("/sms/verifyPage")
    public String showVerifyPage() {
        return "/test/smsVerify"; // JSP 페이지 이름
    }





}
