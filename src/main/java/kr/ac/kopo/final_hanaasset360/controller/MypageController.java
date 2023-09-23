package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.repository.AccountRepository;
import kr.ac.kopo.final_hanaasset360.repository.LoanApplyRepository;
import kr.ac.kopo.final_hanaasset360.repository.LoanRecordsRepository;
import kr.ac.kopo.final_hanaasset360.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class MypageController {

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private LoanRecordsRepository loanRecordsRepository;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private LoanApplyRepository loanApplyRepository;

    @GetMapping("/mypage/index")
    public String index(Model model, HttpSession session) {

        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        String userId = loggedInUser.getUserId();

        List<Accounts> accounts = accountRepository.findByUserId(userId);


        // 잔액의 총합을 계산
        long totalBalance = 0;
        for(Accounts account : accounts) {
            totalBalance += account.getAccountBalance();  // getBalance()는 각 Account 객체의 잔액을 반환하는 메서드라고 가정
        }

        model.addAttribute("UserName", loggedInUser.getName());
        model.addAttribute("accounts", accounts);
        model.addAttribute("totalBalance", totalBalance);

        return "/mypage/index";
    }

    @GetMapping("/mypage/subIndex")
    public String subIndex(Model model, HttpSession session) {

        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        String userId = loggedInUser.getUserId();

        List<LoanRecords> loanRecords = loanRecordsRepository.findByUserId(userId);

        long totalBalance = 0;
        for(LoanRecords record : loanRecords) {
            totalBalance += record.getLoanBalance();  // getBalance()는 각 Account 객체의 잔액을 반환하는 메서드라고 가정
        }


        model.addAttribute("loanRecords", loanRecords);
        model.addAttribute("UserName", loggedInUser.getName());
        model.addAttribute("totalBalance", totalBalance);

        return "/mypage/subIndex";
    }

    @GetMapping("/mypage/otherAccount")
    public String otherAccount(Model model, HttpSession session) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        Long personalId = loggedInUser.getPersonalId();

        String apiUrl = "http://16.171.189.30:8080/gwanjung/other-accounts";
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(apiUrl)
                .queryParam("personalId", personalId);

        List<Accounts> accounts = Arrays.asList(restTemplate.getForObject(builder.toUriString(), Accounts[].class));
        System.out.println(accounts);

        long totalBalance = 0;
        for(Accounts account : accounts) {
            totalBalance += account.getAccountBalance();  // getBalance()는 각 Account 객체의 잔액을 반환하는 메서드라고 가정
        }



        model.addAttribute("otherAccounts", accounts);
        model.addAttribute("UserName", loggedInUser.getName());
        model.addAttribute("totalBalance", totalBalance);

        return "/mypage/otherAccount";

    }


    @GetMapping("/mypage/otherLoan")
    public String otherLoan(Model model, HttpSession session) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        Long personalId = loggedInUser.getPersonalId();
        List<String> banks = Arrays.asList("우리은행", "신한은행", "국민은행");

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl("http://16.171.189.30:8080/gwanjung/loan-response")
                .queryParam("personalIdNumber", personalId);

        for (String bank : banks) {
            uriBuilder.queryParam("banks", bank);
        }

        URI uri = uriBuilder.build().encode().toUri();

        Loan[] loanArray = restTemplate.getForObject(uri, Loan[].class);
        List<Loan> loans = new ArrayList<>(Arrays.asList(loanArray));

        long totalLoanAmount = 0;
        for (Loan loan : loans) {
            totalLoanAmount += loan.getLoanBalance();  // getLoanAmount()는 각 LoanDTO 객체의 대출 금액을 반환한다고 가정
        }

        model.addAttribute("otherLoans", loans);  // 대출 정보
        model.addAttribute("UserName", loggedInUser.getName());  // 사용자 이름
        model.addAttribute("totalLoanAmount", totalLoanAmount);  // 대출 금액 총합

        return "/mypage/otherLoan";

    }

    @GetMapping("/mypage/loanManagement")
    public String loanManagement(HttpSession session, Model model) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        String userId = loggedInUser.getUserId();
        Long personalId = loggedInUser.getPersonalId();

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
        List<LoanRecords> loanRecords = loanRecordsRepository.findByUserId(userId);

        // 두 정보를 하나의 리스트로 합치기
        List<Object> combinedLoans = new ArrayList<>();
        combinedLoans.addAll(loans);
        combinedLoans.addAll(loanRecords);

        long totalLoanAmount = 0;
        for (Loan loan : loans) {
            totalLoanAmount += loan.getLoanBalance();
        }

        long totalBalance = 0;
        for (LoanRecords record : loanRecords) {
            totalBalance += record.getLoanBalance();
        }

        long totalCombinedLoanAmount = totalLoanAmount + totalBalance;

        List<LoanApplyDetail> loanSwitchList = loanApplyRepository.findByExistingFinance("하나은행");

        List<LoanApplyDetail> matchingLoanSwitches = new ArrayList<>();

        for (LoanApplyDetail loanSwitch : loanSwitchList) {
            Long loanRecordId = loanSwitch.getLoanRecordId();

            // loanRecordId를 이용해 loan_record 테이블에서 데이터를 조회
            LoanRecords loanRecord = loanRecordsRepository.findById(loanRecordId).orElse(null);

            if (loanRecord != null && userId.equals(loanRecord.getUserId())) {
                // 조건에 맞는 loan_switch 정보를 가져옴
                matchingLoanSwitches.add(loanSwitch);
            }
        }


        model.addAttribute("combinedLoans", combinedLoans);
        model.addAttribute("UserName", loggedInUser.getName());
        model.addAttribute("totalCombinedLoanAmount", totalCombinedLoanAmount);
        model.addAttribute("matchingLoanSwitches", matchingLoanSwitches);


        return "/mypage/loanManagement";
    }

    @GetMapping("/mypage/loanEvaluation")
    public String loanEvaluation() {
        return "/mypage/loanEvaluation";
    }

    @GetMapping("/mypage/dsr")
    public String dsr() {
        return "/mypage/dsr";
    }
}
