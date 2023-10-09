package kr.ac.kopo.final_hanaasset360.controller;


import kr.ac.kopo.final_hanaasset360.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class UserControeller {

    @Autowired
    private UserService userService;

    @GetMapping("/recent-registrations")
    public List<Map<String, Object>> getRecentRegistrations() {
        return userService.getRecentRegistrations();
    }
}
