package kr.ac.kopo.final_hanaasset360.config;

import kr.ac.kopo.final_hanaasset360.converter.RSAKeyUtil;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.io.File;

@Component
public class AppStartupRunner implements CommandLineRunner {

    @Override
    public void run(String... args) throws Exception {
        File publicKeyFile = new File(RSAKeyUtil.PUBLIC_KEY_FILE);
        File privateKeyFile = new File(RSAKeyUtil.PRIVATE_KEY_FILE);

        if (!publicKeyFile.exists() || !privateKeyFile.exists()) {
            // 키 파일이 없는 경우에만 새로 생성
            RSAKeyUtil.generateAndSaveKeyPair();
        }
    }
}
