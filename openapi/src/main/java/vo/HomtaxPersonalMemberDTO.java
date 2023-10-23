package vo;

public class HomtaxPersonalMemberDTO {
    private String id;
    private String password;
    private String name;
    private long personalidnumber;  // 주민등록번호는 long 타입으로 설정
    private String phone;
    private String email;
    private String address;
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
   
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public long getSsn() {
        return personalidnumber;
    }
    public void setSsn(long personalidnumber) {
        this.personalidnumber = personalidnumber;
    }
    public String getPhoneNumber() {
        return phone;
    }
    public void setPhoneNumber(String phoneNumber) {
        this.phone = phoneNumber;
    }
    public long getPersonalidnumber() {
        return personalidnumber;
    }
    public void setPersonalidnumber(long personalidnumber) {
        this.personalidnumber = personalidnumber;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
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
    
    
    

    // 기본 생성자, 매개변수 있는 생성자, getter, setter, toString 메서드는 생략합니다.
}
