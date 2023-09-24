package kr.ac.kopo.final_hanaasset360.dao;

import kr.ac.kopo.final_hanaasset360.vo.LoanApply;
import kr.ac.kopo.final_hanaasset360.vo.LoanExisting;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LoanApplyDAO {

    LoanApply findById(Long id);

    void update(Long id);

    LoanExisting findByLoanRecordId(Long loanRecordId);

    void delete(@Param("loanExisting") LoanExisting loanExisting, @Param("loanExistingFinacne") String loanExistingFinacne);


    void insert(@Param("loanExisting") LoanExisting loanExisting);

    void overdue(String userId, Long balance,@Param("fee") int fee, @Param("repaymentAccount")String repaymentAccount, Long loanExistingId);
}
