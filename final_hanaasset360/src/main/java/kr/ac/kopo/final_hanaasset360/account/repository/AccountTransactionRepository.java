package kr.ac.kopo.final_hanaasset360.account.repository;

import kr.ac.kopo.final_hanaasset360.account.vo.AccountTransactionVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AccountTransactionRepository extends JpaRepository<AccountTransactionVO, Long> {
    List<AccountTransactionVO> findByAccountid(String accountId);

}
