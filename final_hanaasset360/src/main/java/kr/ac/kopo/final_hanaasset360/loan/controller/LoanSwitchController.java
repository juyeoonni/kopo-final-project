package kr.ac.kopo.final_hanaasset360.loan.controller;


import kr.ac.kopo.final_hanaasset360.api.vo.UserCreditState;
import kr.ac.kopo.final_hanaasset360.loan.repository.LoanRecordsRepository;
import kr.ac.kopo.final_hanaasset360.loan.vo.*;
import kr.ac.kopo.final_hanaasset360.user.repository.UserRepository;
import kr.ac.kopo.final_hanaasset360.loan.service.LoanApplyServiceImpl;

import kr.ac.kopo.final_hanaasset360.loan.service.LoanServiceImpl;
import kr.ac.kopo.final_hanaasset360.user.vo.ApplyUserVO;
import kr.ac.kopo.final_hanaasset360.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class LoanSwitchController {


    @Autowired
    private LoanApplyServiceImpl loanApplyServiceImpl;
    @Autowired
    private LoanServiceImpl loanServiceImpl;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private LoanRecordsRepository loanRecordsRepository;

    @Autowired
    private RestTemplate restTemplate;

    @GetMapping("/admin/adminIndex")
    public String getAllLoans(Model model) {
        System.out.println("getAllLoans()");
        List<LoanApply> loans = loanApplyServiceImpl.getAllLoans();

        // 로그로 반환된 데이터 확인
        System.out.println("Fetched Loans: " + loans);

        // DateTimeFormatter 정의
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"); // 여기에 실제 패턴 맞춰서 수정해야 함

        // loans 리스트 정렬
        loans.sort(Comparator.comparing(loan -> LocalDateTime.parse(loan.getApplicationDate(), formatter)));
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
        String userIdFromLoanExisting = loanExisting.getUserId();
        Optional<User> users = userRepository.findByUserId(userIdFromLoanExisting);
        Long personalId = null;
        if (users.isPresent()) {
            personalId = users.get().getPersonalId();
        } else {
            // Handle user not found
        }

        List<String> banks = Arrays.asList("우리은행", "신한은행", "국민은행");
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl("http://16.171.189.30:8080/gwanjung/loan-response")
                .queryParam("personalIdNumber", personalId);
        for (String bank : banks) {
            uriBuilder.queryParam("banks", bank);
        }

        URI uri = uriBuilder.build().encode().toUri();
        Loan[] loanArray = restTemplate.getForObject(uri, Loan[].class);
        List<Loan> loans = new ArrayList<>(Arrays.asList(loanArray));

        // 기존의 loanManagement에서 가져온 정보
        List<LoanRecords> loanRecords = loanRecordsRepository.findByUserId(loanExisting.getUserId());

        // 두 정보를 하나의 리스트로 합치기
        List<Object> combinedLoans = new ArrayList<>();
        combinedLoans.addAll(loans);
        combinedLoans.addAll(loanRecords);

        long totalLoanAmount = 0;
        for (Loan loanin : loans) {
            totalLoanAmount += loanin.getLoanBalance();
        }

        long totalBalance = 0;
        for (LoanRecords record : loanRecords) {
            totalBalance += record.getLoanBalance();
        }

        long totalCombinedLoanAmount = totalLoanAmount + totalBalance;

        System.out.println(loanExisting.getUserId());
        ApplyUserVO user = loanApplyServiceImpl.findUserById(loanExisting.getUserId());
        UserCreditState credit = loanApplyServiceImpl.findCreditById(loanExisting.getUserId());
        System.out.println(credit.getAnnualIncome());
        long annualIncome = credit.getAnnualIncome();
        double totalMonthlyRepayment = 0.0;

        // combinedLoans 리스트를 돌면서 월별 상환액을 계산
        for (Object loanObj : combinedLoans) {
            if (loanObj instanceof LoanRecords) {
                LoanRecords loanRecord = (LoanRecords) loanObj;
                totalMonthlyRepayment += calculateMonthlyRepayment(loanRecord);
            } else if (loanObj instanceof Loan) {
                Loan loant = (Loan) loanObj;
                totalMonthlyRepayment += calculateMonthlyRepaymentForLoan(loant);  // 새로 작성한 메소드를 호출
            }
        }

        // 월별 수입으로 변환
        double monthlyIncome = (double) annualIncome / 12;

        // DSR 계산
        double dsr = (totalMonthlyRepayment / monthlyIncome) * 100;

        // DSR 값을 Model에 추가
        model.addAttribute("dsr", dsr);
        model.addAttribute("loan", loan);
        model.addAttribute("loanExisting", loanExisting);
        model.addAttribute("user", user);
        model.addAttribute("credit", credit);
        model.addAttribute("combinedLoans", combinedLoans);
        model.addAttribute("totalCombinedLoanAmount", totalCombinedLoanAmount);

        return "/bankClerk/index";
    }

    @ResponseBody
    @PutMapping("/approve-loan-switch")
    public ResponseEntity<String> approveLoanSwitch(@RequestBody LoanSwitchData loanSwitchData) throws UnsupportedEncodingException {

        loanServiceImpl.switchLoan(loanSwitchData.getLoanId(), loanSwitchData.getLoanExistingFinance(), loanSwitchData.getUserId(), loanSwitchData.getLoanExistingLoanBalance(), loanSwitchData.getLoanExistingOverdue(), loanSwitchData.getLoanExistingRepaymentAccount(), loanSwitchData.getLoanExistingId()); // 대출 변경 처리
        return ResponseEntity.ok("Loan switch approved successfully");

    }



    public double calculateMonthlyRepaymentForLoan(Loan loan) {
        double monthlyRepayment = 0.0;

        double annualInterestRate = loan.getInterestRate();
        double monthlyInterestRate = annualInterestRate / 12 / 100;
        long loanAmount = loan.getLoanAmount();
        long loanBalance = loan.getLoanBalance();
        String repaymentType = loan.getRepayment();

        if ("원금균등방식".equals(repaymentType)) {
            monthlyRepayment = (loanAmount / 12) + (loanBalance * monthlyInterestRate);
        } else if ("원리금균등방식".equals(repaymentType)) {
            int months = 12; // 대출 기간을 월로 (이 값을 실제 대출 기간으로 설정해야 함)
            monthlyRepayment = (loanAmount * monthlyInterestRate) / (1 - Math.pow(1 + monthlyInterestRate, -months));
        }

        return monthlyRepayment;
    }

    public double calculateMonthlyRepayment(LoanRecords loanRecord) {
        double monthlyRepayment = 0.0;

        double annualInterestRate = loanRecord.getInterestRate();
        double monthlyInterestRate = annualInterestRate / 12 / 100;
        long loanAmount = loanRecord.getLoanAmount();
        long loanBalance = loanRecord.getLoanBalance();
        String repaymentType = loanRecord.getRepayment();

        if ("원금균등방식".equals(repaymentType)) {
            monthlyRepayment = (loanAmount / 12) + (loanBalance * monthlyInterestRate);
        } else if ("원리금균등방식".equals(repaymentType)) {
            int months = 12; // 대출 기간을 월로 (이 값을 실제 대출 기간으로 설정해야 함)
            monthlyRepayment = (loanAmount * monthlyInterestRate) / (1 - Math.pow(1 + monthlyInterestRate, -months));
        }

        return monthlyRepayment;
    }
}
