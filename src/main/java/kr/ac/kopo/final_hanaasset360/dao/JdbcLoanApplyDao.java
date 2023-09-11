package kr.ac.kopo.final_hanaasset360.dao;


import kr.ac.kopo.final_hanaasset360.vo.LoanApply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class JdbcLoanApplyDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public LoanApply findById(Long id) {
        System.out.println("id" + id);
        String sql = "SELECT * FROM loan_switch WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(LoanApply.class), id);
    }
}

