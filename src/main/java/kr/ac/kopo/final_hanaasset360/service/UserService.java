package kr.ac.kopo.final_hanaasset360.service;


import kr.ac.kopo.final_hanaasset360.vo.UserVO;

public interface UserService {
    UserVO validateUser(String username, String password);
}
