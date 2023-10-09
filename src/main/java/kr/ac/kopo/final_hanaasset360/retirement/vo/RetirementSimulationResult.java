package kr.ac.kopo.final_hanaasset360.retirement.vo;

import jakarta.persistence.*;

@Entity
@Table(name = "RETIREMENT_SIMULATION_RESULT")
public class RetirementSimulationResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @OneToOne
    @JoinColumn(name = "RETIRE_DATA_ID")
    private RetireData retireData;

    @Column(name = "ANNUALSAVINGS")
    private int annualSavings;

    @Column(name = "TOTALSAVINGSUNTILRETIREMENT")
    private int totalSavingsUntilRetirement;

    @Column(name = "ANNUALRETIREMENTNEEDS")
    private int annualRetirementNeeds;

    @Column(name = "TOTALRETIREMENTNEEDS")
    private int totalRetirementNeeds;

    @Column(name = "FINANCIALGAP")
    private int financialGap;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public RetireData getRetireData() {
        return retireData;
    }

    public void setRetireData(RetireData retireData) {
        this.retireData = retireData;
    }

    public int getAnnualSavings() {
        return annualSavings;
    }

    public void setAnnualSavings(int annualSavings) {
        this.annualSavings = annualSavings;
    }

    public int getTotalSavingsUntilRetirement() {
        return totalSavingsUntilRetirement;
    }

    public void setTotalSavingsUntilRetirement(int totalSavingsUntilRetirement) {
        this.totalSavingsUntilRetirement = totalSavingsUntilRetirement;
    }

    public int getAnnualRetirementNeeds() {
        return annualRetirementNeeds;
    }

    public void setAnnualRetirementNeeds(int annualRetirementNeeds) {
        this.annualRetirementNeeds = annualRetirementNeeds;
    }

    public int getTotalRetirementNeeds() {
        return totalRetirementNeeds;
    }

    public void setTotalRetirementNeeds(int totalRetirementNeeds) {
        this.totalRetirementNeeds = totalRetirementNeeds;
    }

    public int getFinancialGap() {
        return financialGap;
    }

    public void setFinancialGap(int financialGap) {
        this.financialGap = financialGap;
    }

    public void updateWith(RetirementSimulationResult newResult) {
        this.setAnnualSavings(newResult.getAnnualSavings());
        this.setTotalSavingsUntilRetirement(newResult.getTotalSavingsUntilRetirement());
        this.setAnnualRetirementNeeds(newResult.getAnnualRetirementNeeds());
        this.setTotalRetirementNeeds(newResult.getTotalRetirementNeeds());
        this.setFinancialGap(newResult.getFinancialGap());
    }

    @Override
    public String toString() {
        return "RetirementSimulationResult{" +
                "id=" + id +
                ", retireData=" + retireData +
                ", annualSavings=" + annualSavings +
                ", totalSavingsUntilRetirement=" + totalSavingsUntilRetirement +
                ", annualRetirementNeeds=" + annualRetirementNeeds +
                ", totalRetirementNeeds=" + totalRetirementNeeds +
                ", financialGap=" + financialGap +
                '}';
    }
}
