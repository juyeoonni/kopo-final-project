package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.dao.UserDAO;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Override
    public UserVO validateUser(String username, String password) {
        UserVO user = userDAO.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public int calculateAge(String birthDateString) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime birthDateTime = LocalDateTime.parse(birthDateString, formatter);
        LocalDate birthDate = birthDateTime.toLocalDate();
        LocalDate today = LocalDate.now();

        // Period를 사용하여 두 날짜 사이의 기간을 구함
        Period period = Period.between(birthDate, today);

        // years를 반환하여 나이를 얻음
        return period.getYears();
    }
}