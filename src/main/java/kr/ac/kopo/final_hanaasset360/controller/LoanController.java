package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.message.LoanRequest;
import kr.ac.kopo.final_hanaasset360.message.LoanResponse;
import kr.ac.kopo.final_hanaasset360.message.LoanSwitchRequest;
import kr.ac.kopo.final_hanaasset360.service.LoanService;
import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class LoanController {

    @Autowired
    private LoanService loanService;

    @ResponseBody
    @PostMapping("/findLoans")
    public ResponseEntity<?> findLoans(@RequestBody LoanRequest loanRequest) {
        List<LoanProductVO> loanProducts = loanService.findMatchingLoanProducts(loanRequest.getInterest(), loanRequest.getBalance(), loanRequest.getCreditScore());

        if (!loanProducts.isEmpty()) {
            return ResponseEntity.ok().body(new LoanResponse(loanProducts));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @ResponseBody
    @GetMapping("/loanproducts")
    public ResponseEntity<List<LoanProductVO>> getLoanProducts(@RequestParam(required = false) String sort) {
        List<LoanProductVO> sortedProducts = loanService.getLoanProducts(sort);
        return new ResponseEntity<>(sortedProducts, HttpStatus.OK);
    }

    //    @PostMapping("/loanSwitch/loanSwitchStep")
//    public String processLoanSwitch(@RequestBody LoanSwitchRequest request, Model model) {
//        model.addAttribute("selectedLoanProduct", request.getSelectedLoanProduct());
//        model.addAttribute("creditData", request.getCreditData());
//        model.addAttribute("selectedLoanData", request.getSelectedLoanData());
//
//        System.out.println(request.getSelectedLoanProduct());
//        System.out.println(request.getCreditData());
//        System.out.println(request.getSelectedLoanData());
//
//        return "/loanSwitch/loanSwitchStep2";
//    }
    @PostMapping("/loanSwitch/loanSwitchStep")
    public String processLoanSwitch(@RequestBody LoanSwitchRequest request, Model model, HttpSession session) {
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


}