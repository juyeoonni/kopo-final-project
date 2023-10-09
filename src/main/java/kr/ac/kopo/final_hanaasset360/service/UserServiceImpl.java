package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.dao.UserDAO;
import kr.ac.kopo.final_hanaasset360.repository.UserRepository;
import kr.ac.kopo.final_hanaasset360.vo.User;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private UserRepository userRepository;

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

    /**
     * @param pageable
     * @return
     */
    @Override
    public Page<User> findUsers(Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    public Long countRecentLogins() {
        Date oneDayAgo = Date.from(Instant.now().minus(1, ChronoUnit.DAYS));
        return userRepository.countByLastLoginDateAfter(oneDayAgo);
    }

    public Long countRecentRegistrations() {
        Date oneDayAgo = Date.from(Instant.now().minus(1, ChronoUnit.DAYS));
        return userRepository.countByApplicationDateAfter(oneDayAgo);
    }

    public List<Map<String, Object>> getRecentRegistrations() {
        LocalDate startDate = LocalDate.now().minusDays(6);  // 최근 7일의 시작 날짜
        Date startDate2 = convertLocalDateToDate(startDate);
        return userRepository.findDailyRegistrations(startDate2);
    }

    public static Date convertLocalDateToDate(LocalDate localDate) {
        return java.sql.Date.valueOf(localDate);
    }
}