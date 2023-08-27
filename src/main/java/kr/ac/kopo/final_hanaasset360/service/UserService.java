package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.dao.UserDAO;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserDAO userDAO;

    public UserVO validateUser(String username, String password) {
        UserVO user = userDAO.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}