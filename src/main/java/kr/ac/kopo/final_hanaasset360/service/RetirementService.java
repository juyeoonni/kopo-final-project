package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.message.HomtaxCreditInfo;

import java.util.List;

public interface RetirementService {
    List<HomtaxCreditInfo> getCreditInfoByLoggedInUser(Long personalId);
    double calculateRequiredRetirementFund(double currentAge, double expectedRetirementAge, double expectedLifeSpan,
                                           double annualIncome, double expectedMonthlyExpenseAfterRetirement,
                                           double pensionMonthlyAmount, double currentAssets, double currentLiabilities);
}
