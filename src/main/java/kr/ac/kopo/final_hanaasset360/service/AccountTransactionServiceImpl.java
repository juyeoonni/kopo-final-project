package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.repository.AccountTransactionRepository;
import kr.ac.kopo.final_hanaasset360.repository.SavingTransactionRepository;
import kr.ac.kopo.final_hanaasset360.vo.AccountTransactionVO;
import kr.ac.kopo.final_hanaasset360.vo.SavingTransactionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccountTransactionServiceImpl implements AccountTransactionService{

    @Autowired
    private AccountTransactionRepository accountTransactionRepository;

    @Autowired
    private SavingTransactionRepository savingTransactionRepository;
    @Override
    public List<AccountTransactionVO> getTransactionsByAccountId(String accountId) {
        return accountTransactionRepository.findByAccountid(accountId);
    }


    @Override
    public List<SavingTransactionVO> getSavingTransactionsByAccountId(String accountId) {
        return savingTransactionRepository.findByAccountId(accountId);
    }
}
