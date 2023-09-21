package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.vo.MailVO;

public interface MailService {
    public void mailSend(MailVO mailDto);
}
