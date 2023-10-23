package kr.ac.kopo.final_hanaasset360.message;

import java.time.LocalDateTime;

public class HomtaxCreditInfo {

    private String registrationDate;
    private String Id;
    private int creditCardUsage;
    private int debitCardUsage;
    private int cashReceipt;
    private int annualIncome;
    public String getRegistrationDate() {
        return registrationDate;
    }
    public void setRegistrationDate(String timestamp) {
        this.registrationDate = timestamp;
    }

    public String getId() {
        return Id;
    }
    public void setId(String id) {
        Id = id;
    }
    public int getCreditCardUsage() {
        return creditCardUsage;
    }
    public void setCreditCardUsage(int creditCardUsage) {
        this.creditCardUsage = creditCardUsage;
    }
    public int getDebitCardUsage() {
        return debitCardUsage;
    }
    public void setDebitCardUsage(int debitCardUsage) {
        this.debitCardUsage = debitCardUsage;
    }
    public int getCashReceipt() {
        return cashReceipt;
    }
    public void setCashReceipt(int cashReceipt) {
        this.cashReceipt = cashReceipt;
    }
    public int getAnnualIncome() {
        return annualIncome;
    }
    public void setAnnualIncome(int annualIncome) {
        this.annualIncome = annualIncome;
    }

}
