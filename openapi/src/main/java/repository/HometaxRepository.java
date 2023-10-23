package repository;

import java.util.List;
import vo.HomtaxCreditInfoDTO;
import vo.HomtaxPersonalMemberDTO;

public interface HometaxRepository {

    public HomtaxPersonalMemberDTO getMemberByPersonalId(long personalId);

    public List<HomtaxCreditInfoDTO> getCreditInfoByMemberId(String id);

    public List<HomtaxCreditInfoDTO> getCreditInfoByMemberIdAndPassword(String id, String password);

}
