package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.message.HomtaxCreditInfo;

import java.util.List;

public interface RetirementService {
    List<HomtaxCreditInfo> getCreditInfoByLoggedInUser(Long personalId);
}
