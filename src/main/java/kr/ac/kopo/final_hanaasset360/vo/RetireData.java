package kr.ac.kopo.final_hanaasset360.vo;

public class RetireData {

    // 생년월일
    private String userBirth;

    // 현재 나이
    private int age;

    // 은퇴 나이
    private int retirementAge;

    // 기대 수명
    private int lifeExpectancy;

    // 현재 평균 월 생활비
    private int monthlyExpenditure;

    // 은퇴 후 월 생활비
    private int retirementExpenditure;

    // 하나은행 자산
    private int hanaBankTotal;

    // 타은행 자산
    private int otherBankTotal;

    // 하나은행 부채
    private int hanaLoanTotal;

    // 타은행 부채
    private int otherLoanTotal;

    // 연간 지출
    private int totalUsage;

    // 연간 수입
    private int annualIncome;

    // 연금 수령액(65살 이후 받음)
    private int pension;

    // 연금 종류
    private String pensionType;

    public String getUserBirth() {
        return userBirth;
    }

    public void setUserBirth(String userBirth) {
        this.userBirth = userBirth;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getRetirementAge() {
        return retirementAge;
    }

    public void setRetirementAge(int retirementAge) {
        this.retirementAge = retirementAge;
    }

    public int getLifeExpectancy() {
        return lifeExpectancy;
    }

    public void setLifeExpectancy(int lifeExpectancy) {
        this.lifeExpectancy = lifeExpectancy;
    }

    public int getMonthlyExpenditure() {
        return monthlyExpenditure;
    }

    public void setMonthlyExpenditure(int monthlyExpenditure) {
        this.monthlyExpenditure = monthlyExpenditure;
    }

    public int getRetirementExpenditure() {
        return retirementExpenditure;
    }

    public void setRetirementExpenditure(int retirementExpenditure) {
        this.retirementExpenditure = retirementExpenditure;
    }

    public int getHanaBankTotal() {
        return hanaBankTotal;
    }

    public void setHanaBankTotal(int hanaBankTotal) {
        this.hanaBankTotal = hanaBankTotal;
    }

    public int getOtherBankTotal() {
        return otherBankTotal;
    }

    public void setOtherBankTotal(int otherBankTotal) {
        this.otherBankTotal = otherBankTotal;
    }

    public int getHanaLoanTotal() {
        return hanaLoanTotal;
    }

    public void setHanaLoanTotal(int hanaLoanTotal) {
        this.hanaLoanTotal = hanaLoanTotal;
    }

    public int getOtherLoanTotal() {
        return otherLoanTotal;
    }

    public void setOtherLoanTotal(int otherLoanTotal) {
        this.otherLoanTotal = otherLoanTotal;
    }

    public int getTotalUsage() {
        return totalUsage;
    }

    public void setTotalUsage(int totalUsage) {
        this.totalUsage = totalUsage;
    }

    public int getAnnualIncome() {
        return annualIncome;
    }

    public void setAnnualIncome(int annualIncome) {
        this.annualIncome = annualIncome;
    }

    public int getPension() {
        return pension;
    }

    public void setPension(int pension) {
        this.pension = pension;
    }

    public String getPensionType() {
        return pensionType;
    }

    public void setPensionType(String pensionType) {
        this.pensionType = pensionType;
    }

    @Override
    public String toString() {
        return "RetireData{" +
                "userBirth='" + userBirth + '\'' +
                ", age=" + age +
                ", retirementAge=" + retirementAge +
                ", lifeExpectancy=" + lifeExpectancy +
                ", monthlyExpenditure=" + monthlyExpenditure +
                ", retirementExpenditure=" + retirementExpenditure +
                ", hanaBankTotal=" + hanaBankTotal +
                ", otherBankTotal=" + otherBankTotal +
                ", hanaLoanTotal=" + hanaLoanTotal +
                ", otherLoanTotal=" + otherLoanTotal +
                ", totalUsage=" + totalUsage +
                ", annualIncome=" + annualIncome +
                ", pension=" + pension +
                ", pensionType='" + pensionType + '\'' +
                '}';
    }
}
