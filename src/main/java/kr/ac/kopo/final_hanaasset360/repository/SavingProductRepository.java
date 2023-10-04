package kr.ac.kopo.final_hanaasset360.repository;

import kr.ac.kopo.final_hanaasset360.vo.SavingApplicationVO;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SavingProductRepository extends JpaRepository<SavingApplicationVO, Long> {
    // 기본 CRUD 메서드가 이미 제공됩니다.
}
