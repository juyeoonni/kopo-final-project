package kr.ac.kopo.final_hanaasset360.retirement.controller;


import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.account.service.AccountService;
import kr.ac.kopo.final_hanaasset360.account.vo.Accounts;
import kr.ac.kopo.final_hanaasset360.loan.service.LoanService;
import kr.ac.kopo.final_hanaasset360.loan.vo.LoanRecords;
import kr.ac.kopo.final_hanaasset360.message.HomtaxCreditInfo;
import kr.ac.kopo.final_hanaasset360.account.repository.AccountRepository;
import kr.ac.kopo.final_hanaasset360.loan.repository.LoanRecordsRepository;
import kr.ac.kopo.final_hanaasset360.retirement.service.RetirementService;
import kr.ac.kopo.final_hanaasset360.retirement.vo.RetireData;
import kr.ac.kopo.final_hanaasset360.retirement.vo.RetirementSimulationResult;
import kr.ac.kopo.final_hanaasset360.user.service.UserService;
import kr.ac.kopo.final_hanaasset360.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.*;

@Controller
public class RetirementController {
    @Autowired
    UserService userService;

    @Autowired
    RetirementService retirementService;


    @Autowired
    private AccountService accountService;

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

    @GetMapping("/retirement/result")
    public String retirementResult(HttpSession session, Model model) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        String userId = loggedInUser.getUserId();
        String userName = loggedInUser.getName();

        // retire 데이터 가져오기
        RetireData retireData = retirementService.getRetireDataByUserId(userId);

        // retire 데이터를 바탕으로 retirement simulation 결과 가져오기
        List<RetirementSimulationResult> simulationResults = retirementService.getSimulationResultsByRetireId(retireData.getId());

        // 결과 데이터를 Model에 담아 View에 전달
        model.addAttribute("userName", userName);
        model.addAttribute("retireData", retireData);
        model.addAttribute("simulationResults", simulationResults);
        return "/retirement/result";
    }



    @PostMapping("/save-retirement-info")
    public ResponseEntity<?> saveUserData(@RequestBody RetireData retireData, HttpSession session) {


        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        try {
            // Check if user already has existing retirement data
            Optional<RetireData> existingData = retirementService.findByUserId(loggedInUser.getUserId());

            if (existingData.isPresent()) {
                // If there is existing data, update it
                RetireData currentData = existingData.get();
                currentData.updateWith(retireData);
                retirementService.save(currentData);

                // Simulate and save the result based on updated data
                retirementService.simulateAndSave(currentData);
            } else {
                // If there's no existing data, set user ID and save new data
                retireData.setUserId(loggedInUser.getUserId());
                retirementService.save(retireData);

                // Simulate and save the result based on new data
                retirementService.simulateAndSave(retireData);
            }

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();  // For debugging
            return ResponseEntity.badRequest().body("Error saving data");
        }
    }

}
