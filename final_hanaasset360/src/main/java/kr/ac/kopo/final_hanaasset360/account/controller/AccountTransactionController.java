package kr.ac.kopo.final_hanaasset360.account.controller;

import kr.ac.kopo.final_hanaasset360.message.OtherTransactionResponse;
import kr.ac.kopo.final_hanaasset360.account.service.AccountTransactionService;
import kr.ac.kopo.final_hanaasset360.account.vo.AccountTransactionVO;
import kr.ac.kopo.final_hanaasset360.retirement.vo.SavingTransactionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

// src/main/java/com/yourpackage/controller/AccountTransactionController.java
@RestController
public class AccountTransactionController {
    @Autowired
    private AccountTransactionService accountTransactionService;

    @PostMapping ("/account/transaction")
    public ResponseEntity<List<AccountTransactionVO>> getTransactionsByAccountId(@RequestBody Map<String, String> request) {
        String accountId = request.get("accountId");
        List<AccountTransactionVO> transactions = accountTransactionService.getTransactionsByAccountId(accountId);
        return ResponseEntity.ok(transactions);
    }

    @PostMapping("/saving-account/transaction")
    public ResponseEntity<List<SavingTransactionVO>> getSavingTransactionsByAccountId(@RequestBody Map<String, String> request) {
        String accountId = request.get("accountId");
        List<SavingTransactionVO> transactions = accountTransactionService.getSavingTransactionsByAccountId(accountId);
        return ResponseEntity.ok(transactions);
    }

    @PostMapping ("/other-account/transaction")
    public ResponseEntity<List<OtherTransactionResponse>> getOtherTransactionsByAccountId(@RequestBody Map<String, String> request) {
        String accountId = request.get("accountId");
        String financialCode = request.get("financialCode");
        System.out.println(financialCode + "은행");
        List<OtherTransactionResponse> transactions = accountTransactionService.getOtherTransactionsByAccountId(accountId, financialCode);
        return ResponseEntity.ok(transactions);
    }
}

