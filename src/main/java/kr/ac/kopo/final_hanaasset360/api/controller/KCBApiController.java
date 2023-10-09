package kr.ac.kopo.final_hanaasset360.api.controller;

import kr.ac.kopo.final_hanaasset360.api.service.UserCreditService;
import kr.ac.kopo.final_hanaasset360.api.vo.UserCredentialVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class KCBApiController {

    private final UserCreditService userCreditService;

    @Autowired
    public KCBApiController(UserCreditService userCreditService) {
        this.userCreditService = userCreditService;
    }

    @PostMapping("/credit-data")
    public ResponseEntity<String> forwardRequest(@RequestBody UserCredentialVO userCredential) {
        return userCreditService.sendKCBRequest(userCredential);
    }


}