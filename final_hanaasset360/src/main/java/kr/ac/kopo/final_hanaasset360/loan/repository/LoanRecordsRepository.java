package kr.ac.kopo.final_hanaasset360.loan.repository;

import kr.ac.kopo.final_hanaasset360.loan.vo.LoanRecords;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LoanRecordsRepository extends JpaRepository<LoanRecords, Long> {
    List<LoanRecords> findByUserId(String userId);

}