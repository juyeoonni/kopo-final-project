package kr.ac.kopo.final_hanaasset360.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    @GetMapping("/")
    public String root() {
        return "index";
    }
}
