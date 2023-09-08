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
    public String step5(Model model) {
        // 여기서 필요한 로직을 수행하고
        // JSP 페이지 이름을 반환하면 그 페이지로 이동됩니다.
        return "/loanSwitch/loanSwitchStep5";
    }

}