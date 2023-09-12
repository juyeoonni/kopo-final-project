package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.vo.*;

import java.util.List;

public interface LoanApplyService {
    List<LoanApply> getAllLoans();

    LoanApplyDetail findLoanById(Long id);

    LoanExisting findLoanExistingById(Long loanId);

    ApplyUserVO findUserById(String userId);

    UserCreditState findCreditById(String userId);
}