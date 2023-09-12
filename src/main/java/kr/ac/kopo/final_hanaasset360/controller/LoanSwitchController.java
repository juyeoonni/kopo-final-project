package kr.ac.kopo.final_hanaasset360.controller;


import kr.ac.kopo.final_hanaasset360.service.LoanApplyServiceImpl;

import kr.ac.kopo.final_hanaasset360.service.LoanServiceImpl;
import kr.ac.kopo.final_hanaasset360.vo.*;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class LoanSwitchController {


    @Autowired
    private LoanApplyServiceImpl loanApplyServiceImpl;
    @Autowired
    private LoanServiceImpl loanServiceImpl;


    @GetMapping("/admin/adminIndex")
    public String getAllLoans(Model model) {
        System.out.println("getAllLoans()");
        List<LoanApply> loans = loanApplyServiceImpl.getAllLoans();

        // 로그로 반환된 데이터 확인
        System.out.println("Fetched Loans: " + loans);
        model.addAttribute("loans", loans);
        return "/bankClerk/main"; // 해당 JSP 파일 이름
    }

    @GetMapping("/loanDetails")
    public String getLoanDetails(@RequestParam("id") Long loanId, Model model) {
        System.out.println("getLoanDetails()");
        LoanApplyDetail loan = loanApplyServiceImpl.findLoanById(loanId);
        System.out.println(loan.getExistingFinance());
        LoanExisting loanExisting;
        if(loan.getExistingFinance().equals("하나은행")){
            loanExisting = loanApplyServiceImpl.findLoanExistingById(loanId);
            System.out.println(loanExisting);

        }else{
            System.out.println("외부API");
            loanExisting = loanApplyServiceImpl.findAPILoanExistingById(loanId,loan.getExistingFinance());
            System.out.println(loanExisting);
        }

        ApplyUserVO user = loanApplyServiceImpl.findUserById(loanExisting.getUserId());
        UserCreditState credit = loanApplyServiceImpl.findCreditById(loanExisting.getUserId());

        model.addAttribute("loan", loan);
        model.addAttribute("loanExisting", loanExisting);
        model.addAttribute("user", user);
        model.addAttribute("credit", credit);

        return "/bankClerk/index";
    }

    @ResponseBody
    @PutMapping("/approve-loan-switch")
    public ResponseEntity<String> approveLoanSwitch(@RequestBody LoanSwitchData loanSwitchData) {
        loanServiceImpl.switchLoan(loanSwitchData.getLoanId(), loanSwitchData.getLoanExistingFinance(), loanSwitchData.getUserId()); // 대출 변경 처리
        return ResponseEntity.ok("Loan switch approved successfully");

    }
}
