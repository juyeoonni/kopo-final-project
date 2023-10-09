package kr.ac.kopo.final_hanaasset360.vo;

public class ApplyUserVO {

    private String userId;       // VARCHAR2(30)
    private String password;     // VARCHAR2(10)
    private String phone;
    private String name;         // VARCHAR2(10)
    private String birth;        // DATE (as String)
    private Long personalId;     // NUMBER(38)
    private String userType;     // CHAR(10) (as String)
    private String email;        // VARCHAR2(50)
    private String addresss;     // VARCHAR2(120) [주의: 'addresss'에 's'가 3개 있습니다. 오타일 수도 있으니 확인 필요]
    private String gender;       // CHAR(3) (as String)


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

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPhone() {
        return phone;
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

    public String getAddresss() {
        return addresss;
    }

    public void setAddresss(String addresss) {
        this.addresss = addresss;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "UserVO{" +
                "userId='" + userId + '\'' +
                ", password='" + password + '\'' +
                ", phone=" + phone +
                ", name='" + name + '\'' +
                ", birth='" + birth + '\'' +
                ", personalId=" + personalId +
                ", userType='" + userType + '\'' +
                ", email='" + email + '\'' +
                ", addresss='" + addresss + '\'' +
                ", gender='" + gender + '\'' +
                '}';
    }
}
