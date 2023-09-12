package kr.ac.kopo.final_hanaasset360.vo;

public class LoanExisting {

    private Long loanRecordId;  // Assuming a large number capacity with decimal places
    private String userId;
    private Long loanAmount;
    private Double interestRate;
    private String loanStartDate;
    private String loanEndDate;
    private char overdueStatus;  // CHAR data type in Oracle is often mapped to char or String in Java.
    private String repaymentAccount;
    private String finance;
    private Double overdue;
    private String loanRepayment;
    private Long loanBalance;
    private String loanProductId;

    public Long getLoanRecordId() {
        return loanRecordId;
    }

    public void setLoanRecordId(Long loanRecordId) {
        this.loanRecordId = loanRecordId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Long getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(Long loanAmount) {
        this.loanAmount = loanAmount;
    }

    public Double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(Double interestRate) {
        this.interestRate = interestRate;
    }

    public String getLoanStartDate() {
        return loanStartDate;
    }

    public void setLoanStartDate(String loanStartDate) {
        this.loanStartDate = loanStartDate;
    }

    public String getLoanEndDate() {
        return loanEndDate;
    }

    public void setLoanEndDate(String loanEndDate) {
        this.loanEndDate = loanEndDate;
    }

    public char getOverdueStatus() {
        return overdueStatus;
    }

    public void setOverdueStatus(char overdueStatus) {
        this.overdueStatus = overdueStatus;
    }

    public String getRepaymentAccount() {
        return repaymentAccount;
    }

    public void setRepaymentAccount(String repaymentAccount) {
        this.repaymentAccount = repaymentAccount;
    }

    public String getFinance() {
        return finance;
    }

    public void setFinance(String finance) {
        this.finance = finance;
    }

    public Double getOverdue() {
        return overdue;
    }

    public void setOverdue(Double overdue) {
        this.overdue = overdue;
    }

    public String getLoanRepayment() {
        return loanRepayment;
    }

    public void setLoanRepayment(String loanRepayment) {
        this.loanRepayment = loanRepayment;
    }

    public Long getLoanBalance() {
        return loanBalance;
    }

    public void setLoanBalance(Long loanBalance) {
        this.loanBalance = loanBalance;
    }

    public String getLoanProductId() {
        return loanProductId;
    }

    public void setLoanProductId(String loanProductId) {
        this.loanProductId = loanProductId;
    }

    @Override
    public String toString() {
        return "LoanExisting{" +
                "loanRecordId=" + loanRecordId +
                ", userId='" + userId + '\'' +
                ", loanAmount=" + loanAmount +
                ", interestRate=" + interestRate +
                ", loanStartDate='" + loanStartDate + '\'' +
                ", loanEndDate='" + loanEndDate + '\'' +
                ", overdueStatus=" + overdueStatus +
                ", repaymentAccount='" + repaymentAccount + '\'' +
                ", finance='" + finance + '\'' +
                ", overdue=" + overdue +
                ", loanRepayment='" + loanRepayment + '\'' +
                ", loanBalance=" + loanBalance +
                ", loanProductId='" + loanProductId + '\'' +
                '}';
    }
}