package vo;

import java.sql.Date;

public class TransactionDTO {
    
    private int id;  // id가 NUMERIC(38)로 정의되어 있으므로 BigDecimal 사용
    private String accountId;  // accountid
    private Date transactionDate;  // transaction_date
    private String transactionType;  // transaction_type
    private String counterpartyAccountId;  // counterparty_account_id
    private int transactionAmount;  // transaction_amount
    private int transactionFee;  // transaction_fee
    private String remarks;  // remarks
    
    
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
    public Date getTransactionDate() {
        return transactionDate;
    }
    public void setTransactionDate(Date transactionDate) {
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

    
}
