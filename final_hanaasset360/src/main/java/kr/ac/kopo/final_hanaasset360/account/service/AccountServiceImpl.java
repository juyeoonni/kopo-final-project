package kr.ac.kopo.final_hanaasset360.account.service;

import kr.ac.kopo.final_hanaasset360.account.repository.AccountRepository;
import kr.ac.kopo.final_hanaasset360.account.vo.Accounts;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Arrays;
import java.util.List;

@Service
public class AccountServiceImpl implements  AccountService{
    private final AccountRepository accountRepository;

    public AccountServiceImpl(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    @Override
    public List<Accounts> getOtherAccountsByPersonalId(Long personalId) {
        RestTemplate restTemplate = new RestTemplate();
        String apiUrl = "http://16.171.189.30:8080/gwanjung/other-accounts";

        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(apiUrl)
                .queryParam("personalId", personalId);

        return Arrays.asList(restTemplate.getForObject(builder.toUriString(), Accounts[].class));
    }

    public List<Accounts> getAccountsByUserId(String userId) {
        return accountRepository.findByUserId(userId);
    }
}
