package kr.ac.kopo.final_hanaasset360.user.dao;

import kr.ac.kopo.final_hanaasset360.user.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserDAO {
    UserVO findByUsername(String username);
}
