package kr.ac.kopo.final_hanaasset360.dao;


import kr.ac.kopo.final_hanaasset360.vo.LoanApply;
import kr.ac.kopo.final_hanaasset360.vo.LoanExisting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LoanApplyDAOImpl implements LoanApplyDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public LoanApply findById(Long id) {
        // 이후 해당 ID를 가진 데이터를 조회
        String sql = "SELECT * FROM loan_switch WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(LoanApply.class), id);
    }

    public void update(Long id) {
        // 우선 해당 ID를 가진 데이터의 NEW_LOAN_STATUS를 '심사완료'로 업데이트
        String updateSql = "UPDATE loan_switch SET NEW_LOAN_STATUS = '심사완료' WHERE id = ?";
        jdbcTemplate.update(updateSql, id);

    }
        public LoanExisting findByLoanRecordId(Long loanRecordId) {
            String sql = "SELECT * FROM loan_records WHERE loanRecordId = ?";
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(LoanExisting.class), loanRecordId);
        }

        /**
         *
         */

        public void delete(LoanExisting loanExisting, String loanExistingFinacne) {

            String sql = "DELETE FROM loan_records WHERE loanRecordId = ?";
            jdbcTemplate.update(sql, loanExisting.getLoanRecordId());
        }



        /*
        *  insert 부분 구현
        * */
        public void insert(LoanExisting loanExisting) {
            String sql = "INSERT INTO loan_records (" +
                    "LOANRECORDID, USERID, LOANAMOUNT, INTERESTRATE, LOANSTARTDATE, LOANENDDATE, " +
                    "OVERDUESTATUS, REPAYMENT_ACCOUNT, FINANCE, OVERDUE, LOANREPAYMENT, LOANBALANCE, " +
                    "LOANPRODUCTID" +
                    ") VALUES (loan_records_seq.NEXTVAL, ?, ?, ?, sysdate, ADD_MONTHS(sysdate, 60), ?, ?, ?, ?, ?, ?, ?)";

            jdbcTemplate.update(sql,

                    loanExisting.getUserId(),
                    loanExisting.getLoanAmount(),
                    loanExisting.getInterestRate(),
                    loanExisting.getOverdueStatus(),
                    loanExisting.getRepaymentAccount(),
                    loanExisting.getFinance(),
                    loanExisting.getOverdue(),
                    loanExisting.getLoanRepayment(),
                    loanExisting.getLoanBalance(),
                    loanExisting.getLoanProductId()
            );
        }


}

