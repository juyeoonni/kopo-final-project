package service;

import java.util.List;
import vo.AllCreditDTO;
import vo.AllCreditInfoDTO;
import vo.KcbAssetDTO;
import vo.KcbCreditInfoDTO;
import vo.KcbMemberDTO;

public interface KCBInfoService {
    public List<AllCreditInfoDTO> findMemberIdByCreditScore(String memberId, String password);

    public List<KcbAssetDTO> findMemberIdByAsset(String username, String password);

    public AllCreditDTO getMemberByPersonalId(long personalId);
    

//    public List<KcbCreditInfoDTO> getAssetsInfoByMemberId(String memberId);

    public List<AllCreditInfoDTO> getCreditInfoByMemberId(String string);

}
