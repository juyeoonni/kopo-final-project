package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.*;

@Entity
@Table(name="LOAN_SWITCH")
public class LoanApplyDetail {
    @Id  // 이 필드는 테이블의 기본 키로 사용됩니다.
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // 기본 키 생성 전략을 지정합니다. IDENTITY는 데이터베이스가 자동으로 값을 생성하게 됩니다.
    private long id;

    @Column(name="LOANRECORDiD")
    private Long loanRecordId;
    @Column(name="NEW_LOAN_FINANCE")
    private String newLoanFinance;
    @Column(name="NEW_LOAN_NAME")
    private String newLoanName;

    @Column(name="NEW_LOAN_AMOUNT")
    private Long newLoanAmount;
    @Column(name="NEW_LOAN_INTEREST")
    private Double newLoanInterest;
    @Column(name="NEW_LOAN_OVERDUE")
    private Double newLoanOverdue;
    @Column(name="NEW_LOAN_PERIOD")
    private Long newLoanPeriod;
    @Column(name="NEW_LOAN_START_DATE")
    private String newLoanStartDate;
    @Column(name="NEW_LOAN_END_DATE")
    private String newLoanEndDate;
    @Column(name="NEW_LOAN_INTEREST_DATE")
    private String newLoanInterestDate;
    @Column(name="NEW_LOAN_IN_REPAYMENT")
    private String newLoanInRepayment;
    @Column(name="NEW_LOAN_STATUS")
    private String newLoanStatus;
    @Column(name="NEW_LOAN_ACCOUNT")
    private String newLoanAccount;
    @Column(name="APPLICATION_DATE")
    private String applicationDate;
    @Column(name="BANKERID")
    private Long bankerId;
    @Column(name="existingfinance")
    private String existingFinance;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Long getLoanRecordId() {
        return loanRecordId;
    }

    public void setLoanRecordId(Long loanRecordId) {
        this.loanRecordId = loanRecordId;
    }

    public String getNewLoanFinance() {
        return newLoanFinance;
    }

    public void setNewLoanFinance(String newLoanFinance) {
        this.newLoanFinance = newLoanFinance;
    }

    public String getNewLoanName() {
        return newLoanName;
    }

    public void setNewLoanName(String newLoanName) {
        this.newLoanName = newLoanName;
    }

    public Long getNewLoanAmount() {
        return newLoanAmount;
    }

    public void setNewLoanAmount(Long newLoanAmount) {
        this.newLoanAmount = newLoanAmount;
    }

    public Double getNewLoanInterest() {
        return newLoanInterest;
    }

    public void setNewLoanInterest(Double newLoanInterest) {
        this.newLoanInterest = newLoanInterest;
    }

    public Double getNewLoanOverdue() {
        return newLoanOverdue;
    }

    public void setNewLoanOverdue(Double newLoanOverdue) {
        this.newLoanOverdue = newLoanOverdue;
    }

    public Long getNewLoanPeriod() {
        return newLoanPeriod;
    }

    public void setNewLoanPeriod(Long newLoanPeriod) {
        this.newLoanPeriod = newLoanPeriod;
    }

    public String getNewLoanStartDate() {
        return newLoanStartDate;
    }

    public void setNewLoanStartDate(String newLoanStartDate) {
        this.newLoanStartDate = newLoanStartDate;
    }

    public String getNewLoanEndDate() {
        return newLoanEndDate;
    }

    public void setNewLoanEndDate(String newLoanEndDate) {
        this.newLoanEndDate = newLoanEndDate;
    }

    public String getNewLoanInterestDate() {
        return newLoanInterestDate;
    }

    public void setNewLoanInterestDate(String newLoanInterestDate) {
        this.newLoanInterestDate = newLoanInterestDate;
    }

    public String getNewLoanInRepayment() {
        return newLoanInRepayment;
    }

    public void setNewLoanInRepayment(String newLoanInRepayment) {
        this.newLoanInRepayment = newLoanInRepayment;
    }

    public String getNewLoanStatus() {
        return newLoanStatus;
    }

    public void setNewLoanStatus(String newLoanStatus) {
        this.newLoanStatus = newLoanStatus;
    }

    public String getNewLoanAccount() {
        return newLoanAccount;
    }

    public void setNewLoanAccount(String newLoanAccount) {
        this.newLoanAccount = newLoanAccount;
    }

    public String getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(String applicationDate) {
        this.applicationDate = applicationDate;
    }

    public Long getBankerId() {
        return bankerId;
    }

    public void setBankerId(Long bankerId) {
        this.bankerId = bankerId;
    }

    public String getExistingFinance() {
        return existingFinance;
    }

    public void setExistingFinance(String existingFinance) {
        this.existingFinance = existingFinance;
    }

    @Override
    public String toString() {
        return "LoanApplyDetail{" +
                "id=" + id +
                ", loanRecordId=" + loanRecordId +
                ", newLoanFinance='" + newLoanFinance + '\'' +
                ", newLoanName='" + newLoanName + '\'' +
                ", newLoanAmount=" + newLoanAmount +
                ", newLoanInterest=" + newLoanInterest +
                ", newLoanOverdue=" + newLoanOverdue +
                ", newLoanPeriod=" + newLoanPeriod +
                ", newLoanStartDate='" + newLoanStartDate + '\'' +
                ", newLoanEndDate='" + newLoanEndDate + '\'' +
                ", newLoanInterestDate='" + newLoanInterestDate + '\'' +
                ", newLoanInRepayment='" + newLoanInRepayment + '\'' +
                ", newLoanStatus='" + newLoanStatus + '\'' +
                ", newLoanAccount='" + newLoanAccount + '\'' +
                ", applicationDate='" + applicationDate + '\'' +
                ", bankerId=" + bankerId +
                ", existingFinance='" + existingFinance + '\'' +
                '}';
    }
}
