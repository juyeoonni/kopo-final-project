package kr.ac.kopo.final_hanaasset360.message;

import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;

import java.util.List;

public class LoanResponse {

    private List<LoanProductVO> loanProducts;

    public LoanResponse() {
        // Default Constructor
    }

    public LoanResponse(List<LoanProductVO> loanProducts) {
        this.loanProducts = loanProducts;
    }

    public List<LoanProductVO> getLoanProducts() {
        return loanProducts;
    }

    public void setLoanProducts(List<LoanProductVO> loanProducts) {
        this.loanProducts = loanProducts;
    }

    @Override
    public String toString() {
        return "LoanResponse{" +
                "loanProducts=" + loanProducts +
                '}';
    }
}