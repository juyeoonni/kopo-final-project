package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.*;

@Entity
@Table(name = "loan_records")
public class LoanRecords {
    @Id  // 이 필드는 테이블의 기본 키로 사용됩니다.
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // 기본 키 생성 전략을 지정합니다. IDENTITY는 데이터베이스가 자동으로 값을 생성하게 됩니다.
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
    private String repayment;
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

    public String getRepayment() {
        return repayment;
    }

    public void setRepayment(String repayment) {
        this.repayment = repayment;
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
}
