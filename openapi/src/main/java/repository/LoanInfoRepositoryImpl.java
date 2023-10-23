package repository;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import vo.AccountInfoDTO;
import vo.LoanDTO;
import vo.LoanExisting;
import vo.OtherAccountDTO;

public class LoanInfoRepositoryImpl implements LoanInfoRepository {
    private static LoanInfoRepositoryImpl instance = null;

    private final String DB_URL =
            "jdbc:oracle:thin:@openapi_high?TNS_ADMIN=/opt/wallet/Wallet_DinkDB";
    private final String USER = "admin";
    private final String PASS = "Rhkswnd2846!";
    
    public LoanInfoRepositoryImpl(){
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static LoanInfoRepositoryImpl getInstance() {
        if (instance == null) {
            synchronized (LoanInfoRepositoryImpl.class) {
                if (instance == null) {
                    instance = new LoanInfoRepositoryImpl();
                }
            }
        }
        return instance;
    }
    
    @Override
    public List<LoanDTO> findLoanDataByMemberId(String userId, List<String> banks) {
        // TODO Auto-generated method stub
        List<LoanDTO> loanInfos = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM loanhistory WHERE userid = ?");
        
        // If banks are specified, add them to the query
        if (banks != null && !banks.isEmpty()) {
            query.append(" AND FINANCE IN (");
            for (int i = 0; i < banks.size(); i++) {
                query.append("?");
                if (i < banks.size() - 1) {
                    query.append(",");
                }
            }
            query.append(")");
        }
        
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                PreparedStatement ps = conn.prepareStatement(query.toString())) {
               ps.setString(1, userId);
               if (banks != null && !banks.isEmpty()) {
                   for (int i = 0; i < banks.size(); i++) {
                       ps.setString(i + 2, banks.get(i));  // Start with index 2, because 1 is already set
                   }
               }
               ResultSet rs = ps.executeQuery();
               while (rs.next()) {
                   LoanDTO loanInfo = new LoanDTO();

                   loanInfo.setLoanRecordID(rs.getLong("LOANRECORDID"));
                   loanInfo.setLoanProductID(rs.getString("LOANPRODUCTID"));
                   loanInfo.setUserID(rs.getString("USERID"));
                   loanInfo.setLoanAmount(rs.getLong("LOANAMOUNT"));
                   loanInfo.setLoanBalance(rs.getLong("LOANBALANCE"));
                   loanInfo.setInterestRate(rs.getDouble("INTERESTRATE"));
                   loanInfo.setLoanStartDate(rs.getString("LOANSTARTDATE"));
                   loanInfo.setLoanEndDate(rs.getString("LOANENDDATE"));
                   loanInfo.setOverdueStatus(rs.getString("OVERDUESTATUS").charAt(0));
                   loanInfo.setRepaymentAccount(rs.getString("REPAYMENT_ACCOUNT"));
                   loanInfo.setFinance(rs.getString("FINANCE"));
                   loanInfo.setOverdue(rs.getDouble("OVERDUE"));
                   loanInfo.setRepayment(rs.getString("REPAYMENT"));
                   loanInfo.setRepaymentDate(rs.getLong("REPAYMENTDATE"));
                   loanInfos.add(loanInfo);
               }
           } catch (SQLException e) {
               e.printStackTrace();
           }

        return loanInfos;
       
    }
    
    public List<LoanDTO> findMemberIdAndLoanHistoryByPersonalIdNumber(String personalIdNumber, List<String> banks) {
        List<LoanDTO> loanHistoryResults = new ArrayList<>();

        for (String bank : banks) {
            String userTableName = getUserTableNameByBankName(bank);
            String loanTableName = getLoanTableNameByBankName(bank);

            String findUserIdQuery = "SELECT USERID FROM " + userTableName + " WHERE personalid = ?";
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(findUserIdQuery)) {

                ps.setString(1, personalIdNumber);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String userId = rs.getString("USERID");

                    // Use the userID to fetch loan history
                    String findLoanHistoryQuery = "SELECT * FROM " + loanTableName + " WHERE userid = ?";
                    try (PreparedStatement psLoan = conn.prepareStatement(findLoanHistoryQuery)) {
                        psLoan.setString(1, userId);
                        ResultSet rsLoan = psLoan.executeQuery();

                        while (rsLoan.next()) {
                            LoanDTO loan = new LoanDTO(); 
                            loan.setLoanRecordID(rsLoan.getLong("LOANRECORDID"));
                            loan.setLoanProductID(rsLoan.getString("LOANPRODUCTID"));
                            loan.setUserID(rsLoan.getString("USERID"));
                            loan.setLoanBalance(rsLoan.getLong("LOANBALANCE"));
                            loan.setLoanAmount(rsLoan.getLong("LOANAMOUNT"));
                            loan.setInterestRate(rsLoan.getDouble("INTERESTRATE"));
                            loan.setLoanStartDate(rsLoan.getString("LOANSTARTDATE"));
                            loan.setLoanEndDate(rsLoan.getString("LOANENDDATE"));
                            loan.setOverdueStatus(rsLoan.getString("OVERDUESTATUS").charAt(0));
                            loan.setRepaymentAccount(rsLoan.getString("REPAYMENT_ACCOUNT"));
                            loan.setFinance(rsLoan.getString("FINANCE"));
                            loan.setOverdue(rsLoan.getDouble("OVERDUE"));
                            loan.setRepayment(rsLoan.getString("REPAYMENT"));
                            loan.setRepaymentDate(rsLoan.getLong("REPAYMENTDATE"));
                            loanHistoryResults.add(loan);
                        }
                    }
                }
            } catch (SQLException e) {
                System.out.println("Error while retrieving data");
                e.printStackTrace();
            }
        }

        return loanHistoryResults;
    }
    
    
    public String getUserTableNameByBankName(String bank) {
        switch (bank) {
            case "하나은행":
                return "hana_users";
            case "우리은행":
                return "woori_users";
            case "신한은행":
                return "shinhan_users";
            case "국민은행":
                return "kb_users";
            default:
                return ""; // Or throw an exception
        }
    }

    public String getLoanTableNameByBankName(String bank) {
        switch (bank) {
            case "우리은행":
                return "woori_loan_records";
            case "신한은행":
                return "shinhan_loan_records";
            case "국민은행":
                return "kb_loan_records";
            default:
                return ""; // Or throw an exception
        }
    }
    
    public String getAccountTableNameByBankName(String bank) {
        switch (bank) {
            case "우리은행":
                return "woori_accounts";
            case "신한은행":
                return "shinhan_accounts";
            case "국민은행":
                return "kb_accounts";
            default:
                return ""; // Or throw an exception
        }
    }

    @Override
    public void deleteByRecordIdAndFinance(Long loanRecordId, String finance) {
        String tableName = getLoanTableNameByBankName(finance);

        if (tableName.isEmpty()) {
            // TODO: 예외 처리 또는 오류 메시지 출력
            return;
        }

        String query = "DELETE FROM " + tableName + " WHERE loanRecordId = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             
            preparedStatement.setLong(1, loanRecordId);

            preparedStatement.executeUpdate();
        } catch (Exception e) {
            // TODO: 예외 처리
            e.printStackTrace();
        }
    }

    @Override
    public LoanExisting fetchLoanExisting(String loanRecordId, String bank) {
        // TODO Auto-generated method stub
        LoanExisting loanExisting = null;

        try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASS)) {
            String tableName = getLoanTableNameByBankName(bank);
            String query = "SELECT * FROM " + tableName + " WHERE loanRecordId = ?";
            
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, loanRecordId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                loanExisting = new LoanExisting();
                loanExisting.setLoanRecordId(rs.getLong("LOANRECORDID"));
                loanExisting.setUserId(rs.getString("USERID"));
                loanExisting.setLoanAmount(rs.getLong("LOANAMOUNT"));
                loanExisting.setInterestRate(rs.getDouble("interestRate"));
                loanExisting.setLoanStartDate(rs.getString("loanStartDate"));
                loanExisting.setLoanEndDate(rs.getString("loanEndDate"));
                loanExisting.setOverdueStatus(rs.getString("overdueStatus").charAt(0)); 
                loanExisting.setRepaymentAccount(rs.getString("REPAYMENT_ACCOUNT"));
                loanExisting.setFinance(rs.getString("FINANCE"));
                loanExisting.setOverdue(rs.getDouble("OVERDUE"));
                loanExisting.setRepayment(rs.getString("REPAYMENT"));
                loanExisting.setLoanBalance(rs.getLong("LOANBALANCE"));
                loanExisting.setLoanProductId(rs.getString("LOANPRODUCTID"));
                loanExisting.setRepaymentDate(rs.getLong("REPAYMENTDATE"));
                // TODO: set loanExisting fields using rs getters (e.g., rs.getString("columnName"))
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loanExisting;
    }

    @Override
    public Long getLoanBalanceByPersonalId(String personalIdStr) {
        Long totalLoanBalance = 0L;

        // 사용자 테이블과 대출 기록 테이블 매핑
        Map<String, String> bankTables = new HashMap<>();
//        bankTables.put("hana_users", "hana_loan_records");
        bankTables.put("woori_users", "woori_loan_records");
//        bankTables.put("shinhan_users", "shinhan_loan_records");
//        bankTables.put("kb_users", "kb_loan_records");

        try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASS)) {
            for (Map.Entry<String, String> entry : bankTables.entrySet()) {
                String userTable = entry.getKey();
                String loanTable = entry.getValue();
                
                // personalIdStr로 userId 찾기
                String userId;
                try (PreparedStatement ps = connection.prepareStatement("SELECT userId FROM " + userTable + " WHERE personalId = ?")) {
                    ps.setString(1, personalIdStr);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            userId = rs.getString("userId");
                        } else {
                            continue; // 해당 테이블에 사용자가 없다면, 다음 테이블로 이동
                        }
                    }
                }

                // 해당 userId로 loanBalance 합산
                try (PreparedStatement ps = connection.prepareStatement("SELECT SUM(loanBalance) as userLoanBalance FROM " + loanTable + " WHERE userId = ?")) {
                    ps.setString(1, userId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            totalLoanBalance += rs.getLong("userLoanBalance");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 오류 처리
        }

        return totalLoanBalance;
    }

    @Override
    public void updateOverdueByFeeAndAccount(int fee, String repaymentAccount, String finance) {
        String tableName = getAccountTableNameByBankName(finance);
        
        String updateBalanceQuery = "UPDATE " + tableName + " SET accountbalance = accountbalance - ? WHERE accountid = ?";
        // TODO Auto-generated method stub
        try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);
                PreparedStatement updateStatement = connection.prepareStatement(updateBalanceQuery)) {
                
               updateStatement.setInt(1, fee);
               updateStatement.setString(2, repaymentAccount);  // Assuming repaymentAccount is directly the account_id
               updateStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // 오류 처리
        }
    }

    @Override
    public List<OtherAccountDTO> findByAccounts(String personalId) {
        List<OtherAccountDTO> results = new ArrayList<>();
        String[] banks = {"우리은행", "신한은행", "국민은행"};
        
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
                    
                    for (String bank : banks) {
                        String userTable = getUserTableNameByBankName(bank);
                        String accountTable = getAccountTableNameByBankName(bank);
        
                        // Query to find userId based on personalId
                        String userQuery = "SELECT userId FROM " + userTable + " WHERE personalId = ?";
                        try (PreparedStatement userStmt = conn.prepareStatement(userQuery)) {
                            userStmt.setString(1, personalId);
                            try (ResultSet rs = userStmt.executeQuery()) {
                                if (rs.next()) {
                                    String userId = rs.getString("userId");
                                    
                                    // Query to find account information based on userId
                                    String accountQuery = "SELECT * FROM " + accountTable + " WHERE userId = ?";
                                    try (PreparedStatement accountStmt = conn.prepareStatement(accountQuery)) {
                                        accountStmt.setString(1, userId);
                                        try (ResultSet accountRs = accountStmt.executeQuery()) {
                                            while (accountRs.next()) {
                                                OtherAccountDTO dto = new OtherAccountDTO();
                                                dto.setAccountId(accountRs.getString("ACCOUNTID"));
                                                dto.setUserId(accountRs.getString("USERID"));
                                                dto.setAccountType(accountRs.getString("ACCOUNTTYPE"));
                                                dto.setAccountBalance(accountRs.getLong("ACCOUNTBALANCE"));
                                                dto.setFinancialCode(accountRs.getString("FINANCIALCODE"));
                                                dto.setAccountName(accountRs.getString("ACCOUNTNAME"));
                                                results.add(dto);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                } catch (Exception e) {
                    e.printStackTrace(); // 로그나 예외 처리를 적절히 해야 함
                }
                
                return results;
            }
    
    @Override
    public String findUserIdByPersonalId(Long personalId) {
        String userId = null;
        String query = "SELECT userId FROM woori_users WHERE personalId = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             
            preparedStatement.setLong(1, personalId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                userId = resultSet.getString("userId");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userId;
    }

    @Override
    public List<Long> findLoanRecordIdsByUserId(String userId) {
        List<Long> loanRecordIds = new ArrayList<>();
        String query = "SELECT loanRecordId FROM woori_loan_records WHERE userId = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             
            preparedStatement.setString(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                loanRecordIds.add(resultSet.getLong("loanRecordId"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return loanRecordIds;
    }
    
    @Override
    public void updateTransactionByFeeAndAccount(int fee, String repaymentAccount, String finance) {
        String[] banks = {"우리은행", "신한은행", "국민은행"};

        for (String bank : banks) {
            if (finance.equals(bank) && bank.equals("우리은행")) {
                String getIdSql = "SELECT woori_transaction_seq.NEXTVAL FROM DUAL";
                String insertSql = "INSERT INTO woori_transaction (ID, ACCOUNTID, TRANSACTION_DATE, TRANSACTION_TYPE, COUNTERPARTY_ACCOUNT_ID, TRANSACTION_AMOUNT, TRANSACTION_FEE, REMARKS) VALUES (?, ?, SYSDATE, ?, ?, ?, ?, ?)";

                try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);
                     PreparedStatement getIdStmt = connection.prepareStatement(getIdSql);
                     PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {

                    // Fetch the next value from sequence
                    ResultSet rs = getIdStmt.executeQuery();
                    if (rs.next()) {
                        int nextId = rs.getInt(1);

                        insertStmt.setInt(1, nextId);
                        insertStmt.setString(2, repaymentAccount);
                        insertStmt.setString(3, "출금");
                        insertStmt.setString(4, "우리은행");
                        insertStmt.setInt(5, fee);
                        insertStmt.setInt(6, 0);
                        insertStmt.setString(7, "[하나은행] 중도상환수수료");

                        insertStmt.executeUpdate();
                    }

                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        }
    }
 }

    
