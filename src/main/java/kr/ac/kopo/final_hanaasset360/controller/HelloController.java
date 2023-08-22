package kr.ac.kopo.final_hanaasset360.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {
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
}
