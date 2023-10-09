package kr.ac.kopo.final_hanaasset360.account.service;

import kr.ac.kopo.final_hanaasset360.account.vo.Accounts;

import java.util.List;

public interface AccountService {
    List<Accounts> getOtherAccountsByPersonalId(Long personalId);
    List<Accounts> getAccountsByUserId(String userId);
}
