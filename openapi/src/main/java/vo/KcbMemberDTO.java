package vo;

public class KcbMemberDTO {

    private int memberId;
    private String username;
    private String password;
    private String email;
    private String creditDate;
    private int personalId;
    public int getMemberId() {
        return memberId;
    }
    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getCreditDate() {
        return creditDate;
    }
    public void setCreditDate(String creditDate) {
        this.creditDate = creditDate;
    }
    public int getPersonalId() {
        return personalId;
    }
    public void setPersonalId(int personalId) {
        this.personalId = personalId;
    }
    @Override
    public String toString() {
        return "KcbMemberDTO [memberId=" + memberId + ", username=" + username + ", password="
                + password + ", email=" + email + ", creditDate=" + creditDate + "]";
    }
    
    
}
