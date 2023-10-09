package kr.ac.kopo.final_hanaasset360.loan.service;

import java.io.UnsupportedEncodingException;
import java.util.List;
import kr.ac.kopo.final_hanaasset360.message.LoanStepRequest;
import kr.ac.kopo.final_hanaasset360.loan.vo.LoanDetail;
import kr.ac.kopo.final_hanaasset360.loan.vo.LoanProductVO;
import kr.ac.kopo.final_hanaasset360.loan.vo.LoanRecords;

public interface LoanService {

    List<LoanProductVO> findMatchingLoanProducts(double interest, double balance, int creditScore);

    List<LoanProductVO> getLoanProducts(String sort);

    void switchLoan(Long loanSwitchDataId , String loanExistingFinacne, String userId, Long balance, double overdue, String repaymentAccount, Long loanExistingId) throws UnsupportedEncodingException;

    void insertData(LoanStepRequest loanRequest);

    Long sumLoansByUserId(String userId, Long personalId);

    List<LoanDetail> getRepaymentsByUserId(String userId);

    List<LoanDetail> findByUserId(String userId);

    List<LoanRecords> getOtherLoansByPersonalId(Long personalId);

}
