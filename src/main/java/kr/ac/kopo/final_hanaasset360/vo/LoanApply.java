package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.*;

public class LoanApply {

    private long id;


    private Long loanRecordId;
    private String newLoanFinance;
    private String newLoanName;
    private Long newLoanAmount;
    private Double newLoanInterest;
    private Double newLoanOverdue;
    private Long newLoanPeriod;
    private String newLoanStartDate;
    private String newLoanEndDate;
    private String newLoanInterestDate;
    private String newLoanInRepayment;
    private String newLoanStatus;
    private String newLoanAccount;
    private String applicationDate;
    private Long bankerId;

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
}
