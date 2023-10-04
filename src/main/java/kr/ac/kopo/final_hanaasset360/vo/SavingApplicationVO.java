package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "saving_records")
public class SavingApplicationVO {


    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "saving_records_seq_gen")
    @SequenceGenerator(name = "saving_records_seq_gen", sequenceName = "saving_records_seq", allocationSize = 1)
    private Long id;

    @Column(name = "userid", nullable = false, length = 30)
    private String userId;

    @Column(name = "name", nullable = false, length = 200)
    private String savingName;

    @Column(name = "bank_name", length = 50)
    private String bankName;

    @Column(name = "join_amount")
    private int savingAmount;

    @Column(name = "account", length = 100)
    private String account;

    @Column(name = "interestrate", precision = 5, scale = 2)
    private Double interestRate;

    @Column(name = "interest_pay_date", length = 50)
    private String interestPaydate;

    @Column(name = "password", length = 50)
    private String password;

    @Column(name = "payment_amount")
    private int monthlyPayment;

    @Transient
    private int subscriptionPeriodValue;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;

    @Column(name = "current_saved_amount")
    private int currentSavedAmount;

    @Column(name = "status", length = 50)
    private String status;

    @Column(name = "saving_type", length = 100)
    private String savingsType;

    // Getter, Setter 및 toString 메서드

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getSavingName() {
        return savingName;
    }

    public void setSavingName(String savingName) {
        this.savingName = savingName;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public int getSavingAmount() {
        return savingAmount;
    }

    public void setSavingAmount(int savingAmount) {
        this.currentSavedAmount = savingAmount;
        this.savingAmount = savingAmount;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public Double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(Double interestRate) {
        this.interestRate = interestRate;
    }

    public String getInterestPaydate() {
        return interestPaydate;
    }

    public void setInterestPaydate(String interestPaydate) {
        this.interestPaydate = interestPaydate;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getMonthlyPayment() {
        return monthlyPayment;
    }

    public void setMonthlyPayment(int monthlyPayment) {
        this.monthlyPayment = monthlyPayment;
    }

    public int getSubscriptionPeriodValue() {
        return subscriptionPeriodValue;
    }

    public void setSubscriptionPeriodValue(int subscriptionPeriodValue) {
        this.subscriptionPeriodValue = subscriptionPeriodValue;
        this.startDate = LocalDate.now();
        this.endDate = startDate.plusMonths(subscriptionPeriodValue);
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public int getCurrentSavedAmount() {
        return currentSavedAmount;
    }

    public void setCurrentSavedAmount(int currentSavedAmount) {
        this.currentSavedAmount = currentSavedAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSavingsType() {
        return savingsType;
    }

    public void setSavingsType(String savingsType) {
        this.savingsType = savingsType;
    }

    @Override
    public String toString() {
        return "SavingApplicationVO{" +
                "id=" + id +
                ", userId='" + userId + '\'' +
                ", savingName='" + savingName + '\'' +
                ", bankName='" + bankName + '\'' +
                ", savingAmount=" + savingAmount +
                ", account='" + account + '\'' +
                ", interestRate=" + interestRate +
                ", interestPaydate='" + interestPaydate + '\'' +
                ", password='" + password + '\'' +
                ", monthlyPayment=" + monthlyPayment +
                ", subscriptionPeriodValue=" + subscriptionPeriodValue +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", currentSavedAmount=" + currentSavedAmount +
                ", status='" + status + '\'' +
                ", savingType='" + savingsType + '\'' +
                '}';
    }
}
