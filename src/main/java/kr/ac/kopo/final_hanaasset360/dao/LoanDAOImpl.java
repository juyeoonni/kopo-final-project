package kr.ac.kopo.final_hanaasset360.dao;

import kr.ac.kopo.final_hanaasset360.message.LoanStepRequest;
import kr.ac.kopo.final_hanaasset360.vo.Loan;
import kr.ac.kopo.final_hanaasset360.vo.LoanProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class LoanDAOImpl implements LoanDAO {

    @Autowired
    JdbcTemplate jdbcTemplate;

    private static final String SELECT_SQL = "SELECT id ,fnst_dv_val, loan_lim_amt, loan_pdct_nm, early_repay_fee, credit_grade_5 from loan_products";

    public List<LoanProductVO> fetchLoanProducts() {
        return jdbcTemplate.query(SELECT_SQL, new RowMapper<LoanProductVO>() {
            public LoanProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                LoanProductVO loanProduct = new LoanProductVO();
                loanProduct.setId(rs.getInt("id"));
                loanProduct.setFnstDvVal(rs.getString("fnst_dv_val"));
                loanProduct.setLoanLimAmt(rs.getInt("loan_lim_amt"));
                loanProduct.setAvgIntRate(rs.getDouble("credit_grade_5"));
                loanProduct.setLoanPdctNm(rs.getString("loan_pdct_nm"));
                loanProduct.setEarlyRepayFee(rs.getDouble("early_repay_fee"));
                return loanProduct;
            }
        });
    }

    @Override
    public void saveLoanRequest(LoanStepRequest loanRequest) {
        String sql = "INSERT INTO loan_switch(" +
                "ID, LoanRecordID, NEW_LOAN_FINANCE, NEW_LOAN_NAME, NEW_LOAN_AMOUNT, " +
                "NEW_LOAN_INTEREST, NEW_LOAN_OVERDUE, NEW_LOAN_PERIOD, NEW_LOAN_START_DATE, " +
                "NEW_LOAN_END_DATE, NEW_LOAN_INTEREST_DATE, NEW_LOAN_IN_REPAYMENT, " +
                "NEW_LOAN_STATUS, NEW_LOAN_ACCOUNT, APPLICATION_DATE, BANKERID, EXISTINGFINANCE) " +
                "VALUES(LOANSWITCH_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, ?, ?)";

        jdbcTemplate.update(sql,
                loanRequest.getId(),
                loanRequest.getFnstDvVal(),
                loanRequest.getLoanPdctNm(),
                loanRequest.getLoanLimAmt(),
                loanRequest.getSelectedCreditGrade(),
                loanRequest.getEarlyRepayFee(),
                loanRequest.getLoanTerm(),
                Date.valueOf("2020-01-01"),  // DATE 타입으로 변환
                Date.valueOf("2023-01-01"),  // DATE 타입으로 변환
                loanRequest.getInterestPaydate().toString(),  // 문자열로 변환 (데이터베이스와 타입이 일치하게)
                loanRequest.getLoanPayType(),
                "대기",
                loanRequest.getRepaymentAccount(),
                1,
                loanRequest.getBank()
        );
    }

    @Override
    public List<Loan> getAllLoans(String personalId) {
        String sql = "SELECT lr.* " +
                "FROM loan_records lr " +
                "JOIN users u ON lr.userid = u.userid " +
                "WHERE u.personalId = ?";

        return jdbcTemplate.query(sql, new Object[]{personalId}, (resultSet, rowNum) ->
                new Loan(
                        resultSet.getInt("LoanRecordID"),
                        resultSet.getString("LoanProductID"),  // 필요에 따라 이 필드를 Loan 클래스에 추가해야 합니다.
                        resultSet.getString("finance"),
                        resultSet.getDouble("InterestRate"),
                        resultSet.getInt("LoanAmount"),
                        resultSet.getInt("LoanBalance"),
                        resultSet.getString("LoanEndDate"),
                        resultSet.getDouble("overdue"),
                        resultSet.getString("repayment"),
                        resultSet.getString("LoanStartDate"),
                        resultSet.getInt("repaymentDate")
                )
        );
    }


    @Override
    public List<LoanProductVO> getAllLoanProducts(double interest, double balance, int creditGrade) {
        String sql = "SELECT * FROM ( " +
                "SELECT id, fnst_dv_val, loan_lim_amt, loan_pdct_nm, early_repay_fee, " +
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
                "WHERE FNST_DV_VAL LIKE '하나%' AND  selected_credit_grade <> 0 AND ROWNUM <= 5";

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
                loanProduct.setId(rs.getInt("id"));
                loanProduct.setFnstDvVal(rs.getString("fnst_dv_val"));
                loanProduct.setLoanLimAmt(rs.getInt("loan_lim_amt"));
                loanProduct.setLoanPdctNm(rs.getString("loan_pdct_nm"));
                loanProduct.setEarlyRepayFee(rs.getDouble("early_repay_fee"));
                loanProduct.setSelectedCreditGrade(rs.getDouble("selected_credit_grade"));
                return loanProduct;
            }
        });
    }
}