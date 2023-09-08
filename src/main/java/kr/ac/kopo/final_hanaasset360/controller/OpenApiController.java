package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.message.DocumentRequest;
import kr.ac.kopo.final_hanaasset360.service.ApiService;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class OpenApiController {
    private final ApiService apiService;

    public OpenApiController(ApiService apiService) {
        this.apiService = apiService;
    }

    @GetMapping("/fetch-data")
    public String fetchData() {
        return apiService.fetchDataFromAPI();
    }

    @GetMapping("/api/loan-data")
    public String loanData(HttpSession session, @RequestParam(required=false) List<String> banks) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");  // 세션에서 personalId 값을 가져옴
        String personalId = String.valueOf(loggedInUser.getPersonalId());
        System.out.println("personalId: " + personalId);
        System.out.println("Selected Banks: " + banks); // 선택한 은행들 출력
        return apiService.loanDataFormAPI(personalId, banks); // 가져온 personalId 값과 banks 리스트를 API 호출에 사용
    }

    @GetMapping("/api/document")
    public String getDocument(HttpSession session) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");  // 세션에서 personalId 값을 가져옴
        String personalId = String.valueOf(loggedInUser.getPersonalId());
        System.out.println(personalId);
        return apiService.documentDataFormAPI(personalId);
    }




}
