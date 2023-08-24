package kr.ac.kopo.final_hanaasset360.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

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
}
