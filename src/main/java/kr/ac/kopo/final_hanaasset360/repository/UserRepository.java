package kr.ac.kopo.final_hanaasset360.repository;

import kr.ac.kopo.final_hanaasset360.vo.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findByUserId(String userId);

    Long countByLastLoginDateAfter(Date date);

    Long countByApplicationDateAfter(Date date);

    @Query("SELECT new map(applicationDate as date, COUNT(userId) as count) FROM User WHERE applicationDate >= :startDate GROUP BY applicationDate")
    List<Map<String, Object>> findDailyRegistrations(@Param("startDate") Date startDate);

}
