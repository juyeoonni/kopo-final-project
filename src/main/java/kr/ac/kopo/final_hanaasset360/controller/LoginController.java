package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.service.UserServiceImpl;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;

@Controller // 변경
@RequestMapping("/")
public class LoginController {

    @Autowired
    private UserServiceImpl userServiceImpl;

    @PostMapping("/login-process")
    public void loginProcess(@RequestParam String username,
                             @RequestParam String password,
                             HttpSession session,
                             HttpServletResponse response) throws IOException {
        UserVO user = userServiceImpl.validateUser(username, password);
        System.out.println("User: " + user);

        if (user != null) {
            session.setAttribute("loggedInUser", user);
            System.out.print(user.getUserType());
            if ("admin".equals(user.getUserType().trim())) {
                System.out.print(user.getUserType());
                response.sendRedirect("/admin/adminIndex");
            } else {
                response.sendRedirect("/");
            }
        } else {
            response.sendRedirect("/mypage/login");
        }
    }


}
