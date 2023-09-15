package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.vo.Accounts;

import java.util.List;

public interface AccountService {

    List<Accounts> getAccountsByUserId(String userId);
}
