package repository;

import java.util.List;
import vo.LoanDTO;
import vo.LoanExisting;
import vo.OtherAccountDTO;


public interface LoanInfoRepository {
    public List<LoanDTO> findLoanDataByMemberId(String userId, List<String> banks);

    public List<LoanDTO> findMemberIdAndLoanHistoryByPersonalIdNumber(String personalIdNumber,
            List<String> banks);

    public void deleteByRecordIdAndFinance(Long loanRecordId, String finance);

    public LoanExisting fetchLoanExisting(String loanRecordId, String bank);

    public Long getLoanBalanceByPersonalId(String personalIdStr);

    public void updateOverdueByFeeAndAccount(int fee, String repaymentAccount, String finance);

    public List<OtherAccountDTO> findByAccounts(String personalId);

    public String findUserIdByPersonalId(Long personalId);

    public List<Long> findLoanRecordIdsByUserId(String userId);

    public void updateTransactionByFeeAndAccount(int fee, String repaymentAccount, String finance);
}
