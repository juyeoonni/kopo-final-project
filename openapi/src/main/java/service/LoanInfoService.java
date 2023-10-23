package service;

import java.util.List;
import message.WooriLoanResponse;
import vo.LoanDTO;
import vo.LoanExisting;
import vo.OtherAccountDTO;

public interface LoanInfoService {
    
    // 대출 가져오기
    public List<LoanDTO> findLoanData(String memberId, List<String> banks);
    
    
    List<LoanDTO> findbyLoanData(String personalIdNumber, List<String> banks);


    public void deleteByRecordIdAndFinance(Long loanRecordId, String finance);


    public LoanExisting fetchLoanExistingFromDatabase(String loanRecordId, String bank);


    public Long getLoanBalanceByPersonalId(String personalIdStr);


    public void updateOverdueByFeeAndAccount(int fee, String repaymentAccount, String finance);


    public List<OtherAccountDTO> findByAccounts(String personalId);


    public WooriLoanResponse getLoanDetails(Long personalId);


    public void updateTransactionByFeeAndAccount(int fee, String repaymentAccount, String finance);
}
