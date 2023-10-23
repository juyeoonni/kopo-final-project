package vo;

public class KcbCreditInfoDTO {
    private int id;
    private int memberId;
    private int creditScore;
    private int loanAmount;
    private int annualIncome;
    private String occupation;
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getMemberId() {
        return memberId;
    }
    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }
    public int getCreditScore() {
        return creditScore;
    }
    public void setCreditScore(int creditScore) {
        this.creditScore = creditScore;
    }
    public int getLoanAmount() {
        return loanAmount;
    }
    public void setLoanAmount(int loanAmount) {
        this.loanAmount = loanAmount;
    }
    
    public int getAnnualIncome() {
        return annualIncome;
    }
    public void setAnnualIncome(int annualIncome) {
        this.annualIncome = annualIncome;
    }
    public String getOccupation() {
        return occupation;
    }
    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }
    @Override
    public String toString() {
        return "KcbCreditInfoDTO [id=" + id + ", memberId=" + memberId + ", creditScore="
                + creditScore + ", loanAmount=" + loanAmount + ", annulaIncome=" + annualIncome
                + ", occupation=" + occupation + "]";
    }
    
    
}
