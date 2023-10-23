package kr.ac.kopo.final_hanaasset360.mail.vo;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
public class MailVO {
    private String to;
    private String subject;
    private String message;
}
