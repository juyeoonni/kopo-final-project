package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Accounts {
    @Id
    private String accountId;
    private String userId;
    private String accountType;
    private int accountBalance;
    private String financialCode;

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public int getAccountBalance() {
        return accountBalance;
    }

    public void setAccountBalance(int accountBalance) {
        this.accountBalance = accountBalance;
    }

    public String getFinancialCode() {
        return financialCode;
    }

    public void setFinancialCode(String financialCode) {
        this.financialCode = financialCode;
    }

    @Override
    public String toString() {
        return "Account{" +
                "accountId='" + accountId + '\'' +
                ", userId='" + userId + '\'' +
                ", accountType='" + accountType + '\'' +
                ", accountBalance=" + accountBalance +
                ", financialCode='" + financialCode + '\'' +
                '}';
    }

    // ... Getter, Setter, 기본 생성자, 기타 메서드 ...
}