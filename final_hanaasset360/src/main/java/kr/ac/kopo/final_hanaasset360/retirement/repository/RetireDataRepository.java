package kr.ac.kopo.final_hanaasset360.retirement.repository;

import kr.ac.kopo.final_hanaasset360.retirement.vo.RetireData;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RetireDataRepository extends JpaRepository<RetireData, Long>{

    Optional<RetireData> findByUserId(String userId);
}
