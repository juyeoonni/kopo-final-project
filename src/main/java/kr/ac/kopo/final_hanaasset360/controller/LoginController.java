package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.service.UserService;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@Controller // 변경
@RequestMapping("/")
public class LoginController {

    @Autowired
    private UserService userService;

    @PostMapping("/login-process")
    public void loginProcess(@RequestParam String username,
                             @RequestParam String password,
                             HttpSession session,
                             HttpServletResponse response) throws IOException {
        UserVO user = userService.validateUser(username, password);
        System.out.println("User: " + user);
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            response.sendRedirect("/");
        } else {
            response.sendRedirect("/mypage/login");
        }
    }

}
