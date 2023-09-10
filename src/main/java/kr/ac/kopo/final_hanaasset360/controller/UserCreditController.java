package kr.ac.kopo.final_hanaasset360.controller;

import kr.ac.kopo.final_hanaasset360.service.UserCreditService;
import kr.ac.kopo.final_hanaasset360.vo.UserCredit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping
public class UserCreditController  {

    private final UserCreditService userCreditService;

    @Autowired
    public UserCreditController(UserCreditService  userCreditService) {
        this.userCreditService = userCreditService;
    }

    @PostMapping("/credit-data")
    public ResponseEntity<Void> insertUserCredit(@RequestBody UserCredit userCredit) {


        System.out.println("Received UserCredit object: " + userCredit.toString());
        // 클라이언트에서 ID와 USERID를 채워서 전송해야 합니다.
        userCreditService.saveUserCredit(userCredit);
        return ResponseEntity.ok().build();  // 200 OK 응답만 반환
    }


}
