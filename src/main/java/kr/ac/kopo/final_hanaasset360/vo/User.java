package kr.ac.kopo.final_hanaasset360.vo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "USERS") // 테이블 이름이 USERS라고 가정
public class User {

    @Id
    @Column(name = "USERID", nullable = false, length = 30)
    private String userId;

    @Column(name = "PASSWORD", nullable = false, length = 10)
    private String password;

    @Column(name = "PHONE", nullable = false)
    private Long phone;

    @Column(name = "NAME", nullable = false, length = 10)
    private String name;

    @Column(name = "BIRTH", nullable = false)
    private String birth;

    @Column(name = "PERSONALID", nullable = false)
    private Long personalId;

    @Column(name = "USERTYPE", nullable = false, length = 10)
    private String userType;

    @Column(name = "EMAIL", nullable = false, length = 50)
    private String email;

    @Column(name = "ADDRESSS", nullable = false, length = 120) // 주의: DB 열 이름이 ADDRESSS로 오타가 있는 것 같습니다.
    private String address;

    @Column(name = "GENDER", nullable = false, length = 3)
    private String gender;

    // Getter and Setter 메서드

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Long getPhone() {
        return phone;
    }

    public void setPhone(Long phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public Long getPersonalId() {
        return personalId;
    }

    public void setPersonalId(Long personalId) {
        this.personalId = personalId;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    // ...생략...
}
