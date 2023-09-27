package kr.ac.kopo.final_hanaasset360.controller;


import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.message.HomtaxCreditInfo;
import kr.ac.kopo.final_hanaasset360.repository.AccountRepository;
import kr.ac.kopo.final_hanaasset360.repository.LoanRecordsRepository;
import kr.ac.kopo.final_hanaasset360.service.RetirementService;
import kr.ac.kopo.final_hanaasset360.service.RetirementServiceImpl;
import kr.ac.kopo.final_hanaasset360.service.UserService;
import kr.ac.kopo.final_hanaasset360.vo.Accounts;
import kr.ac.kopo.final_hanaasset360.vo.Loan;
import kr.ac.kopo.final_hanaasset360.vo.LoanRecords;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
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
public class RetirementController {
    @Autowired
    UserService userService;

    @Autowired
    RetirementService retirementService;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private LoanRecordsRepository loanRecordsRepository;

    @GetMapping("/retirement/index")
    public String retirement(HttpSession session, Model model) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        String userName = loggedInUser.getName();
        String userBirth = loggedInUser.getBirth();
        String userId = loggedInUser.getUserId();
        Long personalId = loggedInUser.getPersonalId();
        int age = userService.calculateAge(userBirth);

        List<HomtaxCreditInfo> creditInfoList = retirementService.getCreditInfoByLoggedInUser(personalId);

        List<Accounts> accounts = accountRepository.findByUserId(userId);


        // 잔액의 총합을 계산
        long totalBalance = 0;
        for(Accounts account : accounts) {
            totalBalance += account.getAccountBalance();  // getBalance()는 각 Account 객체의 잔액을 반환하는 메서드라고 가정
        }

        String apiUrl = "http://16.171.189.30:8080/gwanjung/other-accounts";
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(apiUrl)
                .queryParam("personalId", personalId);

        List<Accounts> otherAccounts = Arrays.asList(restTemplate.getForObject(builder.toUriString(), Accounts[].class));
        System.out.println(otherAccounts);

        long otherTotalBalance = 0;
        for(Accounts account : otherAccounts) {
            otherTotalBalance += account.getAccountBalance();  // getBalance()는 각 Account 객체의 잔액을 반환하는 메서드라고 가정
        }



        List<LoanRecords> loanRecords = loanRecordsRepository.findByUserId(userId);

        long totalLoan = 0;
        for(LoanRecords record : loanRecords) {
            totalLoan += record.getLoanBalance();  // getBalance()는 각 Account 객체의 잔액을 반환하는 메서드라고 가정
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

        long otherLoan = 0;
        for (Loan loan : loans) {
            otherLoan += loan.getLoanBalance();  // getLoanAmount()는 각 LoanDTO 객체의 대출 금액을 반환한다고 가정
        }



        model.addAttribute("age", age);
        model.addAttribute("userName", userName);
        model.addAttribute("userBirth", userBirth);
        model.addAttribute("creditInfoList", creditInfoList);
        model.addAttribute("totalBalance", totalBalance);
        model.addAttribute("otherTotalBalance", otherTotalBalance);
        model.addAttribute("totalLoan", totalLoan);
        model.addAttribute("otherTotalLoan", otherLoan);


        return "/retirement/index";
    }

}
