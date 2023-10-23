package kr.ac.kopo.final_hanaasset360.loan.vo;

public class LoanSwitchData {
    private Long loanExistingId;
    private Long loanId;
    private String loanExistingFinance;
    private String userId;
    private double loanExistingOverdue;
    private Long loanExistingLoanBalance;
    private String loanExistingRepaymentAccount;


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


    public double getLoanExistingOverdue() {
        return loanExistingOverdue;
    }

    public void setLoanExistingOverdue(double loanExistingOverdue) {
        this.loanExistingOverdue = loanExistingOverdue;
    }

    public Long getLoanExistingLoanBalance() {
        return loanExistingLoanBalance;
    }

    public void setLoanExistingLoanBalance(Long loanExistingLoanBalance) {
        this.loanExistingLoanBalance = loanExistingLoanBalance;
    }

    public String getLoanExistingRepaymentAccount() {
        return loanExistingRepaymentAccount;
    }

    public void setLoanExistingRepaymentAccount(String loanExistingRepaymentAccount) {
        this.loanExistingRepaymentAccount = loanExistingRepaymentAccount;
    }
}
