package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.message.HomtaxCreditInfo;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Service
public class RetirementServiceImpl implements RetirementService{

    public List<HomtaxCreditInfo> getCreditInfoByLoggedInUser(Long personalId) {
        // RestTemplate 인스턴스 생성
        RestTemplate restTemplate = new RestTemplate();

        // homtax 경로 호출 (여기서는 동일한 애플리케이션 내의 API를 호출하므로, localhost를 사용합니다.)
        String url = "http://16.171.189.30:8080/gwanjung/homtax?personalId=" + personalId;

        // API 호출 결과 받기
        ResponseEntity<List<HomtaxCreditInfo>> responseEntity = restTemplate.exchange(
                url,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<HomtaxCreditInfo>>() {}
        );

        return responseEntity.getBody();
    }



    /**
     * 필요한 노후 준비금을 계산하는 함수입니다.
     *
     * @param currentAge 현재 나이
     * @param expectedRetirementAge 예상 은퇴나이
     * @param expectedLifeSpan 기대수명
     * @param annualIncome 연간 수입
     * @param expectedMonthlyExpenseAfterRetirement 은퇴 후 예상 월 생활비
     * @param pensionMonthlyAmount 공적연금 월 수령액
     * @param currentAssets 현재 자산 총액
     * @param currentLiabilities 현재 부채 총액
     * @return 필요한 노후 준비금
     */
    public double calculateRequiredRetirementFund(double currentAge, double expectedRetirementAge, double expectedLifeSpan,
                                                         double annualIncome, double expectedMonthlyExpenseAfterRetirement,
                                                         double pensionMonthlyAmount, double currentAssets, double currentLiabilities) {
        double netAsset = currentAssets - currentLiabilities; // 순 자산

        double remainingYearsOfWork = expectedRetirementAge - currentAge; // 남은 노동 연수
        double totalExpectedIncome = annualIncome * remainingYearsOfWork; // 남은 노동 연수 동안의 총 예상 수입

        double yearsAfterRetirement = expectedLifeSpan - expectedRetirementAge; // 은퇴 후 살아남을 연수
        double totalExpenseAfterRetirement = expectedMonthlyExpenseAfterRetirement * 12 * yearsAfterRetirement; // 은퇴 후 예상 총 생활비

        double totalPensionAmount = pensionMonthlyAmount * 12 * yearsAfterRetirement; // 은퇴 후 받을 총 공적연금 금액

        double requiredRetirementFund = totalExpenseAfterRetirement - totalPensionAmount; // 필요한 노후 자금
        double requiredSavings = requiredRetirementFund - netAsset; // 노후를 위해 더 저축해야할 금액

        return requiredSavings;
    }
}
