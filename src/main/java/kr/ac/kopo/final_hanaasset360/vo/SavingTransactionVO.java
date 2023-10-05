package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "saving_transaction")
public class SavingTransactionVO {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "saving_transaction_seq_gen")
    @SequenceGenerator(name = "saving_transaction_seq_gen", sequenceName = "saving_transaction_seq", allocationSize = 1)
    private int id;
    @Column(name = "account_id", nullable = false, length = 200)
    private String accountId;

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
        return "SavingTransactionVO{" +
                "id=" + id +
                ", accountId='" + accountId + '\'' +
                ", transactionDate=" + transactionDate +
                ", transactionType='" + transactionType + '\'' +
                ", counterpartyAccountId='" + counterpartyAccountId + '\'' +
                ", transactionFee=" + transactionFee +
                ", transactionAmount=" + transactionAmount +
                ", remarks='" + remarks + '\'' +
                '}';
    }
}
