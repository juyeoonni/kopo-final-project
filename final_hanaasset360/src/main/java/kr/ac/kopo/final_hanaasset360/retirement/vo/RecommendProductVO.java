package kr.ac.kopo.final_hanaasset360.retirement.vo;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "recommend_product")
public class RecommendProductVO {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "finance_code")
    private String financeCode;

    @Column(name = "type")
    private String type;

    @Column(name = "risk")
    private Double risk;

    @Column(name = "MAXSAVINGS")
    private Double maxSavings;

    @Column(name = "SUBSCRIPTIONPERIOD")
    private Double subscriptionPeriod;

    @Column(name = "ANNUALEXPECTEDRETURN")
    private Double annualExpectedReturn;

    @Column(name = "description")
    private String description;

    @Column(name = "img")
    private String img;

    @Column(name = "MINSAVING")
    private int minSaving;

    @Column(name = "MIN_DEPOSIT_AMOUNT")
    private int minDepositAmount;

    @Column(name = "MAX_DEPOSIT_AMOUNT")
    private int maxDepositAmount;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFinanceCode() {
        return financeCode;
    }

    public void setFinanceCode(String financeCode) {
        this.financeCode = financeCode;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Double getRisk() {
        return risk;
    }

    public void setRisk(Double risk) {
        this.risk = risk;
    }

    public Double getMaxSavings() {
        return maxSavings;
    }

    public void setMaxSavings(Double maxSavings) {
        this.maxSavings = maxSavings;
    }

    public Double getSubscriptionPeriod() {
        return subscriptionPeriod;
    }

    public void setSubscriptionPeriod(Double subscriptionPeriod) {
        this.subscriptionPeriod = subscriptionPeriod;
    }

    public Double getAnnualExpectedReturn() {
        return annualExpectedReturn;
    }

    public void setAnnualExpectedReturn(Double annualExpectedReturn) {
        this.annualExpectedReturn = annualExpectedReturn;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getMinSaving() {
        return minSaving;
    }

    public void setMinSaving(int minSaving) {
        this.minSaving = minSaving;
    }

    public int getMinDepositAmount() {
        return minDepositAmount;
    }

    public void setMinDepositAmount(int minDepositAmount) {
        this.minDepositAmount = minDepositAmount;
    }

    public int getMaxDepositAmount() {
        return maxDepositAmount;
    }

    public void setMaxDepositAmount(int maxDepositAmount) {
        this.maxDepositAmount = maxDepositAmount;
    }
}
