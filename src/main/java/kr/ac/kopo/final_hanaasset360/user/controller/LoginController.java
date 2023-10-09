package kr.ac.kopo.final_hanaasset360.user.controller;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.user.service.UserService;
import kr.ac.kopo.final_hanaasset360.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
            System.out.print(user.getUserType());
            if ("admin".equals(user.getUserType().trim())) {
                System.out.print(user.getUserType());
                response.sendRedirect("/admin/index");
            } else if("banker".equals(user.getUserType().trim())){
                System.out.print(user.getUserType());
                response.sendRedirect("/admin/adminIndex");
            }else {
                response.sendRedirect("/");
            }
        } else {
            response.sendRedirect("/mypage/login");
        }
    }

    @GetMapping("/login") // 추가된 부분
    public String login() {
        return "/mypage/login"; // "login"은 login.jsp의 이름입니다.
    }


}
