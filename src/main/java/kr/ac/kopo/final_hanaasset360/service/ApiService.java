package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.vo.Loan;

import java.util.List;

public interface ApiService {
    String fetchDataFromAPI();

    String tranferInfoFromAPI();

    String loanDataFormAPI(String personalId, List<String> banks);

    List<Loan> getLoanDataFromAPI(String personalId, List<String> banks);

    String documentDataFormAPI(String personalId);

    List<Loan> getAllInternalLoans(String personalId);


}
