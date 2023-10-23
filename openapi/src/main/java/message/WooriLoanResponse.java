package message;

import java.util.List;

public class WooriLoanResponse {
    private String userId;
    private List<Long> loanRecordIds;
    public WooriLoanResponse(String userId, List<Long> loanRecordIds) {
        this.userId = userId;
        this.loanRecordIds = loanRecordIds;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public List<Long> getLoanRecordIds() {
        return loanRecordIds;
    }
    public void setLoanRecordIds(List<Long> loanRecordIds) {
        this.loanRecordIds = loanRecordIds;
    }
    
    
}
