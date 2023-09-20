package kr.ac.kopo.final_hanaasset360;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class FinalHanaasset360Application {

    public static void main(String[] args) {
        SpringApplication.run(FinalHanaasset360Application.class, args);
    }

}
