package kr.ac.kopo.final_hanaasset360.loan.controller;

import kr.ac.kopo.final_hanaasset360.message.LoanStepRequest;
import kr.ac.kopo.final_hanaasset360.loan.service.LoanServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class LoanStepController {
    @Autowired
    private LoanServiceImpl loanServiceImpl;

    @PostMapping("/insertData")
    public ResponseEntity<String> insertData(@RequestBody LoanStepRequest loanRequest) {
        System.out.println(loanRequest.toString());
        loanServiceImpl.insertData(loanRequest);
        return ResponseEntity.ok("Data Inserted Successfully");
    }
}
