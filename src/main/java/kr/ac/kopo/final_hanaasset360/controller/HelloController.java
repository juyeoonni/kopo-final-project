package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.service.UserService;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HelloController {
    @Autowired
    private UserService userService;
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
}
