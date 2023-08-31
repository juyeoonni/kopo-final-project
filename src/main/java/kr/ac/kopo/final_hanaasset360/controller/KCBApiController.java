package kr.ac.kopo.final_hanaasset360.controller;

import kr.ac.kopo.final_hanaasset360.message.KcbRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;

@RestController
@RequestMapping("/api")
public class KCBApiController {

    @PostMapping("/credit-data")
    public ResponseEntity<String> forwardRequest(@RequestBody UserCredential userCredential) {
        RestTemplate restTemplate = new RestTemplate();

        // HttpHeaders 객체 생성
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        // HttpEntity 객체 생성
        HttpEntity<UserCredential> entity = new HttpEntity<>(userCredential, headers);

        // 외부 API로 요청을 전송
        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    "http://16.171.189.30:8080/gwanjung/kcb-credit",
                    HttpMethod.POST,
                    entity,
                    String.class
            );

            // 응답을 클라이언트에게 전달
            return new ResponseEntity<>(response.getBody(), HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Internal Server Error", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public static class UserCredential {
        private String username;
        private String password;

        // Getters and Setters


        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }
}