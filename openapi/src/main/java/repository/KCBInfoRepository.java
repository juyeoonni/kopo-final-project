package repository;

import java.util.List;
import vo.AllCreditDTO;
import vo.AllCreditInfoDTO;
import vo.KcbAssetDTO;
import vo.KcbCreditInfoDTO;
import vo.KcbMemberDTO;

public interface KCBInfoRepository {
    public List<AllCreditInfoDTO> findMemberIdByCreditScore(String memberId, String password);


    public List<KcbAssetDTO> findMemberIdByAsset(String username, String password);


    public AllCreditDTO getMemberByPersonalId(long personalId);


    public List<AllCreditInfoDTO> getCreditInfoByMemberId(String memberId);


    public List<KcbAssetDTO> getAssetsInfoByMemberId(int memberId);
}
