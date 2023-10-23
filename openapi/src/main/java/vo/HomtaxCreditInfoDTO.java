package vo;

import java.security.Timestamp;

public class HomtaxCreditInfoDTO {
    
    private java.sql.Timestamp registrationDate;
    private String Id;
    private int creditCardUsage;
    private int debitCardUsage;
    private int cashReceipt;
    private int annualIncome;
    public java.sql.Timestamp getRegistrationDate() {
        return registrationDate;
    }
    public void setRegistrationDate(java.sql.Timestamp timestamp) {
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
