package kr.ac.kopo.final_hanaasset360.controller;

import kr.ac.kopo.final_hanaasset360.message.LoanRequest;
import kr.ac.kopo.final_hanaasset360.message.LoanResponse;
import kr.ac.kopo.final_hanaasset360.service.LoanService;
import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class LoanController {

    @Autowired
    private LoanService loanService;

    @PostMapping("/findLoans")
    public ResponseEntity<?> findLoans(@RequestBody LoanRequest loanRequest) {
        List<LoanProductVO> loanProducts = loanService.findMatchingLoanProducts(loanRequest.getInterest(), loanRequest.getBalance(), loanRequest.getCreditScore());

        if (!loanProducts.isEmpty()) {
            return ResponseEntity.ok().body(new LoanResponse(loanProducts));
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}