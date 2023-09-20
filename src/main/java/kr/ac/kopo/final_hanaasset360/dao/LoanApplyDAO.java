package kr.ac.kopo.final_hanaasset360.dao;

import kr.ac.kopo.final_hanaasset360.vo.LoanApply;
import kr.ac.kopo.final_hanaasset360.vo.LoanExisting;

public interface LoanApplyDAO {

    LoanApply findById(Long id);

    void update(Long id);

    LoanExisting findByLoanRecordId(Long loanRecordId);

    void delete(LoanExisting loanExisting, String loanExistingFinacne);

    void insert(LoanExisting loanExisting);

    void overdue(String userId, Long balance, int fee, String repaymentAccount, Long loanExistingId);
}
