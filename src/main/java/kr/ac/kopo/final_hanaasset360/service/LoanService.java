package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.dao.LoanDAO;
import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    private boolean isCreditGradeMatching(int creditGrade, LoanProductVO product) {
        // 신용등급에 따른 대출 가능 여부를 확인하는 로직
        // 예: if (product.getCreditGrade6() >= creditGrade) { return true; }
        return true; // 로직에 따라 true 또는 false를 반환
    }
}
