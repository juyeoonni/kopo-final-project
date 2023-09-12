package kr.ac.kopo.final_hanaasset360.repository;

import kr.ac.kopo.final_hanaasset360.vo.LoanApply;
import kr.ac.kopo.final_hanaasset360.vo.LoanApplyDetail;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LoanApplyRepository extends JpaRepository<LoanApplyDetail, Long> {
}
