package kr.ac.kopo.final_hanaasset360.message;

import java.util.Map;

public class LoanSwitchRequest {

    private Map<String, Object> selectedLoanProduct;
    private Map<String, Object> creditData;
    private Map<String, Object> selectedLoanData;

    public Map<String, Object> getSelectedLoanProduct() {
        return selectedLoanProduct;
    }

    public void setSelectedLoanProduct(Map<String, Object> selectedLoanProduct) {
        this.selectedLoanProduct = selectedLoanProduct;
    }

    public Map<String, Object> getCreditData() {
        return creditData;
    }

    public void setCreditData(Map<String, Object> creditData) {
        this.creditData = creditData;
    }

    public Map<String, Object> getSelectedLoanData() {
        return selectedLoanData;
    }

    public void setSelectedLoanData(Map<String, Object> selectedLoanData) {
        this.selectedLoanData = selectedLoanData;
    }
}
