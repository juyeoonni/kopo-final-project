package service;

import java.util.List;
import message.WooriLoanResponse;
import repository.LoanInfoRepository;
import repository.LoanInfoRepositoryImpl;
import vo.LoanDTO;
import vo.LoanExisting;
import vo.OtherAccountDTO;

public class LoanInfoServiceImpl implements LoanInfoService{

    @Override
    public List<LoanDTO> findLoanData(String memberId, List<String> banks) {
        LoanInfoRepository repository = LoanInfoRepositoryImpl.getInstance();
        return repository.findLoanDataByMemberId(memberId, banks);
        
        
    }
    
    @Override
    public List<LoanDTO> findbyLoanData(String personalIdNumber, List<String> banks) {
        LoanInfoRepository repository = LoanInfoRepositoryImpl.getInstance();
        return repository.findMemberIdAndLoanHistoryByPersonalIdNumber(personalIdNumber, banks);
    }

    @Override
    public void deleteByRecordIdAndFinance(Long loanRecordId, String finance) {
        LoanInfoRepository repository = LoanInfoRepositoryImpl.getInstance();
        repository.deleteByRecordIdAndFinance(loanRecordId, finance);
        
    }

    @Override
    public LoanExisting fetchLoanExistingFromDatabase(String loanRecordId, String bank) {
        // TODO Auto-generated method stub
        LoanInfoRepository repository = LoanInfoRepositoryImpl.getInstance();
        return repository.fetchLoanExisting(loanRecordId, bank);
    }

    @Override
    public Long getLoanBalanceByPersonalId(String personalIdStr) {
        // TODO Auto-generated method stub
        LoanInfoRepository repository = LoanInfoRepositoryImpl.getInstance();
        return repository.getLoanBalanceByPersonalId(personalIdStr);
    }

    @Override
    public void updateOverdueByFeeAndAccount(int fee, String repaymentAccount, String finance) {
        LoanInfoRepository repository = LoanInfoRepositoryImpl.getInstance();
        repository.updateOverdueByFeeAndAccount(fee, repaymentAccount, finance);
        
    }

    @Override
    public List<OtherAccountDTO> findByAccounts(String personalId) {
        // TODO Auto-generated method stub
        LoanInfoRepository repository = LoanInfoRepositoryImpl.getInstance();
        return repository.findByAccounts(personalId);
    }

    @Override
    public WooriLoanResponse getLoanDetails(Long personalId) {
        // TODO Auto-generated method stub
        LoanInfoRepository repository = LoanInfoRepositoryImpl.getInstance();
        String userId = repository.findUserIdByPersonalId(personalId);
        List<Long> loanRecordIds = repository.findLoanRecordIdsByUserId(userId);
        return new WooriLoanResponse(userId, loanRecordIds);
    }

    @Override
    public void updateTransactionByFeeAndAccount(int fee, String repaymentAccount, String finance) {
        LoanInfoRepository repository = LoanInfoRepositoryImpl.getInstance();
        
        repository.updateTransactionByFeeAndAccount(fee, repaymentAccount, finance);
    }

}
