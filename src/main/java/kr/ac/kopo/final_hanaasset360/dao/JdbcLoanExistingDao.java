package kr.ac.kopo.final_hanaasset360.dao;



import kr.ac.kopo.final_hanaasset360.vo.LoanExisting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class JdbcLoanExistingDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public LoanExisting findByLoanRecordId(Long loanRecordId) {
        String sql = "SELECT * FROM loan_records WHERE loanRecordId = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(LoanExisting.class), loanRecordId);
    }

    public void delete(LoanExisting loanExisting) {
        String sql = "DELETE FROM loan_records WHERE loanRecordId = ?";
        jdbcTemplate.update(sql, loanExisting.getLoanRecordId());
    }

    public void insert(LoanExisting loanExisting) {
        // SQL 쿼리와 파라미터 셋팅 필요
        // 예제: jdbcTemplate.update("INSERT INTO ...", ...);
    }
}
