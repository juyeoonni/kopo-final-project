package kr.ac.kopo.final_hanaasset360.dao;

import kr.ac.kopo.final_hanaasset360.message.LoanStepRequest;
import kr.ac.kopo.final_hanaasset360.vo.Loan;
import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;

import java.util.List;

public interface LoanDAO {
    List<LoanProductVO> getAllLoanProducts(double interest, double balance, int creditGrade);

    List<LoanProductVO> fetchLoanProducts();

    void saveLoanRequest(LoanStepRequest loanRequest);

    public List<Loan> getAllLoans(String personalId);
}
