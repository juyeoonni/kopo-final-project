package kr.ac.kopo.final_hanaasset360.api.service;

import kr.ac.kopo.final_hanaasset360.api.repository.UserCreditRepository;
import kr.ac.kopo.final_hanaasset360.api.vo.UserCredentialVO;
import kr.ac.kopo.final_hanaasset360.api.vo.UserCredit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;

@Service
public class UserCreditServiceImpl implements UserCreditService {
    private final UserCreditRepository userCreditRepository;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    public UserCreditServiceImpl(UserCreditRepository userCreditRepository) {
        this.userCreditRepository = userCreditRepository;
    }

    public void saveUserCredit(UserCredit userCredit) {
        userCreditRepository.save(userCredit);
    }



    @Override
    public ResponseEntity<String> sendKCBRequest(UserCredentialVO userCredential) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        HttpEntity<UserCredentialVO> entity = new HttpEntity<>(userCredential, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    "http://16.171.189.30:8080/kcb-credit",
                    HttpMethod.POST,
                    entity,
                    String.class
            );

            return new ResponseEntity<>(response.getBody(), HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Internal Server Error", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
