package kr.ac.kopo.final_hanaasset360.controller;


import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.message.HomtaxCreditInfo;
import kr.ac.kopo.final_hanaasset360.repository.AccountRepository;
import kr.ac.kopo.final_hanaasset360.repository.LoanRecordsRepository;
import kr.ac.kopo.final_hanaasset360.service.*;
import kr.ac.kopo.final_hanaasset360.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
public class RetirementController {
    @Autowired
    UserService userService;

    @Autowired
    RetirementService retirementService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private LoanService loanService;

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private LoanRecordsRepository loanRecordsRepository;

    @GetMapping("/retirement/index")
    public String retirement(HttpSession session, Model model) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        String userName = loggedInUser.getName();
        String userBirth = loggedInUser.getBirth();
        int age = userService.calculateAge(userBirth);



        model.addAttribute("age", age);
        model.addAttribute("userName", userName);
        model.addAttribute("userBirth", userBirth);

        return "/retirement/index";
    }


    @PostMapping("/retirement/hometax")
    public ResponseEntity<?> hometaxLogin(@RequestBody Map<String, String> formData) {
        String id = formData.get("username");
        String password = formData.get("password");


        List<HomtaxCreditInfo> creditInfoList = retirementService.requestHometaxInfo(id, password);
        // 아이디와 비밀번호를 이용하여 로그인 처리 및 외부 API에 요청을 보낼 로직을 작성합니다.

        // 예: 외부 API로의 요청이 성공적일 경우
        return ResponseEntity.ok(creditInfoList);

    }


    @GetMapping("/hometax-info")
    public ResponseEntity<?> hometaxInfo(HttpSession session) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        Long personalId = loggedInUser.getPersonalId();
        List<HomtaxCreditInfo> creditInfoList = retirementService.getCreditInfoByLoggedInUser(personalId);
        // 아이디와 비밀번호를 이용하여 로그인 처리 및 외부 API에 요청을 보낼 로직을 작성합니다.

        // 예: 외부 API로의 요청이 성공적일 경우
        return ResponseEntity.ok(creditInfoList);

    }

    @GetMapping("/accounts-info")
    public ResponseEntity<List<Accounts>> getOtherAccounts(HttpSession session ) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        Long personalId = loggedInUser.getPersonalId();
        List<Accounts> accountsList = accountService.getOtherAccountsByPersonalId(personalId);
        return ResponseEntity.ok(accountsList);
    }

    @GetMapping("/hana-accounts-info")
    public ResponseEntity<List<Accounts>> getHanaAccounts(HttpSession session ) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        String userId = loggedInUser.getUserId();
        List<Accounts> accounts = accountRepository.findByUserId(userId);
        return ResponseEntity.ok(accounts);
    }

    @GetMapping("/other-loans-info")
    public ResponseEntity<List<LoanRecords>> getOtherLoans(HttpSession session ) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        Long personalId = loggedInUser.getPersonalId();
        List<LoanRecords> loanList = loanService.getOtherLoansByPersonalId(personalId);
        return ResponseEntity.ok(loanList);
    }

    @GetMapping("/hana-loans-info")
    public ResponseEntity<List<LoanRecords>> getHanaLoans(HttpSession session ) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        String userId = loggedInUser.getUserId();
        List<LoanRecords> loanRecords = loanRecordsRepository.findByUserId(userId);
        return ResponseEntity.ok(loanRecords);
    }

    @PostMapping("/save-retirement-info")
    public ResponseEntity<?> saveUserData(@RequestBody RetireData retireData) {
        try {

            System.out.println(retireData);

            // 여기서 userData는 데이터베이스에 저장하는 로직을 포함합니다.
//            retirementService.save(retireData); // 예시
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error saving data");
        }
    }

}
