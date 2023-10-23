package kr.ac.kopo.final_hanaasset360.api.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.ac.kopo.final_hanaasset360.loan.dao.LoanDAO;
import kr.ac.kopo.final_hanaasset360.loan.vo.Loan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.fasterxml.jackson.core.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ApiServiceImpl implements ApiService {


    @Autowired
    private LoanDAO loanDAO;
    private static final Logger logger = LoggerFactory.getLogger(ApiServiceImpl.class);

    private final RestTemplate restTemplate;

    private static final String KCB_CREDIT_URL = "http://16.171.189.30:8080/kcb-credit";
    private static final String HOMTAX_URL = "http://16.171.189.30:8080/hometax";

    public ApiServiceImpl() {
        this.restTemplate = new RestTemplate();
    }


    public String loanDataFormAPI(String personalId, List<String> banks) {
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl("http://16.171.189.30:8080/bank/loan-response")
                .queryParam("personalIdNumber", personalId);

        for (String bank : banks) {
            uriBuilder.queryParam("banks", bank);
        }

        URI uri = uriBuilder.build().encode().toUri();

        ResponseEntity<String> response = restTemplate.getForEntity(uri, String.class);

        if (response.getStatusCode().is2xxSuccessful()) {
            logger.info("Received Response: {}", response.getBody());  // 이 부분에서 로그로 응답 값을 출력합니다.
            return response.getBody();
        } else {
            logger.error("Failed to fetch data. Status code: {}", response.getStatusCode()); // 에러 발생 시 로그 출력
            return null;
        }
    }


    public List<Loan> getLoanDataFromAPI(String personalId, List<String> banks) {
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl("http://16.171.189.30:8080/gwanjung/loan-response")
                .queryParam("personalIdNumber", personalId);

        for (String bank : banks) {
            uriBuilder.queryParam("banks", bank);
        }

        URI uri = uriBuilder.build().encode().toUri();

        try {
            ResponseEntity<String> response = restTemplate.getForEntity(uri, String.class);
            if (response.getStatusCode().is2xxSuccessful()) {
                String responseBody = response.getBody();
                ObjectMapper objectMapper = new ObjectMapper();
                List<Loan> loans = objectMapper.readValue(responseBody, new TypeReference<List<Loan>>(){});
                return loans;
            } else {
                logger.error("Failed to fetch data. Status code: {}", response.getStatusCode());
                return Collections.emptyList();
            }
        } catch(HttpClientErrorException | JsonProcessingException e) {
            logger.error("Error fetching or parsing loan data:", e);
            return Collections.emptyList();
        }
    }

    public String documentDataFormAPI(String personalId) {
        RestTemplate restTemplate = new RestTemplate();
        ObjectMapper objectMapper = new ObjectMapper();

        // KCB_CREDIT_URL에서 데이터 가져오기
        String kcbCreditResult = restTemplate.getForObject(KCB_CREDIT_URL + "?personalId=" + personalId, String.class);
        System.out.println("kcbCreditResult JSON: " + kcbCreditResult);
        // HOMTAX_URL에서 데이터 가져오기
        String homtaxResult = restTemplate.getForObject(HOMTAX_URL + "?personalId=" + personalId, String.class);
        System.out.println("homtaxResult JSON: " + homtaxResult);
        // 두 결과를 하나의 Map으로 병합하기
        Map<String, Object> combinedResult = new HashMap<>();

        try {
            combinedResult.put("kcbCredit", objectMapper.readValue(kcbCreditResult, Map.class));
            combinedResult.put("homtax", objectMapper.readValue(homtaxResult, new TypeReference<List<Map<String, Object>>>() {}));

        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        try {
            return objectMapper.writeValueAsString(combinedResult);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Loan> getAllInternalLoans(String personalId) {
        return loanDAO.getAllLoans(personalId);
    }
}
