package kr.ac.kopo.final_hanaasset360.loan.repository;

import kr.ac.kopo.final_hanaasset360.loan.vo.LoanDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LoanRepository extends JpaRepository<LoanDetail, Long> {
    @Query("SELECT SUM(l.loanBalance) FROM LoanDetail l WHERE l.userId = ?1")
    Long sumLoansByUserId(String userId);

    List<LoanDetail> findByUserIdOrderByRepaymentDateAsc(String userId);

    List<LoanDetail> findByUserId(String userId);
}
