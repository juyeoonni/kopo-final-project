package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.vo.SavingApplicationVO;

import java.util.List;

public interface SavingProductService {
    void submitApplication(SavingApplicationVO vo);

    List<SavingApplicationVO> findByUserId(String userId);
}
