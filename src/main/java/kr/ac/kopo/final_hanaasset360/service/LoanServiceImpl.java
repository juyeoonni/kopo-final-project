package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.dao.LoanApplyDAO;
import kr.ac.kopo.final_hanaasset360.dao.LoanDAO;
import kr.ac.kopo.final_hanaasset360.message.LoanBalanceResponse;
import kr.ac.kopo.final_hanaasset360.message.LoanStepRequest;
import kr.ac.kopo.final_hanaasset360.repository.LoanRecordsRepository;
import kr.ac.kopo.final_hanaasset360.repository.LoanRepository;
import kr.ac.kopo.final_hanaasset360.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.*;

@Service
public class LoanServiceImpl implements LoanService {

    @Autowired
    private LoanDAO loanDAO;
    @Autowired
    private LoanApplyDAO loanApplyDao;

    @Autowired
    private LoanRepository loanRepository;

    public List<LoanProductVO> findMatchingLoanProducts(double interest, double balance, int creditScore) {
        int creditGrade = convertScoreToGrade(creditScore);
        List<LoanProductVO> loanProducts = loanDAO.getAllLoanProducts(interest, balance, creditGrade);

        return loanProducts;
    }

    public List<LoanProductVO> getLoanProducts(String sort) {
        List<LoanProductVO> products = loanDAO.fetchLoanProducts();

        if ("avgIntRate".equals(sort)) {
            Collections.sort(products, Comparator.comparing(LoanProductVO::getAvgIntRate));
        } else if ("loanLimAmt".equals(sort)) {
            Collections.sort(products, Comparator.comparing(LoanProductVO::getLoanLimAmt).reversed());
        }

        return products;
    }

    @Transactional
    public void switchLoan(Long loanSwitchDataId , String loanExistingFinacne, String userId, Long balance, double overdue, String repaymentAccount, Long loanExistingId) throws UnsupportedEncodingException {
        System.out.println("balance: " + balance + "overdue: " + overdue + " repaymentAccount: " + repaymentAccount + " loanExistingId: " + loanExistingId);

        int fee = calculateEarlyRepaymentFee(balance, overdue);
        System.out.println("loanSwitchDataId: " + loanSwitchDataId);
        LoanApply loanSwitchData = loanApplyDao.findById(loanSwitchDataId);
        // 기존 대출 데이터 삭제
        System.out.println(loanExistingFinacne);
        // 기존 대출일 경우 하나은행 DB에서 삭제
        if(loanExistingFinacne.equals("하나은행")){
            LoanExisting loanExisting = loanApplyDao.findByLoanRecordId(loanSwitchData.getLoanRecordId());;
            loanApplyDao.delete(loanExisting, loanExistingFinacne);
        } else{
            // 하나은행이 아닐경우 API를 통해 삭제
            String url = "http://16.171.189.30:8080/gwanjung/loan-existing?loanRecordId=" + loanSwitchData.getLoanRecordId() + "&finance=" + loanExistingFinacne;
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.delete(url);
        }

        System.out.println("2");
        // 기존 상환 계좌에서 중도상환수수료 상환
        if(loanExistingFinacne.equals("하나은행")){
            loanApplyDao.overdue(userId, balance, fee, repaymentAccount, loanExistingId);
        } else{
            String url = "http://16.171.189.30:8080/gwanjung/overdue";

            // 파라미터 설정
            Map<String, Object> params = new HashMap<>();
            params.put("fee", fee);
            params.put("repaymentAccount", repaymentAccount);
            params.put("finance", loanExistingFinacne);

            // Convert map to query parameters
            StringBuilder queryParameters = new StringBuilder("?");
            for (Map.Entry<String, Object> entry : params.entrySet()) {
                if (queryParameters.length() > 1) {
                    queryParameters.append("&");
                }
                queryParameters.append(URLEncoder.encode(entry.getKey(), "UTF-8")).append("=").append(URLEncoder.encode(String.valueOf(entry.getValue()), "UTF-8"));
            }

            url += queryParameters.toString();

            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

// Since RestTemplate does not support sending a PUT request with a body of type 'void', we're sending an empty HttpEntity
            HttpEntity<String> entity = new HttpEntity<>("", headers);

            try {
                URI uri = new URI(url);
                restTemplate.exchange(uri, HttpMethod.PUT, entity, Void.class);  // Send PUT request with empty body and query parameters
            } catch (URISyntaxException e) {
                e.printStackTrace();
            } catch (RestClientException e) {
                e.printStackTrace();
            }
        }
        // 새로운 대출 데이터 추가
        LoanApply loanApply = loanApplyDao.findById(loanSwitchDataId);
        LoanExisting newLoanExisting = new LoanExisting();
        newLoanExisting.setLoanRecordId(loanExistingId);
        newLoanExisting.setUserId(userId);
        newLoanExisting.setLoanAmount(loanApply.getNewLoanAmount());
        newLoanExisting.setInterestRate(loanApply.getNewLoanInterest());
        newLoanExisting.setLoanStartDate(loanApply.getNewLoanStartDate());
        newLoanExisting.setLoanEndDate(loanApply.getNewLoanEndDate());
        newLoanExisting.setOverdueStatus('Y');
        newLoanExisting.setRepaymentAccount(loanApply.getNewLoanAccount());
        newLoanExisting.setFinance(loanApply.getNewLoanFinance());
        newLoanExisting.setOverdue(loanApply.getNewLoanOverdue());
        newLoanExisting.setRepayment(loanApply.getNewLoanInRepayment());
        newLoanExisting.setLoanBalance(loanApply.getNewLoanAmount());
        newLoanExisting.setLoanProductId(loanApply.getNewLoanName());
        newLoanExisting.setRepaymentDate(loanApply.getNewLoanInterestDate());
        loanApplyDao.insert(newLoanExisting);
        // 심사완료로 최종 마무리
        loanApplyDao.update(loanSwitchDataId);
    }


    @Transactional
    public void insertData(LoanStepRequest loanRequest) {
        loanDAO.saveLoanRequest(loanRequest);
    }

    @Override
    public Long sumLoansByUserId(String userId, Long personalId) {
        Long localBalance = loanRepository.sumLoansByUserId(userId);
        Long externalBalance = getExternalLoanBalance(userId, personalId);
        return localBalance + externalBalance;
    }



    public List<LoanDetail> getRepaymentsByUserId(String userId) {
        return loanRepository.findByUserIdOrderByRepaymentDateAsc(userId);
    }

    public List<LoanDetail> findByUserId(String userId) {
        return loanRepository.findByUserId(userId);
    }

    public Long getExternalLoanBalance(String userId, Long personalId) {
        RestTemplate restTemplate = new RestTemplate();
        String externalBankUrl = "http://16.171.189.30:8080/gwanjung/loan-records?personalId=" + personalId;
        try {
            LoanBalanceResponse response = restTemplate.getForObject(externalBankUrl, LoanBalanceResponse.class);
            return (response != null && response.getLoanBalance() != null) ? response.getLoanBalance() : 0L;
        } catch (Exception e) {
            // API 호출 시 예외 처리
            e.printStackTrace();
            return 0L;
        }
    }

    @Override
    public List<LoanRecords> getOtherLoansByPersonalId(Long personalId) {
        RestTemplate restTemplate = new RestTemplate();

        List<String> banks = Arrays.asList("우리은행", "신한은행", "국민은행");

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl("http://16.171.189.30:8080/gwanjung/loan-response")
                .queryParam("personalIdNumber", personalId);

        for (String bank : banks) {
            uriBuilder.queryParam("banks", bank);
        }

        URI uri = uriBuilder.build().encode().toUri();

        LoanRecords[] loanArray = restTemplate.getForObject(uri, LoanRecords[].class);

        return Arrays.asList(loanArray);
    }

    private int convertScoreToGrade(int score) {
        if (score >= 942 && score <= 1000) return 1;
        if (score >= 891 && score <= 941) return 2;
        if (score >= 832 && score <= 890) return 3;
        if (score >= 768 && score <= 831) return 4;
        if (score >= 698 && score <= 767) return 5;
        if (score >= 630 && score <= 697) return 6;
        if (score >= 530 && score <= 629) return 7;
        if (score >= 454 && score <= 529) return 8;
        if (score >= 335 && score <= 453) return 9;
        if (score >= 0 && score <= 334) return 10;
        return -1; // 잘못된 점수
    }
    public static int calculateEarlyRepaymentFee(Long balance, double overdue) {
        return (int) (balance * overdue / 100);
    }


}
