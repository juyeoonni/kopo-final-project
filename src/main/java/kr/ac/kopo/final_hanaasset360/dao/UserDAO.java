package kr.ac.kopo.final_hanaasset360.dao;

import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {

    // Assume you have a JdbcTemplate or EntityManager for database operations
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public UserVO findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE USERID = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{username}, new BeanPropertyRowMapper<>(UserVO.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
}
