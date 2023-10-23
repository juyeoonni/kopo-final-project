package service;

import java.util.List;
import repository.HometaxRepository;
import repository.HometaxRepositoryImpl;
import repository.KCBInfoRepository;
import repository.KCBInfoRepositoryImpl;
import vo.HomtaxCreditInfoDTO;
import vo.HomtaxPersonalMemberDTO;

public class HometaxServiceImpl implements HometaxService {

    @Override
    public HomtaxPersonalMemberDTO getMemberByPersonalId(long personalId) {
        HometaxRepository repository = HometaxRepositoryImpl.getInstance();
        return repository.getMemberByPersonalId(personalId);
    }

    @Override
    public List<HomtaxCreditInfoDTO> getCreditInfoByMemberId(String id) {
        HometaxRepository repository = HometaxRepositoryImpl.getInstance();
        return repository.getCreditInfoByMemberId(id);
    }

    @Override
    public List<HomtaxCreditInfoDTO> getCreditInfoByMemberIdAndPassword(String id,
            String password) {
        HometaxRepository repository = HometaxRepositoryImpl.getInstance();
        return repository.getCreditInfoByMemberIdAndPassword(id, password);
    }

}
