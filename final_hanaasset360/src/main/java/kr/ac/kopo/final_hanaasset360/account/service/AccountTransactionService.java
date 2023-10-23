package kr.ac.kopo.final_hanaasset360.account.service;

import kr.ac.kopo.final_hanaasset360.message.OtherTransactionResponse;
import kr.ac.kopo.final_hanaasset360.account.vo.AccountTransactionVO;
import kr.ac.kopo.final_hanaasset360.retirement.vo.SavingTransactionVO;

import java.util.List;

public interface AccountTransactionService {
    List<AccountTransactionVO> getTransactionsByAccountId(String accountId);

    List<SavingTransactionVO> getSavingTransactionsByAccountId(String accountId);


    List<OtherTransactionResponse> getOtherTransactionsByAccountId(String accountId, String financialCode);
}
