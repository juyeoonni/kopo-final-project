package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.repository.RecommendProductRepository;
import kr.ac.kopo.final_hanaasset360.vo.RecommendProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecommendProductServiceImpl implements RecommendProductService {

    @Autowired
    private RecommendProductRepository repository;

    public List<RecommendProductVO> getAllProducts() {
        return repository.findAll();
    }

    @Override
    public RecommendProductVO getProductById(Long productId) {
        return repository.findById(productId).orElse(null);
    }
}
