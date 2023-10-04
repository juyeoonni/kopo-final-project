package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.vo.RecommendProductVO;

import java.util.List;

public interface RecommendProductService {
    public List<RecommendProductVO> getAllProducts();

    RecommendProductVO getProductById(Long productId);
}
