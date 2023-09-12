package kr.ac.kopo.final_hanaasset360.vo;

public class LoanSwitchData {
    private Long loanExistingId;
    private Long loanId;
    private String loanExistingFinance;
    private String userId;

    public Long getLoanExistingId() {
        return loanExistingId;
    }

    public void setLoanExistingId(Long loanExistingId) {
        this.loanExistingId = loanExistingId;
    }

    public Long getLoanId() {
        return loanId;
    }

    public void setLoanId(Long loanId) {
        this.loanId = loanId;
    }

    public String getLoanExistingFinance() {
        return loanExistingFinance;
    }

    public void setLoanExistingFinance(String loanExistingFinance) {
        this.loanExistingFinance = loanExistingFinance;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
