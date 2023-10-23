package vo;

public class KcbAssetDTO {
    private int id;
    private int memberId;
    private int realEstateValue;
    private int bankSavings;
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
    public int getRealEstateValue() {
        return realEstateValue;
    }
    public void setRealEstateValue(int realEstateValue) {
        this.realEstateValue = realEstateValue;
    }
    public int getBankSavings() {
        return bankSavings;
    }
    public void setBankSavings(int bankSavings) {
        this.bankSavings = bankSavings;
    }
    @Override
    public String toString() {
        return "KcbAssetDTO [id=" + id + ", memberId=" + memberId + ", realEstateValue="
                + realEstateValue + ", bankSavings=" + bankSavings + "]";
    }
    
    
    

}
