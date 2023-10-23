package kr.ac.kopo.final_hanaasset360.loan.dao;

import kr.ac.kopo.final_hanaasset360.message.LoanStepRequest;
import kr.ac.kopo.final_hanaasset360.loan.vo.Loan;
import kr.ac.kopo.final_hanaasset360.loan.vo.LoanProductVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LoanDAO {
    List<LoanProductVO> getAllLoanProducts(@Param("interest") double interest, @Param("balance") double balance, @Param("creditGrade") int creditGrade);
    List<LoanProductVO> fetchLoanProducts();
    void saveLoanRequest(@Param("loanRequest") LoanStepRequest loanRequest);
    List<Loan> getAllLoans(@Param("personalId") String personalId);
}