package kr.ac.kopo.final_hanaasset360.controller;


import kr.ac.kopo.final_hanaasset360.service.LoanApplyService;

import kr.ac.kopo.final_hanaasset360.service.LoanService;
import kr.ac.kopo.final_hanaasset360.vo.*;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class LoanSwitchController {


    @Autowired
    private LoanApplyService loanService;
    @Autowired
    private LoanService loanService2;


    @GetMapping("/admin/adminIndex")
    public String getAllLoans(Model model) {
        System.out.println("getAllLoans()");
        List<LoanApply> loans = loanService.getAllLoans();

        // 로그로 반환된 데이터 확인
        System.out.println("Fetched Loans: " + loans);
        model.addAttribute("loans", loans);
        return "/bankClerk/main"; // 해당 JSP 파일 이름
    }

    @GetMapping("/loanDetails")
    public String getLoanDetails(@RequestParam("id") Long loanId, Model model) {
        System.out.println("getLoanDetails()");
        LoanApplyDetail loan = loanService.findLoanById(loanId);  // 예제 코드, 실제 로직은 서비스 구현에 따라 다를 수 있습니다.
        LoanExisting loanExisting = loanService.findLoanExistingById(loanId);
        ApplyUserVO user = loanService.findUserById(loanExisting.getUserId());
        UserCreditState credit = loanService.findCreditById(loanExisting.getUserId());


        System.out.println(loan);
        model.addAttribute("loan", loan);
        model.addAttribute("loanExisting", loanExisting);
        model.addAttribute("user", user);
        model.addAttribute("credit", credit);
        return "/bankClerk/index";  // 상세 페이지의 view 이름
    }

    @ResponseBody
    @PutMapping("/approve-loan-switch")
    public ResponseEntity<String> approveLoanSwitch(@RequestBody LoanSwitchData loanSwitchData) {
        System.out.println(loanSwitchData.getLoanId());
        loanService2.switchLoan(loanSwitchData.getLoanId()); // 대출 변경 처리
        return ResponseEntity.ok("Loan switch approved successfully");

    }
}
