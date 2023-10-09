package kr.ac.kopo.final_hanaasset360.loan.repository;

import kr.ac.kopo.final_hanaasset360.loan.vo.LoanApplyDetail;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LoanApplyRepository extends JpaRepository<LoanApplyDetail, Long> {
    List<LoanApplyDetail> findByExistingFinance(String existingFinance);
}
