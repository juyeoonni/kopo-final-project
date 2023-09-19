package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.message.LoanRequest;
import kr.ac.kopo.final_hanaasset360.message.LoanResponse;
import kr.ac.kopo.final_hanaasset360.message.LoanSwitchRequest;
import kr.ac.kopo.final_hanaasset360.service.AccountService;
import kr.ac.kopo.final_hanaasset360.service.LoanServiceImpl;
import kr.ac.kopo.final_hanaasset360.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class LoanController {

    @Autowired
    private LoanServiceImpl loanServiceImpl;
    @Autowired
    private AccountService accountService;
    @ResponseBody
    @PostMapping("/findLoans")
    public ResponseEntity<?> findLoans(@RequestBody LoanRequest loanRequest) {
        List<LoanProductVO> loanProducts = loanServiceImpl.findMatchingLoanProducts(loanRequest.getInterest(), loanRequest.getBalance(), loanRequest.getCreditScore());

        if (!loanProducts.isEmpty()) {
            return ResponseEntity.ok().body(new LoanResponse(loanProducts));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @ResponseBody
    @GetMapping("/loanproducts")
    public ResponseEntity<List<LoanProductVO>> getLoanProducts(@RequestParam(required = false) String sort) {
        List<LoanProductVO> sortedProducts = loanServiceImpl.getLoanProducts(sort);
        return new ResponseEntity<>(sortedProducts, HttpStatus.OK);
    }

    @PostMapping("/loanSwitch/loanSwitchStep")
    public String processLoanSwitchStep1(@RequestBody LoanSwitchRequest request, Model model, HttpSession session) {
        // ... 여기에서 request 객체를 사용하여 필요한 로직 처리

        System.out.println(request.getSelectedLoanProduct() + "hello");
        System.out.println(request.getCreditData());
        System.out.println(request.getSelectedLoanData());

        // HttpSession에 데이터를 저장
        session.setAttribute("selectedLoanProduct", request.getSelectedLoanProduct());
        session.setAttribute("creditData", request.getCreditData());
        session.setAttribute("selectedLoanData", request.getSelectedLoanData());

        // "/loanSwitch/loanSwitchStep2" 경로로 리다이렉트
        return "redirect:/loanSwitch/loanSwitchStep2";
    }


    @PostMapping("/loanSwitch/loanSwitchStep3")
    public String processData(@RequestBody LoanSwitchRequest loanSwitchRequest, Model model) {
        // 데이터를 Model에 추가
        model.addAttribute("selectedLoanProduct", loanSwitchRequest.getSelectedLoanProduct());
        model.addAttribute("selectedLoanData", loanSwitchRequest.getSelectedLoanData());
        model.addAttribute("creditData", loanSwitchRequest.getCreditData());

        // 다음 JSP 페이지로 리디렉션
        return "redirect:/loanSwitch/loanSwitchStep3";
    }

    @GetMapping("/loanSwitch/loanSwitchStep3")
    public String nextPage() {
        return "/loanSwitch/loanSwitchStep3";
    }

    @PostMapping("/loanSwitch/loanSwitchStep4")
    public String processData2(@RequestBody LoanSwitchRequest loanSwitchRequest, Model model) {
        // 데이터를 Model에 추가
        model.addAttribute("selectedLoanProduct", loanSwitchRequest.getSelectedLoanProduct());
        model.addAttribute("selectedLoanData", loanSwitchRequest.getSelectedLoanData());
        model.addAttribute("creditData", loanSwitchRequest.getCreditData());

        // 다음 JSP 페이지로 리디렉션
        return "redirect:/loanSwitch/loanSwitchStep4";
    }

    @GetMapping("/loanSwitch/loanSwitchStep4")
    public String nextPage2() {
        return "/loanSwitch/loanSwitchStep4";
    }

    @GetMapping("/loanSwitch/loanSwitchStep5")
    public String step5(Model model, HttpSession session) {
        System.out.println("step5()");
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        List<Accounts> accounts = accountService.getAccountsByUserId(loggedInUser.getUserId());
        model.addAttribute("personalId", loggedInUser.getPersonalId());
        model.addAttribute("accounts", accounts);
        return "/loanSwitch/loanSwitchStep5";
    }


    @GetMapping("/mypage/mypage")
    public String loanInfo(HttpSession session, Model model) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        String userId = loggedInUser.getUserId();
        System.out.println("userid : " + userId);
        Long totalLoan = loanServiceImpl.sumLoansByUserId(userId);
        model.addAttribute("totalLoan", totalLoan);

        // 데이터베이스에서 repaymentdate를 기준으로 대출 정보를 가져옵니다.
        List<LoanDetail> repayments = loanServiceImpl.getRepaymentsByUserId(userId);

        model.addAttribute("repayments", repayments);
        return "/mypage/mypage";
    }
}