package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.repository.LoanApplyRepository;
import kr.ac.kopo.final_hanaasset360.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.List;
@Service
public class LoanApplyServiceImpl implements LoanApplyService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private LoanApplyRepository loanApplyRepository;
    public List<LoanApply> getAllLoans() {
        String sql = "SELECT * FROM loan_switch";


        List<LoanApply> loanList = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(LoanApply.class));

        // System.out.println으로 반환된 데이터 확인
        System.out.println("Query Result: " + loanList);

        return loanList;
    }

    public LoanApplyDetail findLoanById(Long id) {
        return loanApplyRepository.findById(id).orElse(null);
    }

    public LoanExisting findLoanExistingById(Long loanId) {
        String sql = "SELECT lr.* \n" +
                "FROM loan_records lr \n" +
                "INNER JOIN loan_switch ls ON lr.loanRecordId = ls.loanRecordId \n" +
                "WHERE ls.id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{loanId}, new BeanPropertyRowMapper<>(LoanExisting.class));
    }

    public LoanExisting findAPILoanExistingById(Long loanId, String bank){
        String sql = "SELECT loanRecordId FROM loan_switch WHERE id = ?";
        Long loanRecordId = jdbcTemplate.queryForObject(sql, new Object[]{loanId}, Long.class);
        if (loanRecordId == null) {
            throw new RuntimeException("No matching loanRecordId found for loanId: " + loanId);
        }

        // 2. 외부 API로 요청하기
        String apiUrl = "http://16.171.189.30:8080/gwanjung/loan-existing";

        RestTemplate restTemplate = new RestTemplate();

        // loanRecordId와 bank를 파라미터로 추가
        String fullUrl = apiUrl + "?loanRecordId=" + loanRecordId + "&bank=" + bank;

        LoanExisting result = restTemplate.getForObject(fullUrl, LoanExisting.class);

        return result;
    }


    public ApplyUserVO findUserById(String userId) {
        String sql = "SELECT * FROM users WHERE userId = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{userId}, new BeanPropertyRowMapper<>(ApplyUserVO.class));
    }

    public UserCreditState findCreditById(String userId) {
        String sql = "SELECT * FROM USER_CREDIT WHERE userId = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{userId}, new BeanPropertyRowMapper<>(UserCreditState.class));
    }
}
