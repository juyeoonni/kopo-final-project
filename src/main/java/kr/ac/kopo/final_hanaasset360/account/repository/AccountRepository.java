package kr.ac.kopo.final_hanaasset360.account.repository;

import kr.ac.kopo.final_hanaasset360.account.vo.Accounts;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface AccountRepository extends JpaRepository<Accounts, String> {
    List <Accounts> findByUserId(String userId);

    @Modifying
    @Transactional
    @Query("UPDATE Accounts a SET a.accountBalance = a.accountBalance - :amount WHERE a.accountId = :accountId")
    int updateBalance(@Param("accountId") String accountId, @Param("amount") int amount);
}
