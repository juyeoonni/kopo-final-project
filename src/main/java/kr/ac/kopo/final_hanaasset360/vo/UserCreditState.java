package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.*;


public class UserCreditState {


    private Long id;

    private String userId;

    private int creditScore;

    private int repaymentScore;

    private int loanScore;

    private int creditRisk;

    private int creditPeriodScore;


    private int creditCardUsage;


    private int debitCardUsage;


    private int cashReceipt;


    private Long annualIncome;

    public void setId(Long id) {
        this.id = id;
    }

    public void setUserId(String userId) {
        this.userId = "sampleUser";
    }

    public void setCreditScore(int creditScore) {
        this.creditScore = creditScore;
    }

    public void setRepaymentScore(int repaymentScore) {
        this.repaymentScore = repaymentScore;
    }

    public void setLoanScore(int loanScore) {
        this.loanScore = loanScore;
    }

    public void setCreditRisk(int creditRisk) {
        this.creditRisk = creditRisk;
    }

    public void setCreditPeriodScore(int creditPeriodScore) {
        this.creditPeriodScore = creditPeriodScore;
    }

    public void setCreditCardUsage(int creditCardUsage) {
        this.creditCardUsage = creditCardUsage;
    }

    public void setDebitCardUsage(int debitCardUsage) {
        this.debitCardUsage = debitCardUsage;
    }

    public Long getId() {
        return id;
    }

    public String getUserId() {
        return userId;
    }

    public int getCreditScore() {
        return creditScore;
    }

    public int getRepaymentScore() {
        return repaymentScore;
    }

    public int getLoanScore() {
        return loanScore;
    }

    public int getCreditRisk() {
        return creditRisk;
    }

    public int getCreditPeriodScore() {
        return creditPeriodScore;
    }

    public int getCreditCardUsage() {
        return creditCardUsage;
    }

    public int getDebitCardUsage() {
        return debitCardUsage;
    }

    public int getCashReceipt() {
        return cashReceipt;
    }

    public void setCashReceipt(int cashReceipt) {
        this.cashReceipt = cashReceipt;
    }

    public Long getAnnualIncome() {
        return annualIncome;
    }

    public void setAnnualIncome(Long annualIncome) {
        this.annualIncome = annualIncome;
    }

    @Override
    public String toString() {
        return "UserCredit{" +
                "id=" + id +
                ", userId='" + userId + '\'' +
                ", creditScore=" + creditScore +
                ", repaymentScore=" + repaymentScore +
                ", loanScore=" + loanScore +
                ", creditRisk=" + creditRisk +
                ", creditPeriodScore=" + creditPeriodScore +
                ", creditCardUsage=" + creditCardUsage +
                ", debitCardUsage=" + debitCardUsage +
                ", cashReceipt=" + cashReceipt +
                ", annualIncome=" + annualIncome +
                '}';
    }
}