package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.*;

@Entity
@Table(name = "RETIRE_TABLE")
public class RetireData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "USERID")
    private String userId;

    @Transient
    private String userBirth;

    @Column(name = "AGE")
    private int age;

    @Column(name = "RETIREMENT_AGE")
    private int retirementAge;

    @Column(name = "LIFE_EXPECTANCY")
    private int lifeExpectancy;

    @Column(name = "MONTHLY_EXPENDITURE")
    private int monthlyExpenditure;

    @Column(name = "RETIREMENT_EXPENDITURE")
    private int retirementExpenditure;

    @Transient
    private int hanaBankTotal;

    @Transient
    private int otherBankTotal;

    @Transient
    private int hanaLoanTotal;

    @Transient
    private int otherLoanTotal;

    @Column(name = "TOTAL_USAGE")
    private int totalUsage;

    @Column(name = "ANNUAL_INCOME")
    private int annualIncome;

    @Column(name = "PENSION")
    private int pension;

    @Column(name = "PENSION_TYPE")
    private String pensionType;

    @Column(name = "TOTAL_ASSETS")
    private int totalAssets;

    @Column(name = "TOTAL_DEBT")
    private int totalDebt;

    @PrePersist
    @PreUpdate
    public void calculateTotals() {
        this.totalAssets = hanaBankTotal + otherBankTotal;
        this.totalDebt = hanaLoanTotal + otherLoanTotal;
    }
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

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getTotalAssets() {
        return totalAssets;
    }

    public void setTotalAssets(int totalAssets) {
        this.totalAssets = totalAssets;
    }

    public int getTotalDebt() {
        return totalDebt;
    }

    public void setTotalDebt(int totalDebt) {
        this.totalDebt = totalDebt;
    }

    public void updateWith(RetireData newData) {
        // userId는 업데이트 하지 않습니다.

        this.setAge(newData.getAge());
        this.setRetirementAge(newData.getRetirementAge());
        this.setLifeExpectancy(newData.getLifeExpectancy());
        this.setMonthlyExpenditure(newData.getMonthlyExpenditure());
        this.setRetirementExpenditure(newData.getRetirementExpenditure());
        this.setTotalUsage(newData.getTotalUsage());
        this.setAnnualIncome(newData.getAnnualIncome());
        this.setPension(newData.getPension());
        this.setPensionType(newData.getPensionType());

        // 여기에서 추가적으로 hanaBankTotal, otherBankTotal, hanaLoanTotal, otherLoanTotal 값을 업데이트합니다.
        this.setHanaBankTotal(newData.getHanaBankTotal());
        this.setOtherBankTotal(newData.getOtherBankTotal());
        this.setHanaLoanTotal(newData.getHanaLoanTotal());
        this.setOtherLoanTotal(newData.getOtherLoanTotal());

        // 값을 업데이트한 후 calculateTotals 메서드를 호출하여 totalAssets와 totalDebt 값을 계산합니다.
        this.calculateTotals();
    }

    @Override
    public String toString() {
        return "RetireData{" +
                "id=" + id +
                ", userId='" + userId + '\'' +
                ", userBirth='" + userBirth + '\'' +
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
                ", totalAssets=" + totalAssets +
                ", totalDebt=" + totalDebt +
                '}';
    }
}
