package kr.ac.kopo.final_hanaasset360.dao;

import kr.ac.kopo.final_hanaasset360.vo.UserVO;

public interface UserDAO {
    UserVO findByUsername(String username);
}
