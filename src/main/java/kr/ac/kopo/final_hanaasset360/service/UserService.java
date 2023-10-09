package kr.ac.kopo.final_hanaasset360.service;


import kr.ac.kopo.final_hanaasset360.vo.User;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface UserService {
    UserVO validateUser(String username, String password);
    int calculateAge(String userBirth);

    Page<User> findUsers(Pageable pageable);

    Long countRecentLogins();
    Long countRecentRegistrations();

    List<Map<String, Object>> getRecentRegistrations();
}
