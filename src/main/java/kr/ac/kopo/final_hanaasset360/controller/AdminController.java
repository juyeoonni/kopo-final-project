package kr.ac.kopo.final_hanaasset360.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class AdminController {
//    @GetMapping("/admin/adminIndex")
//    public String admin() {
//        return "/bankClerk/main";
//    }
    @GetMapping("/admin/selectLoan")
    public String selectLoan() {
        return "/bankClerk/index";
    }

    @GetMapping("/admin/index")
    public String index() {
        return "/admin/index";
    }

    @GetMapping("/admin/member")
    public String member() {
        return "/admin/member";
    }
}
