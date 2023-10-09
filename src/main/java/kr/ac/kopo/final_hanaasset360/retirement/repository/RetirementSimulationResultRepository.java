package kr.ac.kopo.final_hanaasset360.retirement.repository;

import kr.ac.kopo.final_hanaasset360.retirement.vo.RetireData;
import kr.ac.kopo.final_hanaasset360.retirement.vo.RetirementSimulationResult;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RetirementSimulationResultRepository extends JpaRepository<RetirementSimulationResult, Long> {
    Optional<RetirementSimulationResult> findByRetireData(RetireData retireData);
    List<RetirementSimulationResult> findByRetireDataId(Long retireId);

}
