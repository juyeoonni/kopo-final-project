package kr.ac.kopo.final_hanaasset360.vo;

public class LoanProductVO {
    private String fnstDvVal;
    private double loanLimAmt;
    private String loanPdctNm;
    private double selectedCreditGrade;
    private double earlyRepayFee;

    public String getFnstDvVal() {
        return fnstDvVal;
    }

    public void setFnstDvVal(String fnstDvVal) {
        this.fnstDvVal = fnstDvVal;
    }

    public double getLoanLimAmt() {
        return loanLimAmt;
    }

    public void setLoanLimAmt(double loanLimAmt) {
        this.loanLimAmt = loanLimAmt;
    }

    public String getLoanPdctNm() {
        return loanPdctNm;
    }

    public void setLoanPdctNm(String loanPdctNm) {
        this.loanPdctNm = loanPdctNm;
    }

    public double getSelectedCreditGrade() {
        return selectedCreditGrade;
    }

    public void setSelectedCreditGrade(double selectedCreditGrade) {
        this.selectedCreditGrade = selectedCreditGrade;
    }

    public double getEarlyRepayFee() {
        return earlyRepayFee;
    }

    public void setEarlyRepayFee(double earlyRepayFee) {
        this.earlyRepayFee = earlyRepayFee;
    }
}
