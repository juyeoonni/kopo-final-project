package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import vo.AllCreditDTO;
import vo.AllCreditInfoDTO;
import vo.KcbAssetDTO;
import vo.KcbCreditInfoDTO;
import vo.KcbMemberDTO;

public class KCBInfoRepositoryImpl implements KCBInfoRepository {
    
    private static KCBInfoRepositoryImpl instance = null;

    private final String DB_URL =
            "jdbc:oracle:thin:@openapi_high?TNS_ADMIN=/opt/wallet/Wallet_DinkDB";
    private final String USER = "admin";
    private final String PASS = "Rhkswnd2846!";
    
    public KCBInfoRepositoryImpl(){
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static KCBInfoRepositoryImpl getInstance() {
        if (instance == null) {
            synchronized (KCBInfoRepositoryImpl.class) {
                if (instance == null) {
                    instance = new KCBInfoRepositoryImpl();
                }
            }
        }
        return instance;
    }
   

    public List<AllCreditInfoDTO> findMemberIdByCreditScore(String username, String password) {
        List<AllCreditInfoDTO > resultList = new ArrayList<>();

        String findMemberIdSql = "SELECT ID FROM ALL_CREDIT WHERE ID = ? AND PASSWORD = ?";
        String findCreditInfoSql = "SELECT * FROM ALLCREDIT_CREDIT WHERE ID = ?";

        try (
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
            PreparedStatement findMemberIdStmt = conn.prepareStatement(findMemberIdSql);
            PreparedStatement findCreditInfoStmt = conn.prepareStatement(findCreditInfoSql)
        ) {
            // Set parameters and execute the query to find the MEMBER_ID
            findMemberIdStmt.setString(1, username);
            findMemberIdStmt.setString(2, password);

            try (ResultSet rs = findMemberIdStmt.executeQuery()) {
                if (rs.next()) {
                    String foundMemberId = rs.getString("ID");

                    
                    findCreditInfoStmt.setString(1, foundMemberId);
                    try (ResultSet creditInfoRs = findCreditInfoStmt.executeQuery()) {
                        while (creditInfoRs.next()) {
                            AllCreditInfoDTO creditInfo = new AllCreditInfoDTO();
                            creditInfo.setId(creditInfoRs.getString("ID"));
                            creditInfo.setCreditScore(creditInfoRs.getInt("CREDIT_SCORE"));
                            creditInfo.setRepaymentScore(creditInfoRs.getInt("Repayment_SCORE"));
                            creditInfo.setLoanScore(creditInfoRs.getInt("LOAN_SCORE"));
                            creditInfo.setCreditRisk(creditInfoRs.getInt("CREDIT_RISK"));
                            creditInfo.setCreditPeriodScore(creditInfoRs.getInt("CREDIT_PERIOD_SCORE"));

                            resultList.add(creditInfo);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultList;
    }

    @Override
    public List<KcbAssetDTO> findMemberIdByAsset(String username, String password) {
        List<KcbAssetDTO> assetList = new ArrayList<>();
        
        String findMemberIdQuery = "SELECT MEMBER_ID FROM ALL_CREDIT WHERE USERNAME = ? AND PASSWORD = ?";
        
        String findAssetQuery = "SELECT * FROM KCB_ASSETS WHERE MEMBER_ID = ?";
        
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            
            // Find the MEMBER_ID
            try (PreparedStatement ps = conn.prepareStatement(findMemberIdQuery)) {
                ps.setString(1, username);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int memberId = rs.getInt("MEMBER_ID");
                        
                        // Fetch the asset information
                        try (PreparedStatement psAsset = conn.prepareStatement(findAssetQuery)) {
                            psAsset.setInt(1, memberId);
                            try (ResultSet rsAsset = psAsset.executeQuery()) {
                                while (rsAsset.next()) {
                                    KcbAssetDTO asset = new KcbAssetDTO();
                                    asset.setId(rsAsset.getInt("ID"));
                                    asset.setMemberId(rsAsset.getInt("MEMBER_ID"));
                                    asset.setRealEstateValue(rsAsset.getInt("REAL_ESTATE_VALUE")); // 오타 수정
                                    asset.setBankSavings(rsAsset.getInt("BANK_SAVINGS")); // 오타 수정
                                    assetList.add(asset);
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return assetList;
    }

    @Override
    public AllCreditDTO getMemberByPersonalId(long personalId) {
        String query = "SELECT id FROM ALL_CREDIT WHERE personalidnumber = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setLong(1, personalId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    AllCreditDTO member = new AllCreditDTO();
                    member.setId(rs.getString("id"));
                    return member;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<AllCreditInfoDTO> getCreditInfoByMemberId(String memberId) {
        String query = "SELECT * FROM ALLCREDIT_CREDIT WHERE id = ?";
        List<AllCreditInfoDTO> creditInfoList = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setString(1, memberId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    AllCreditInfoDTO creditInfo = new AllCreditInfoDTO();
                    
                    creditInfo.setId(rs.getString("ID"));
                    creditInfo.setCreditScore(rs.getInt("CREDIT_SCORE"));
                    creditInfo.setRepaymentScore(rs.getInt("Repayment_SCORE"));
                    creditInfo.setLoanScore(rs.getInt("LOAN_SCORE"));
                    creditInfo.setCreditRisk(rs.getInt("CREDIT_RISK"));
                    creditInfo.setCreditPeriodScore(rs.getInt("CREDIT_PERIOD_SCORE"));
                    
                    creditInfoList.add(creditInfo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return creditInfoList;
    }

    @Override
    public List<KcbAssetDTO> getAssetsInfoByMemberId(int memberId) {
        String query = "SELECT * FROM KCB_ASSETS WHERE MEMBER_ID = ?";
        List<KcbAssetDTO> assetsInfoList = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setInt(1, memberId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    KcbAssetDTO assetsInfo = new KcbAssetDTO();
                    
                    assetsInfo.setId(rs.getInt("ID"));
                    assetsInfo.setMemberId(rs.getInt("MEMBER_ID"));
                    assetsInfo.setRealEstateValue(rs.getInt("REAL_ESTATE_VALUE"));
                    assetsInfo.setBankSavings(rs.getInt("BANK_SAVINGS"));
                    
                    assetsInfoList.add(assetsInfo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assetsInfoList;
    }

    

}


