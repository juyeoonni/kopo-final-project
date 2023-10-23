package kr.ac.kopo.final_hanaasset360.loan.service;

import kr.ac.kopo.final_hanaasset360.api.vo.UserCreditState;
import kr.ac.kopo.final_hanaasset360.loan.vo.LoanApply;
import kr.ac.kopo.final_hanaasset360.loan.vo.LoanApplyDetail;
import kr.ac.kopo.final_hanaasset360.loan.vo.LoanExisting;
import kr.ac.kopo.final_hanaasset360.user.vo.ApplyUserVO;

import java.util.List;

public interface LoanApplyService {
    List<LoanApply> getAllLoans();

    LoanApplyDetail findLoanById(Long id);

    LoanExisting findLoanExistingById(Long loanId);

    ApplyUserVO findUserById(String userId);

    UserCreditState findCreditById(String userId);
}