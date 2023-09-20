package kr.ac.kopo.final_hanaasset360.message;

public class LoanBalanceResponse {
    private Long personalId;
    private Long loanBalance;

    // 기본 생성자, 게터, 세터, toString() 등...

    public Long getLoanBalance() {
        return loanBalance;
    }

    public void setLoanBalance(Long loanBalance) {
        this.loanBalance = loanBalance;
    }

}
