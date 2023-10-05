package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "account_transaction")
public class AccountTransactionVO {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "account_transaction_seq")
    @SequenceGenerator(name = "account_transaction_seq", sequenceName = "account_transaction_seq", allocationSize = 1)
    @Column(name = "id")
    private int id;
    @Column(name = "accountid", nullable = false, length = 200)
    private String accountid;

    @Column(name = "transaction_date", nullable = false)
    private Date transactionDate;

    @Column(name = "transaction_type", nullable = false, length = 100)
    private String transactionType;

    @Column(name = "counterparty_account_id", length = 100)
    private String counterpartyAccountId;

    @Column(name = "transaction_fee")
    private int transactionFee;

    @Column(name = "transaction_amount", nullable = false)
    private int transactionAmount;

    @Column(name = "remarks", length = 1000)
    private String remarks;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAccountid() {
        return accountid;
    }

    public void setAccountid(String accountid) {
        this.accountid = accountid;
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

    public int getTransactionFee() {
        return transactionFee;
    }

    public void setTransactionFee(int transactionFee) {
        this.transactionFee = transactionFee;
    }

    public int getTransactionAmount() {
        return transactionAmount;
    }

    public void setTransactionAmount(int transactionAmount) {
        this.transactionAmount = transactionAmount;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @Override
    public String toString() {
        return "AccountTranscationVO{" +
                "id=" + id +
                ", accountid='" + accountid + '\'' +
                ", transactionDate='" + transactionDate + '\'' +
                ", transactionType='" + transactionType + '\'' +
                ", counterpartyAccountId='" + counterpartyAccountId + '\'' +
                ", transactionFee=" + transactionFee +
                ", transactionAmount=" + transactionAmount +
                ", remarks='" + remarks + '\'' +
                '}';
    }
}
