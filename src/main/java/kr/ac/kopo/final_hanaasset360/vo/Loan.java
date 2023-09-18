package kr.ac.kopo.final_hanaasset360.vo;
public class Loan {

    private int loanRecordID;
    private Long id;
    private String userID;
    private String loanProductID;
    private double interestRate;
    private String finance;
    private int loanAmount;
    private int loanBalance;

    private String loanEndDate;
    private Double overdue;
    private String loanStartDate;  // 혹은 다른 적절한 타입(Date 등)

    private String overdueStatus;  // 혹은 다른 적절한 타입

    private String repaymentAccount;  // 해당 필드의 적절한 데이터 타입으로 선언. 예제에서는 String으로 가정.

    private String repayment;  // 해당 필드의 적절한 데이터 타입으로 선언. 예제에서는 String으로 가정.

    private int repaymentDate;

    public Loan(){

    }
    public Loan(int LoanRecordID, String loanProductID, String finance, double interestRate, int loanAmount, int loanBalance, String loanEndDate, double overdue, String repayment, String loanStartDate, int repaymentDate) {
        this.loanRecordID = LoanRecordID;
        this.loanProductID = loanProductID;
        this.finance = finance;
        this.interestRate = interestRate;
        this.loanAmount = loanAmount;
        this.loanBalance = loanBalance;
        this.loanEndDate = loanEndDate;
        this.overdue = overdue;
        this.repayment = repayment;
        this.loanStartDate = loanStartDate;
        this.repaymentDate = repaymentDate;
    }



    public String getRepayment() {
        return repayment;
    }

    public void setRepayment(String repayment) {
        this.repayment = repayment;
    }
    public String getRepaymentAccount() {
        return repaymentAccount;
    }

    public void setRepaymentAccount(String repaymentAccount) {
        this.repaymentAccount = repaymentAccount;
    }

    public String getOverdueStatus() {
        return overdueStatus;
    }

    public void setOverdueStatus(String overdueStatus) {
        this.overdueStatus = overdueStatus;
    }

    public String getLoanStartDate() {
        return loanStartDate;
    }

    public void setLoanStartDate(String loanStartDate) {
        this.loanStartDate = loanStartDate;
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLoanProductID() {
        return loanProductID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public void setLoanProductID(String loanProductID) {
        this.loanProductID = loanProductID;
    }

    public double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(double interestRate) {
        this.interestRate = interestRate;
    }

    public String getFinance() {
        return finance;
    }

    public void setFinance(String finance) {
        this.finance = finance;
    }

    public int getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(int loanAmount) {
        this.loanAmount = loanAmount;
    }

    public int getLoanBalance() {
        return loanBalance;
    }

    public void setLoanBalance(int loanBalance) {
        this.loanBalance = loanBalance;
    }

    public String getLoanEndDate() {
        return loanEndDate;
    }

    public void setLoanEndDate(String loanEndDate) {
        this.loanEndDate = loanEndDate;
    }

    public Double getOverdue() {
        return overdue;
    }

    public void setOverdue(double overdue) {
        this.overdue = overdue;
    }

    public int getLoanRecordID() {
        return loanRecordID;
    }

    public void setLoanRecordID(int loanRecordID) {
        this.loanRecordID = loanRecordID;
    }

    // getters, setters, 기타 메서드 생략

    public void setOverdue(Double overdue) {
        this.overdue = overdue;
    }

    public int getRepaymentDate() {
        return repaymentDate;
    }

    public void setRepaymentDate(int repaymentDate) {
        this.repaymentDate = repaymentDate;
    }
}

