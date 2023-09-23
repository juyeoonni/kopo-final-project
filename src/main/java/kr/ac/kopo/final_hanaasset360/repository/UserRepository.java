package kr.ac.kopo.final_hanaasset360.repository;

import kr.ac.kopo.final_hanaasset360.vo.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, String> {
}
