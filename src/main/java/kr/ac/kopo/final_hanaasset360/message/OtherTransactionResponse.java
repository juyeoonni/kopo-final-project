package kr.ac.kopo.final_hanaasset360.message;

import java.util.Date;

public class OtherTransactionResponse {

    private int id;
    private String accountId;
    private String transactionDate; // 문자열로 받아온 후 필요에 따라 Date로 변환
    private String transactionType;
    private String counterpartyAccountId;
    private int transactionAmount;
    private int transactionFee;
    private String remarks;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(String transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getCounterpartyAccountId() {
        return counterpartyAccountId;
    }

    public void setCounterpartyAccountId(String counterpartyAccountId) {
        this.counterpartyAccountId = counterpartyAccountId;
    }

    public int getTransactionAmount() {
        return transactionAmount;
    }

    public void setTransactionAmount(int transactionAmount) {
        this.transactionAmount = transactionAmount;
    }

    public int getTransactionFee() {
        return transactionFee;
    }

    public void setTransactionFee(int transactionFee) {
        this.transactionFee = transactionFee;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @Override
    public String toString() {
        return "OtherTransactionResponse{" +
                "id=" + id +
                ", accountId='" + accountId + '\'' +
                ", transactionDate='" + transactionDate + '\'' +
                ", transactionType='" + transactionType + '\'' +
                ", counterpartyAccountId='" + counterpartyAccountId + '\'' +
                ", transactionAmount=" + transactionAmount +
                ", transactionFee=" + transactionFee +
                ", remarks='" + remarks + '\'' +
                '}';
    }
}
