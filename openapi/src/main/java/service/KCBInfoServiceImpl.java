package service;

import java.util.List;
import repository.KCBInfoRepository;
import repository.KCBInfoRepositoryImpl;
import vo.AllCreditDTO;
import vo.AllCreditInfoDTO;
import vo.KcbAssetDTO;
import vo.KcbCreditInfoDTO;
import vo.KcbMemberDTO;

public class KCBInfoServiceImpl implements KCBInfoService {

    @Override
    public List<AllCreditInfoDTO> findMemberIdByCreditScore(String username, String password) {
        // TODO Auto-generated method stub
        KCBInfoRepository repository = KCBInfoRepositoryImpl.getInstance();
        return repository.findMemberIdByCreditScore(username, password);
    }

    @Override
    public List<KcbAssetDTO> findMemberIdByAsset(String username, String password) {
        // TODO Auto-generated method stub
        KCBInfoRepository repository = KCBInfoRepositoryImpl.getInstance();
        return repository.findMemberIdByAsset(username, password);
    }

    @Override
    public AllCreditDTO getMemberByPersonalId(long personalId) {
        KCBInfoRepository repository = KCBInfoRepositoryImpl.getInstance();
        return repository.getMemberByPersonalId(personalId);
    }

//    @Override
//    public List<KcbAssetDTO> getAssetsInfoByMemberId(String memberId) {
//        KCBInfoRepository repository = KCBInfoRepositoryImpl.getInstance();
//        return repository.getAssetsInfoByMemberId(memberId);
//    }

    @Override
    public List<AllCreditInfoDTO> getCreditInfoByMemberId(String memberId) {
        KCBInfoRepository repository = KCBInfoRepositoryImpl.getInstance();
        return repository.getCreditInfoByMemberId(memberId);
    }

}
