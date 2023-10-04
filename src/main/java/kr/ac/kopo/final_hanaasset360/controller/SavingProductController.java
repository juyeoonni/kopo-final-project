package kr.ac.kopo.final_hanaasset360.controller;


import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.final_hanaasset360.service.AccountService;
import kr.ac.kopo.final_hanaasset360.service.RecommendProductService;
import kr.ac.kopo.final_hanaasset360.service.SavingProductService;
import kr.ac.kopo.final_hanaasset360.vo.Accounts;
import kr.ac.kopo.final_hanaasset360.vo.RecommendProductVO;
import kr.ac.kopo.final_hanaasset360.vo.SavingApplicationVO;
import kr.ac.kopo.final_hanaasset360.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class SavingProductController {

    private final SavingProductService service;
    @Autowired
    public SavingProductController(SavingProductService service) {
        this.service = service;
    }
    @Autowired
    RecommendProductService productService;

    @Autowired
    private AccountService accountService;

    @GetMapping("/productDetailPage")
    public ModelAndView getProductDetail(@RequestParam("productId") Long productId) {
        ModelAndView modelAndView = new ModelAndView();

        RecommendProductVO product = productService.getProductById(productId); // 상품 정보를 데이터베이스로부터 가져옴
        modelAndView.addObject("product", product); // product 객체를 JSP로 전달

        // modelAndView.addObject("product", product);
        modelAndView.setViewName("/savingProduct/productDetail"); // 해당 상품의 상세 정보를 보여줄 View의 이름

        return modelAndView;
    }

    @PostMapping("/join-saving-product")
    public ResponseEntity<?> handleProductRegistration(@RequestParam("productId") Long productId) {
        // 이곳에서 필요한 추가 로직을 작성할 수 있습니다. 예를 들면, 상품 가입 요청을 DB에 저장하는 로직 등.
        return ResponseEntity.ok().build(); // 성공 응답을 반환합니다.
    }

    @GetMapping("/savingProduct/join")
    public ModelAndView showJoinPage(@RequestParam("productId") Long productId, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        List<Accounts> accounts = accountService.getAccountsByUserId(loggedInUser.getUserId());
        RecommendProductVO product = productService.getProductById(productId);
        mav.addObject("product", product);
        mav.addObject("accounts", accounts);
        mav.setViewName("/savingProduct/join");
        return mav;
    }

    @PostMapping("/join-saving")
    @ResponseBody
    public ResponseEntity<String> submitLoanApplication(@RequestBody SavingApplicationVO vo, HttpSession session) {
        UserVO loggedInUser = (UserVO) session.getAttribute("loggedInUser");
        vo.setUserId(loggedInUser.getUserId());
        service.submitApplication(vo);

        return new ResponseEntity<>("Application received!", HttpStatus.OK);
    }
}
