package kr.ac.kopo.final_hanaasset360.retirement.repository;


import kr.ac.kopo.final_hanaasset360.retirement.vo.SavingTransactionVO;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SavingTransactionRepository  extends JpaRepository<SavingTransactionVO, Long> {
    List<SavingTransactionVO> findByAccountId(String accountId);
}
