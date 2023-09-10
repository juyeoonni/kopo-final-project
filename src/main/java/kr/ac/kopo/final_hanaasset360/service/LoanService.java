package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.dao.LoanDAO;
import kr.ac.kopo.final_hanaasset360.message.LoanRequest;
import kr.ac.kopo.final_hanaasset360.message.LoanStepRequest;
import kr.ac.kopo.final_hanaasset360.vo.Loan;
import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service
public class LoanService {

    @Autowired
    private LoanDAO loanDAO;

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
