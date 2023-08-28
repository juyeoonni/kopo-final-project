package kr.ac.kopo.final_hanaasset360.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.List;

@Service
public class ApiService {

    private static final Logger logger = LoggerFactory.getLogger(ApiService.class);

    private final RestTemplate restTemplate;

    public ApiService() {
        this.restTemplate = new RestTemplate();
    }

    public String fetchDataFromAPI() {
        String apiUrl = "http://16.171.189.30:8080/gwanjung/username-response?accountNumber=003-4769-4402";

        ResponseEntity<String> response = restTemplate.getForEntity(apiUrl, String.class);

        if (response.getStatusCode().is2xxSuccessful()) {
            logger.info("Received Response: {}", response.getBody());  // 이 부분에서 로그로 응답 값을 출력합니다.
            return response.getBody();
        } else {
            logger.error("Failed to fetch data. Status code: {}", response.getStatusCode()); // 에러 발생 시 로그 출력
            return null;
        }
    }

    public String tranferInfoFromAPI() {
        String apiUrl = "http://16.171.189.30:8080/gwanjung/accounts-transfer-response?accountNumber=003-2922-1881";
        ResponseEntity<String> response = restTemplate.getForEntity(apiUrl, String.class);

        if (response.getStatusCode().is2xxSuccessful()) {
            logger.info("Received Response: {}", response.getBody());  // 이 부분에서 로그로 응답 값을 출력합니다.
            return response.getBody();
        } else {
            logger.error("Failed to fetch data. Status code: {}", response.getStatusCode()); // 에러 발생 시 로그 출력
            return null;
        }

    }

    public String loanDataFormAPI(String personalId, List<String> banks) {
        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl("http://16.171.189.30:8080/gwanjung/loan-response")
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

}
