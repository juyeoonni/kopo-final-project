package kr.ac.kopo.final_hanaasset360.api.service;

import kr.ac.kopo.final_hanaasset360.api.vo.UserCredentialVO;
import kr.ac.kopo.final_hanaasset360.api.vo.UserCredit;
import org.springframework.http.ResponseEntity;

public interface UserCreditService {
    void saveUserCredit(UserCredit userCredit);

    ResponseEntity<String> sendKCBRequest(UserCredentialVO userCredential);
}
