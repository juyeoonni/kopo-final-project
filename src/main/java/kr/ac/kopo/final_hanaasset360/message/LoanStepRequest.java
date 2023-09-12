package kr.ac.kopo.final_hanaasset360.message;

public class LoanStepRequest {
    private int id;
    private String bank;
    private int loanDataID;
    private Integer fnstDvVal;
    private String loanPdctNm;
    private int LoanLimAmt;
    private Double selectedCreditGrade;
    private Double earlyRepayFee;



    private Integer loanTerm;
    private Integer interestPaydate;
    private String loanPayType;
    private String repaymentAccount;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank;
    }

    public int getLoanDataID() {
        return loanDataID;
    }

    public void setLoanDataID(int loanDataID) {
        this.loanDataID = loanDataID;
    }

    public Integer getFnstDvVal() {
        return fnstDvVal;
    }

    public void setFnstDvVal(Integer fnstDvVal) {
        this.fnstDvVal = fnstDvVal;
    }

    public String getLoanPdctNm() {
        return loanPdctNm;
    }

    public void setLoanPdctNm(String loanPdctNm) {
        this.loanPdctNm = loanPdctNm;
    }

    public int getLoanLimAmt() {
        return LoanLimAmt;
    }

    public void setLoanLimAmt(int loanLimAmt) {
        LoanLimAmt = loanLimAmt;
    }

    public Double getSelectedCreditGrade() {
        return selectedCreditGrade;
    }

    public void setSelectedCreditGrade(Double selectedCreditGrade) {
        this.selectedCreditGrade = selectedCreditGrade;
    }

    public Double getEarlyRepayFee() {
        return earlyRepayFee;
    }

    public void setEarlyRepayFee(Double earlyRepayFee) {
        this.earlyRepayFee = earlyRepayFee;
    }

    public Integer getLoanTerm() {
        return loanTerm;
    }

    public void setLoanTerm(Integer loanTerm) {
        this.loanTerm = loanTerm;
    }

    public Integer getInterestPaydate() {
        return interestPaydate;
    }

    public void setInterestPaydate(Integer interestPaydate) {
        this.interestPaydate = interestPaydate;
    }

    public String getLoanPayType() {
        return loanPayType;
    }

    public void setLoanPayType(String loanPayType) {
        this.loanPayType = loanPayType;
    }

    public String getRepaymentAccount() {
        return repaymentAccount;
    }

    public void setRepaymentAccount(String repaymentAccount) {
        this.repaymentAccount = repaymentAccount;
    }

    @Override
    public String toString() {
        return "LoanStepRequest{" +
                "id=" + id +
                ", loanDataID=" + loanDataID +
                ", fnstDvVal=" + fnstDvVal +
                ", loanPdctNm='" + loanPdctNm + '\'' +
                ", LoanLimAmt=" + LoanLimAmt +
                ", selectedCreditGrade=" + selectedCreditGrade +
                ", earlyRepayFee=" + earlyRepayFee +
                ", loanTerm=" + loanTerm +
                ", interestPaydate=" + interestPaydate +
                ", loanPayType='" + loanPayType + '\'' +
                ", repaymentAccount='" + repaymentAccount + '\'' +
                '}';
    }
}