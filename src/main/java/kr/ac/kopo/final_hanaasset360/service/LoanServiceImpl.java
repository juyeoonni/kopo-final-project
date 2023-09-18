package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.dao.LoanApplyDAOImpl;
import kr.ac.kopo.final_hanaasset360.dao.LoanDAO;
import kr.ac.kopo.final_hanaasset360.message.LoanStepRequest;
import kr.ac.kopo.final_hanaasset360.vo.LoanApply;
import kr.ac.kopo.final_hanaasset360.vo.LoanExisting;
import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service
public class LoanServiceImpl implements LoanService {

    @Autowired
    private LoanDAO loanDAO;


    @Autowired
    private LoanApplyDAOImpl loanApplyDaoImpl;

    public List<LoanProductVO> findMatchingLoanProducts(double interest, double balance, int creditScore) {
        int creditGrade = convertScoreToGrade(creditScore);
        List<LoanProductVO> loanProducts = loanDAO.getAllLoanProducts(interest, balance, creditGrade);

        return loanProducts;
    }

    public List<LoanProductVO> getLoanProducts(String sort) {
        List<LoanProductVO> products = loanDAO.fetchLoanProducts();

        if ("avgIntRate".equals(sort)) {
            Collections.sort(products, Comparator.comparing(LoanProductVO::getAvgIntRate));
        } else if ("loanLimAmt".equals(sort)) {
            Collections.sort(products, Comparator.comparing(LoanProductVO::getLoanLimAmt).reversed());
        }

        return products;
    }

    @Transactional
    public void switchLoan(Long loanSwitchDataId , String loanExistingFinacne, String userId) {
        System.out.println("loanSwitchDataId: " + loanSwitchDataId);
        LoanApply loanSwitchData = loanApplyDaoImpl.findById(loanSwitchDataId);
        // 기존 대출 데이터 삭제
        System.out.println(loanExistingFinacne);
        // 기존 대출일 경우 하나은행 DB에서 삭제
        if(loanExistingFinacne.equals("하나은행")){
            LoanExisting loanExisting = loanApplyDaoImpl.findByLoanRecordId(loanSwitchData.getLoanRecordId());;
            loanApplyDaoImpl.delete(loanExisting, loanExistingFinacne);
        } else{
            // 하나은행이 아닐경우 API를 통해 삭제
            String url = "http://16.171.189.30:8080/gwanjung/loan-existing?loanRecordId=" + loanSwitchData.getLoanRecordId() + "&finance=" + loanExistingFinacne;
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.delete(url);
        }

        System.out.println("2");
        LoanApply loanApply = loanApplyDaoImpl.findById(loanSwitchDataId);
        // 새로운 대출 데이터 추가
        LoanExisting newLoanExisting = new LoanExisting();
        newLoanExisting.setLoanRecordId(loanApply.getLoanRecordId());
        newLoanExisting.setUserId(userId);
        newLoanExisting.setLoanAmount(loanApply.getNewLoanAmount());
        newLoanExisting.setInterestRate(loanApply.getNewLoanInterest());
        newLoanExisting.setLoanStartDate(loanApply.getNewLoanStartDate());
        newLoanExisting.setLoanEndDate(loanApply.getNewLoanEndDate());
        newLoanExisting.setOverdueStatus('Y');
        newLoanExisting.setRepaymentAccount(loanApply.getNewLoanAccount());
        newLoanExisting.setFinance(loanApply.getNewLoanFinance());
        newLoanExisting.setOverdue(loanApply.getNewLoanOverdue());
        newLoanExisting.setRepayment(loanApply.getNewLoanInRepayment());
        newLoanExisting.setLoanBalance(loanApply.getNewLoanAmount());
        newLoanExisting.setLoanProductId(loanApply.getNewLoanName());
        newLoanExisting.setRepaymentDate(loanApply.getNewLoanInterestDate());
        loanApplyDaoImpl.insert(newLoanExisting);

        // 심사완료로 최종 마무리
        loanApplyDaoImpl.update(loanSwitchDataId);
    }

    private int convertScoreToGrade(int score) {
        if (score >= 942 && score <= 1000) return 1;
        if (score >= 891 && score <= 941) return 2;
        if (score >= 832 && score <= 890) return 3;
        if (score >= 768 && score <= 831) return 4;
        if (score >= 698 && score <= 767) return 5;
        if (score >= 630 && score <= 697) return 6;
        if (score >= 530 && score <= 629) return 7;
        if (score >= 454 && score <= 529) return 8;
        if (score >= 335 && score <= 453) return 9;
        if (score >= 0 && score <= 334) return 10;
        return -1; // 잘못된 점수
    }

    @Transactional
    public void insertData(LoanStepRequest loanRequest) {
        loanDAO.saveLoanRequest(loanRequest);
    }
}
