package kr.ac.kopo.final_hanaasset360.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {
    @GetMapping("/mypage/index")
    public String index() {
        return "/mypage/index";
    }

    @GetMapping("/mypage/loanEvaluation")
    public String loanEvaluation() {
        return "/mypage/loanEvaluation";
    }

    @GetMapping("/mypage/dsr")
    public String dsr() {
        return "/mypage/dsr";
    }
}
