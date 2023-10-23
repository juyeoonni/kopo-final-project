package kr.ac.kopo.final_hanaasset360.api.service;

import kr.ac.kopo.final_hanaasset360.loan.vo.Loan;

import java.util.List;

public interface ApiService {

    List<Loan> getLoanDataFromAPI(String personalId, List<String> banks);

    String documentDataFormAPI(String personalId);

    List<Loan> getAllInternalLoans(String personalId);


}
