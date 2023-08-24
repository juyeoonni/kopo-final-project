package kr.ac.kopo.final_hanaasset360.controller;

import kr.ac.kopo.final_hanaasset360.service.ApiService;
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

}
