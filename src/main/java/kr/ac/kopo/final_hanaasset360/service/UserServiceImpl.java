package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.dao.UserDAOImpl;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAOImpl userDAOImpl;

    public UserVO validateUser(String username, String password) {
        UserVO user = userDAOImpl.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}