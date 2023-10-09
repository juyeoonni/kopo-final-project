package kr.ac.kopo.final_hanaasset360.controller;

import kr.ac.kopo.final_hanaasset360.service.UserService;
import kr.ac.kopo.final_hanaasset360.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class AdminController {
    @Autowired
    UserService userService;

    @GetMapping("/admin/selectLoan")
    public String selectLoan() {
        return "/bankClerk/index";
    }

    @GetMapping("/admin/index")
    public String index(Model model, @PageableDefault(size = 5) Pageable pageable) {
        Page<User> members = userService.findUsers(pageable);
        Long recentLogins = userService.countRecentLogins();
        Long recentRegistrations = userService.countRecentRegistrations();

        model.addAttribute("recentRegistrations", recentRegistrations);
        model.addAttribute("recentLogins", recentLogins);
        model.addAttribute("members", members);
        model.addAttribute("totalMembers", members.getTotalElements());
        return "/admin/index";
    }

    @GetMapping("/admin/member")
    public String member(Model model, @PageableDefault(size = 5) Pageable pageable) {
        Page<User> members = userService.findUsers(pageable);
        model.addAttribute("members", members);
        return "/admin/member";
    }
}
