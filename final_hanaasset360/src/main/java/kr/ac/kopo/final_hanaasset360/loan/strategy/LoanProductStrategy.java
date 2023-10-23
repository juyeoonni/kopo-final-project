package kr.ac.kopo.final_hanaasset360.loan.strategy;

import kr.ac.kopo.final_hanaasset360.loan.vo.LoanProductVO;

import java.util.List;

public interface LoanProductStrategy {
    List<LoanProductVO> execute();
}