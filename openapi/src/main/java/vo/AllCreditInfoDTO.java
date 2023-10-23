package vo;

import java.math.BigDecimal;

public class AllCreditInfoDTO {
    private String id;
    private int creditScore;
    private int repaymentScore;
    private int loanScore;
    private int creditRisk;
    private int creditPeriodScore;

    // 기본 생성자
    public AllCreditInfoDTO() {
    }

    

    public String getId() {
        return id;
    }



    public void setId(String id) {
        this.id = id;
    }



    public int getCreditScore() {
        return creditScore;
    }



    public void setCreditScore(int creditScore) {
        this.creditScore = creditScore;
    }



    public int getRepaymentScore() {
        return repaymentScore;
    }



    public void setRepaymentScore(int repaymentScore) {
        this.repaymentScore = repaymentScore;
    }



    public int getLoanScore() {
        return loanScore;
    }



    public void setLoanScore(int loanScore) {
        this.loanScore = loanScore;
    }



    public int getCreditRisk() {
        return creditRisk;
    }



    public void setCreditRisk(int creditRisk) {
        this.creditRisk = creditRisk;
    }



    public int getCreditPeriodScore() {
        return creditPeriodScore;
    }



    public void setCreditPeriodScore(int creditPeriodScore) {
        this.creditPeriodScore = creditPeriodScore;
    }



    @Override
    public String toString() {
        return "AllCreditInfoDTO{" +
                "id='" + id + '\'' +
                ", creditScore=" + creditScore +
                ", repaymentScore=" + repaymentScore +
                ", loanScore=" + loanScore +
                ", creditRisk=" + creditRisk +
                ", creditPeriodScore=" + creditPeriodScore +
                '}';
    }
}

