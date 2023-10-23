package vo;

public class AllCreditDTO {
    private String id;
    private String password;
    private String name;
    private Long personalidnumber;
    private Long phone;
    private String email;
    private String addresss;

    // 기본 생성자
    public AllCreditDTO() {
    }

    // 생성자
    public AllCreditDTO(String id, String password, String name, Long personalidnumber, Long phone, String email, String addresss) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.personalidnumber = personalidnumber;
        this.phone = phone;
        this.email = email;
        this.addresss = addresss;
    }

    // Getter와 Setter 메서드
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

    public Long getPersonalidnumber() {
        return personalidnumber;
    }

    public void setPersonalidnumber(Long personalidnumber) {
        this.personalidnumber = personalidnumber;
    }

    public Long getPhone() {
        return phone;
    }

    public void setPhone(Long phone) {
        this.phone = phone;
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

    @Override
    public String toString() {
        return "AllCreditDTO{" +
                "id='" + id + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", personalidnumber=" + personalidnumber +
                ", phone=" + phone +
                ", email='" + email + '\'' +
                ", addresss='" + addresss + '\'' +
                '}';
    }
}

