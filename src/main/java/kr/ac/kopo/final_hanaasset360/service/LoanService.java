package kr.ac.kopo.final_hanaasset360.service;

import java.util.List;
import kr.ac.kopo.final_hanaasset360.message.LoanStepRequest;
import kr.ac.kopo.final_hanaasset360.vo.LoanApply;
import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;
public interface LoanService {

    List<LoanProductVO> findMatchingLoanProducts(double interest, double balance, int creditScore);

    List<LoanProductVO> getLoanProducts(String sort);

    void switchLoan(Long loanSwitchDataId , String loanExistingFinacne, String userId);

    void insertData(LoanStepRequest loanRequest);
}
