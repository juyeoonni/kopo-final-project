package kr.ac.kopo.final_hanaasset360.account.service;

import com.google.gson.Gson;
import kr.ac.kopo.final_hanaasset360.message.OtherTransactionResponse;
import kr.ac.kopo.final_hanaasset360.account.repository.AccountTransactionRepository;
import kr.ac.kopo.final_hanaasset360.retirement.repository.SavingTransactionRepository;
import kr.ac.kopo.final_hanaasset360.account.vo.AccountTransactionVO;
import kr.ac.kopo.final_hanaasset360.retirement.vo.SavingTransactionVO;
import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Service
public class AccountTransactionServiceImpl implements AccountTransactionService{

    @Autowired
    private AccountTransactionRepository accountTransactionRepository;

    @Autowired
    private SavingTransactionRepository savingTransactionRepository;
    @Override
    public List<AccountTransactionVO> getTransactionsByAccountId(String accountId) {
        return accountTransactionRepository.findByAccountid(accountId);
    }


    @Override
    public List<SavingTransactionVO> getSavingTransactionsByAccountId(String accountId) {
        return savingTransactionRepository.findByAccountId(accountId);
    }

    /**
     * @param accountId
     * @param financialCode
     * @return
     */
    @Override
    public List<OtherTransactionResponse> getOtherTransactionsByAccountId(String accountId, String financialCode) {
        OkHttpClient client = new OkHttpClient();

        String url = "http://16.171.189.30:8080/gwanjung/other-transaction";

        HttpUrl.Builder urlBuilder = HttpUrl.parse(url).newBuilder();
        urlBuilder.addQueryParameter("accountId", accountId);
        urlBuilder.addQueryParameter("financialCode", financialCode);

        Request request = new Request.Builder()
                .url(urlBuilder.build())
                .build();

        try {
            Response response = client.newCall(request).execute();
            if (response.isSuccessful()) {
                String responseBody = response.body().string();
                System.out.println("Response: " + responseBody);

                Gson gson = new Gson();
                OtherTransactionResponse[] transactions = gson.fromJson(responseBody, OtherTransactionResponse[].class);
                return Arrays.asList(transactions);
            } else {
                System.out.println("Unexpected response: " + response);
                return Collections.emptyList();
            }
        } catch (IOException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
}
