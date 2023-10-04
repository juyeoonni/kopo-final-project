package kr.ac.kopo.final_hanaasset360.service;

import kr.ac.kopo.final_hanaasset360.repository.AccountRepository;
import kr.ac.kopo.final_hanaasset360.repository.SavingProductRepository;
import kr.ac.kopo.final_hanaasset360.vo.SavingApplicationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SavingProductServiceImpl implements SavingProductService{
    private final SavingProductRepository repository;

    private final AccountRepository accountRepository;

    @Autowired
    public SavingProductServiceImpl(SavingProductRepository repository, AccountRepository accountRepository) {
        this.repository = repository;
        this.accountRepository = accountRepository;
    }

    @Transactional
    public void submitApplication(SavingApplicationVO vo) {
        // 적금 계좌 개설
        repository.save(vo);

        // 가입 금액 차감
        accountRepository.updateBalance(vo.getAccount(), vo.getSavingAmount());
    }
}
