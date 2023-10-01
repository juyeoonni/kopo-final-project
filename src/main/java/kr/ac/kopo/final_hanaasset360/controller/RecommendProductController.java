package kr.ac.kopo.final_hanaasset360.controller;

import kr.ac.kopo.final_hanaasset360.service.RecommendProductService;
import kr.ac.kopo.final_hanaasset360.vo.RecommendProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/products")
public class RecommendProductController {

    @Autowired
    private RecommendProductService service;

    @GetMapping
    public ResponseEntity<List<RecommendProductVO>> getAllProducts() {
        return ResponseEntity.ok(service.getAllProducts());
    }
}
