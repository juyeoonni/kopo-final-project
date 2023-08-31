package kr.ac.kopo.final_hanaasset360.dao;

import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class LoanDAOImpl implements LoanDAO {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public List<LoanProductVO> getAllLoanProducts(double interest, double balance, int creditGrade) {
        String sql = "SELECT * FROM ( " +
                "SELECT fnst_dv_val, loan_lim_amt, loan_pdct_nm, early_repay_fee, " +
                "CASE " +
                "WHEN ? = 1 THEN credit_grade_1 " +
                "WHEN ? = 2 THEN credit_grade_2 " +
                "WHEN ? = 3 THEN credit_grade_3 " +
                "WHEN ? = 4 THEN credit_grade_4 " +
                "WHEN ? = 5 THEN credit_grade_5 " +
                "WHEN ? = 6 THEN credit_grade_6 " +
                "WHEN ? = 7 THEN credit_grade_7 " +
                "WHEN ? = 8 THEN credit_grade_8 " +
                "WHEN ? = 9 THEN credit_grade_9 " +
                "WHEN ? = 10 THEN credit_grade_10 " +
                "END AS selected_credit_grade " +
                "FROM loan_products " +
                "WHERE loan_lim_amt > ? AND " +
                "CASE " +
                "WHEN ? = 1 THEN credit_grade_1 " +
                "WHEN ? = 2 THEN credit_grade_2 " +
                "WHEN ? = 3 THEN credit_grade_3 " +
                "WHEN ? = 4 THEN credit_grade_4 " +
                "WHEN ? = 5 THEN credit_grade_5 " +
                "WHEN ? = 6 THEN credit_grade_6 " +
                "WHEN ? = 7 THEN credit_grade_7 " +
                "WHEN ? = 8 THEN credit_grade_8 " +
                "WHEN ? = 9 THEN credit_grade_9 " +
                "WHEN ? = 10 THEN credit_grade_10 " +
                "END < ? " +
                "ORDER BY " +
                "CASE " +
                "WHEN ? = 1 THEN credit_grade_1 " +
                "WHEN ? = 2 THEN credit_grade_2 " +
                "WHEN ? = 3 THEN credit_grade_3 " +
                "WHEN ? = 4 THEN credit_grade_4 " +
                "WHEN ? = 5 THEN credit_grade_5 " +
                "WHEN ? = 6 THEN credit_grade_6 " +
                "WHEN ? = 7 THEN credit_grade_7 " +
                "WHEN ? = 8 THEN credit_grade_8 " +
                "WHEN ? = 9 THEN credit_grade_9 " +
                "WHEN ? = 10 THEN credit_grade_10 " +
                "END ASC) " +
                "WHERE ROWNUM <= 5";

        Object[] params = new Object[]{
                creditGrade, creditGrade, creditGrade, creditGrade, creditGrade,
                creditGrade, creditGrade, creditGrade, creditGrade, creditGrade,
                balance,
                creditGrade, creditGrade, creditGrade, creditGrade, creditGrade,
                creditGrade, creditGrade, creditGrade, creditGrade, creditGrade,
                interest,
                creditGrade, creditGrade, creditGrade, creditGrade, creditGrade,
                creditGrade, creditGrade, creditGrade, creditGrade, creditGrade
        };

        return jdbcTemplate.query(sql, params, new RowMapper<LoanProductVO>() {
            @Override
            public LoanProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                LoanProductVO loanProduct = new LoanProductVO();
                loanProduct.setFnstDvVal(rs.getString("fnst_dv_val"));
                loanProduct.setLoanLimAmt(rs.getDouble("loan_lim_amt"));
                loanProduct.setLoanPdctNm(rs.getString("loan_pdct_nm"));
                loanProduct.setEarlyRepayFee(rs.getDouble("early_repay_fee"));
                loanProduct.setSelectedCreditGrade(rs.getDouble("selected_credit_grade"));
                return loanProduct;
            }
        });
    }
}