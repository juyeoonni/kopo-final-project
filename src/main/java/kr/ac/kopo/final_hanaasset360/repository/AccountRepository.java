package kr.ac.kopo.final_hanaasset360.repository;

import kr.ac.kopo.final_hanaasset360.vo.Accounts;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AccountRepository extends JpaRepository<Accounts, String> {
    List <Accounts> findByUserId(String userId);
}
