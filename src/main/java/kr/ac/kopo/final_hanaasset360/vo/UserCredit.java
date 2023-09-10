package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


@Entity
@Table(name = "USER_CREDIT")
public class UserCredit {
    public UserCredit() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_credit_sequence_generator")
    @SequenceGenerator(name = "user_credit_sequence_generator", sequenceName = "user_credit_sequence", allocationSize = 1)
    private Long id;


    @Column(name = "userid")
    private String userId = "sampleUser";

    @Column(name = "CREDIT_SCORE")
    private int creditScore;

    @Column(name = "Repayment_SCORE")
    private int repaymentScore;

    @Column(name = "LOAN_SCORE")
    private int loanScore;

    @Column(name = "CREDIT_RISK")
    private int creditRisk;

    @Column(name = "CREDIT_PERIOD_SCORE")
    private int creditPeriodScore;

    @Column(name = "CREDIT_CARD_USAGE")
    private int creditCardUsage;

    @Column(name = "DEBIT_CARD_USAGE")
    private int debitCardUsage;

    @Column(name = "CASH_RECEIPT")
    private int cashReceipt;

    @Column(name = "ANNUAL_INCOME")
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
