package vo;

public class LoanDTO {
    private long loanRecordID;
    private String loanProductID;
    private String userID;
    private long loanAmount;
    private long loanBalance;
    private Double interestRate;
    private String loanStartDate;
    private String loanEndDate;
    private char overdueStatus;
    private String repaymentAccount;
    private String finance;
    private Double overdue;
    private String repayment;
    private long repaymentDate;

    // Getter and Setter methods...

    public long getLoanRecordID() {
        return loanRecordID;
    }

    public void setLoanRecordID(long loanRecordID) {
        this.loanRecordID = loanRecordID;
    }

    public String getLoanProductID() {
        return loanProductID;
    }

    public void setLoanProductID(String loanProductID) {
        this.loanProductID = loanProductID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public long getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(long loanAmount) {
        this.loanAmount = loanAmount;
    }

    
    public long getLoanBalance() {
        return loanBalance;
    }

    public void setLoanBalance(long loanBalance) {
        this.loanBalance = loanBalance;
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

 

    public Double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(Double interestRate) {
        this.interestRate = interestRate;
    }

    public Double getOverdue() {
        return overdue;
    }

    public void setOverdue(Double overdue) {
        this.overdue = overdue;
    }

    public String getRepayment() {
        return repayment;
    }

    public void setRepayment(String repayment) {
        this.repayment = repayment;
    }

    public long getRepaymentDate() {
        return repaymentDate;
    }

    public void setRepaymentDate(long repaymentDate) {
        this.repaymentDate = repaymentDate;
    }

    
    
}
