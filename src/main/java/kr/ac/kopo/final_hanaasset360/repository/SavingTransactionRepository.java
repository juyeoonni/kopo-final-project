package kr.ac.kopo.final_hanaasset360.repository;


import kr.ac.kopo.final_hanaasset360.vo.SavingTransactionVO;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SavingTransactionRepository  extends JpaRepository<SavingTransactionVO, Long> {
    List<SavingTransactionVO> findByAccountId(String accountId);
}
