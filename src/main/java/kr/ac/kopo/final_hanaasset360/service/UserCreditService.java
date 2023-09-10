package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.repository.UserCreditRepository;
import kr.ac.kopo.final_hanaasset360.vo.UserCredit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserCreditService {
    private final UserCreditRepository userCreditRepository;

    @Autowired
    public UserCreditService(UserCreditRepository userCreditRepository) {
        this.userCreditRepository = userCreditRepository;
    }

    public void saveUserCredit(UserCredit userCredit) {
        userCreditRepository.save(userCredit);
    }
}
