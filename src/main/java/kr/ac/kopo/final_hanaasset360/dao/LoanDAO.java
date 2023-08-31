package kr.ac.kopo.final_hanaasset360.dao;

import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;

import java.util.List;

public interface LoanDAO {
    List<LoanProductVO> getAllLoanProducts(double interest, double balance, int creditGrade);
}
