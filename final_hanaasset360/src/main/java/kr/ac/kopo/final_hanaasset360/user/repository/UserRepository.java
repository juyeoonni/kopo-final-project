package kr.ac.kopo.final_hanaasset360.user.repository;

import kr.ac.kopo.final_hanaasset360.user.vo.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findByUserId(String userId);

    Page<User> findByUserType(String userType, Pageable pageable);
    Long countByLastLoginDateAfter(Date date);

    Long countByApplicationDateAfter(Date date);

    @Query("SELECT new map(applicationDate as date, COUNT(userId) as count) FROM User WHERE applicationDate >= :startDate GROUP BY applicationDate")
    List<Map<String, Object>> findDailyRegistrations(@Param("startDate") Date startDate);

}
