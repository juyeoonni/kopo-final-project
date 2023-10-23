package kr.ac.kopo.final_hanaasset360.message;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class MessageRequest {
    private String recipientPhoneNumber;
    private String title;
    private String content;
    private String ouathNum;
}
