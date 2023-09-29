package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.message.HomtaxCreditInfo;
import kr.ac.kopo.final_hanaasset360.vo.RetireData;
import kr.ac.kopo.final_hanaasset360.vo.RetirementSimulationResult;

import java.util.List;
import java.util.Optional;

public interface RetirementService {
    List<HomtaxCreditInfo> getCreditInfoByLoggedInUser(Long personalId);
    double calculateRequiredRetirementFund(double currentAge, double expectedRetirementAge, double expectedLifeSpan,
                                           double annualIncome, double expectedMonthlyExpenseAfterRetirement,
                                           double pensionMonthlyAmount, double currentAssets, double currentLiabilities);
    List<HomtaxCreditInfo>requestHometaxInfo(String id, String password);

    RetireData save(RetireData retireData);
    Optional<RetireData> findByUserId(String userId);

    RetirementSimulationResult simulateAndSave(RetireData retireData);
}
