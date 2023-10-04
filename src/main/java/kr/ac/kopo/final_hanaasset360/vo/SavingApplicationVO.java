package kr.ac.kopo.final_hanaasset360.vo;

public class SavingApplicationVO {

    private String savingName;
    private String bankName;
    private int savingAmount; // 금액은 일반적으로 Double 또는 BigDecimal 타입을 사용합니다.
    private String account;
    private Double interestRate; // 이자율도 Double 타입을 사용합니다.
    private String interestPaydate;
    private String loanPayType;
    private String password;
    private int monthlyPayment; // 월 납입금액도 Double 타입을 사용합니다.

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

    public String getLoanPayType() {
        return loanPayType;
    }

    public void setLoanPayType(String loanPayType) {
        this.loanPayType = loanPayType;
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

    @Override
    public String toString() {
        return "SavingApplicationVO{" +
                "savingName='" + savingName + '\'' +
                ", bankName='" + bankName + '\'' +
                ", savingAmount=" + savingAmount +
                ", account='" + account + '\'' +
                ", interestRate=" + interestRate +
                ", interestPaydate='" + interestPaydate + '\'' +
                ", loanPayType='" + loanPayType + '\'' +
                ", password='" + password + '\'' +
                ", monthlyPayment=" + monthlyPayment +
                '}';
    }
}
