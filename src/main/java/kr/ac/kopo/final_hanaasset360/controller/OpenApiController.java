package kr.ac.kopo.final_hanaasset360.controller;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.service.ApiService;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

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
    public String loanData(HttpSession session) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");  // 세션에서 personalId 값을 가져옴
        String personalId = String.valueOf(loggedInUser.getPersonalId());
        System.out.println("personalId: " + personalId);
        return apiService.loanDataFormAPI(personalId); // 가져온 personalId 값을 API 호출에 사용
    }


}
