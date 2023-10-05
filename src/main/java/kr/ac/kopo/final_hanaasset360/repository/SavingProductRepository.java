package kr.ac.kopo.final_hanaasset360.repository;

import kr.ac.kopo.final_hanaasset360.vo.SavingApplicationVO;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SavingProductRepository extends JpaRepository<SavingApplicationVO, Long> {
    List<SavingApplicationVO> findByUserId(String userId);
    // 기본 CRUD 메서드가 이미 제공됩니다.
}
