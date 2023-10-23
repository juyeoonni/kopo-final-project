package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import vo.HomtaxCreditInfoDTO;
import vo.HomtaxPersonalMemberDTO;
import vo.KcbMemberDTO;

public class HometaxRepositoryImpl implements HometaxRepository {
    private static HometaxRepositoryImpl instance = null;

    private final String DB_URL =
            "jdbc:oracle:thin:@openapi_high?TNS_ADMIN=/opt/wallet/Wallet_DinkDB";
    private final String USER = "admin";
    private final String PASS = "Rhkswnd2846!";
    
    public HometaxRepositoryImpl(){
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static HometaxRepositoryImpl getInstance() {
        if (instance == null) {
            synchronized (HometaxRepositoryImpl.class) {
                if (instance == null) {
                    instance = new HometaxRepositoryImpl();
                }
            }
        }
        return instance;
    }

    @Override
    public HomtaxPersonalMemberDTO getMemberByPersonalId(long personalId) {
        String query = "SELECT ID FROM HOMETAX_PERSONAL WHERE personalidnumber = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, personalId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    HomtaxPersonalMemberDTO member = new HomtaxPersonalMemberDTO();
                    member.setId(rs.getString("ID"));
                    return member;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<HomtaxCreditInfoDTO> getCreditInfoByMemberId(String id) {
        // TODO Auto-generated method stub
        List<HomtaxCreditInfoDTO> resultList = new ArrayList<>();
        // SQL 쿼리
        String sql = "SELECT * FROM HOMETAX_CREDIT WHERE ID = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id); // id 값 설정

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    HomtaxCreditInfoDTO dto = new HomtaxCreditInfoDTO();
                    dto.setRegistrationDate(rs.getTimestamp("REGISTRATION_DATE"));
                    dto.setId(rs.getString("ID"));
                    dto.setCreditCardUsage(rs.getInt("CREDIT_CARD_USAGE"));
                    dto.setDebitCardUsage(rs.getInt("DEBIT_CARD_USAGE"));
                    dto.setCashReceipt(rs.getInt("CASH_RECEIPT"));
                    dto.setAnnualIncome(rs.getInt("ANNUAL_INCOME"));

                    resultList.add(dto);
                }
            }
        } catch (Exception e) {
            // 예외 처리 (로그 출력, 특정 동작 등)
            e.printStackTrace();
        }

        return resultList;
    }

    @Override
    public List<HomtaxCreditInfoDTO> getCreditInfoByMemberIdAndPassword(String id, String password) {
        List<HomtaxCreditInfoDTO> resultList = new ArrayList<>();

        // SQL 쿼리 (INNER JOIN 사용)
        String sql = "SELECT c.* FROM HOMETAX_PERSONAL p " + 
                     "INNER JOIN HOMETAX_CREDIT c ON p.ID = c.ID " + 
                     "WHERE p.ID = ? AND p.PASSWORD = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);       // id 값 설정
            pstmt.setString(2, password); // password 값 설정

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    HomtaxCreditInfoDTO dto = new HomtaxCreditInfoDTO();
                    dto.setRegistrationDate(rs.getTimestamp("REGISTRATION_DATE"));
                    dto.setId(rs.getString("ID"));
                    dto.setCreditCardUsage(rs.getInt("CREDIT_CARD_USAGE"));
                    dto.setDebitCardUsage(rs.getInt("DEBIT_CARD_USAGE"));
                    dto.setCashReceipt(rs.getInt("CASH_RECEIPT"));
                    dto.setAnnualIncome(rs.getInt("ANNUAL_INCOME"));

                    resultList.add(dto);
                }
            }
        } catch (Exception e) {
            // 예외 처리 (로그 출력, 특정 동작 등)
            e.printStackTrace();
        }

        return resultList;
    }
    
}
