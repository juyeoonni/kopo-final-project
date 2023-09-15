package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.repository.AccountRepository;
import kr.ac.kopo.final_hanaasset360.vo.Accounts;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccountServiceImpl implements  AccountService{
    private final AccountRepository accountRepository;

    public AccountServiceImpl(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    public List<Accounts> getAccountsByUserId(String userId) {
        return accountRepository.findByUserId(userId);
    }
}
