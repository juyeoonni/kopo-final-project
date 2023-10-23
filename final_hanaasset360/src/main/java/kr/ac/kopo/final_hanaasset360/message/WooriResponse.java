package kr.ac.kopo.final_hanaasset360.message;

import java.util.List;

public class WooriResponse {
    private String userId;
    private List<Long> loanRecordIds;

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
