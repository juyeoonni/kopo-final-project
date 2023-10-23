package kr.ac.kopo.final_hanaasset360.retirement.service;

import kr.ac.kopo.final_hanaasset360.message.HomtaxCreditInfo;
import kr.ac.kopo.final_hanaasset360.retirement.repository.RetireDataRepository;
import kr.ac.kopo.final_hanaasset360.retirement.repository.RetirementSimulationResultRepository;
import kr.ac.kopo.final_hanaasset360.retirement.vo.RetireData;
import kr.ac.kopo.final_hanaasset360.retirement.vo.RetirementSimulationResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class RetirementServiceImpl implements RetirementService{

    private final RetireDataRepository retireDataRepository;

    public RetirementServiceImpl(RetireDataRepository retireDataRepository) {
        this.retireDataRepository = retireDataRepository;
    }

    @Autowired
    private RetirementSimulationResultRepository retirementSimulationResultRepository;


    public List<HomtaxCreditInfo> getCreditInfoByLoggedInUser(Long personalId) {
        // RestTemplate 인스턴스 생성
        RestTemplate restTemplate = new RestTemplate();

        // homtax 경로 호출 (여기서는 동일한 애플리케이션 내의 API를 호출하므로, localhost를 사용합니다.)
        String url = "http://16.171.189.30:8080/hometax?personalId=" + personalId;

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


    public List<HomtaxCreditInfo>requestHometaxInfo(String id, String password) {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://16.171.189.30:8080/hometax-info?id=" + id + "&password=" + password;

        ResponseEntity<List<HomtaxCreditInfo>> responseEntity = restTemplate.exchange(
                url,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<HomtaxCreditInfo>>() {}
        );

        return responseEntity.getBody();
    }

    @Override
    public RetireData save(RetireData retireData) {
        return retireDataRepository.save(retireData);
    }

    @Override
    public Optional<RetireData> findByUserId(String userId) {
        return retireDataRepository.findByUserId(userId);
    }


    public RetirementSimulationResult simulateAndSave(RetireData retireData) {
        RetirementSimulation simulator = new RetirementSimulation(retireData);

        RetirementSimulationResult result = new RetirementSimulationResult();
        result.setRetireData(retireData);
        result.setAnnualSavings(simulator.calculateAnnualSavings());
        result.setTotalSavingsUntilRetirement(simulator.calculateTotalSavingsUntilRetirement());
        result.setAnnualRetirementNeeds(simulator.calculateAnnualRetirementNeeds());
        result.setTotalRetirementNeeds(simulator.calculateTotalRetirementNeeds());
        result.setFinancialGap(simulator.calculateFinancialGap());

        // 해당 retireData에 대한 시뮬레이션 결과가 이미 있는지 확인
        Optional<RetirementSimulationResult> existingResult = retirementSimulationResultRepository.findByRetireData(retireData);

        if(existingResult.isPresent()) {
            // 결과가 있으면 해당 값을 업데이트
            RetirementSimulationResult currentResult = existingResult.get();
            currentResult.updateWith(result); // 여기서는 updateWith 메서드가 해당 결과 값을 업데이트해야 합니다.
            return retirementSimulationResultRepository.save(currentResult);
        } else {
            // 결과가 없으면 새로운 데이터를 저장하고 반환
            return retirementSimulationResultRepository.save(result);
        }
    }

    @Override
    public RetireData getRetireDataByUserId(String userId) {
        return retireDataRepository.findByUserId(userId)
                .orElseThrow(() -> new NoSuchElementException("No retire data found for this user."));
    }

    @Override
    public List<RetirementSimulationResult> getSimulationResultsByRetireId(Long retireId) {
        return retirementSimulationResultRepository.findByRetireDataId(retireId);
    }

    public class RetirementSimulation {

        private RetireData retireData;

        public RetirementSimulation(RetireData retireData) {
            this.retireData = retireData;
        }


        // 현재 순자산 계산
        public int calculateCurrentNetAsset() {
            return retireData.getTotalAssets() - retireData.getTotalDebt();
        }

        // 은퇴 전까지 연간 저축액
        public int calculateAnnualSavings() {
            return retireData.getAnnualIncome() - retireData.getTotalUsage();
        }

        // 은퇴 시점까지의 총 저축액 (현재 순자산 포함)
        public int calculateTotalSavingsUntilRetirement() {
            int yearsUntilRetirement = retireData.getRetirementAge() - retireData.getAge();
            return (calculateAnnualSavings() * yearsUntilRetirement) + calculateCurrentNetAsset();
        }

        // 은퇴 후 연간 필요한 금액
        public int calculateAnnualRetirementNeeds() {
            return retireData.getRetirementExpenditure() * 12;
        }

        // 은퇴 후부터 평균 수명까지 필요한 총 금액
        public int calculateTotalRetirementNeeds() {
            int yearsAfterRetirement = retireData.getLifeExpectancy() - retireData.getRetirementAge();
            return calculateAnnualRetirementNeeds() * yearsAfterRetirement;
        }

        // 연금 고려하여 은퇴 후 필요한 총 금액
        public int calculateTotalNeedsAfterPension() {
            int yearsAfterRetirement = retireData.getLifeExpectancy() - retireData.getRetirementAge();
            int totalPension = retireData.getPension() * yearsAfterRetirement;
            return calculateTotalRetirementNeeds() - totalPension;
        }

        // 연금 및 저축을 고려한 은퇴 후 부족한 금액
        public int calculateFinancialGap() {
            return calculateTotalNeedsAfterPension() - calculateTotalSavingsUntilRetirement();

        }
    }


}
