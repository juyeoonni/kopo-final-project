package kr.ac.kopo.final_hanaasset360.retirement.service;

import kr.ac.kopo.final_hanaasset360.account.repository.AccountRepository;
import kr.ac.kopo.final_hanaasset360.account.repository.AccountTransactionRepository;
import kr.ac.kopo.final_hanaasset360.retirement.repository.SavingProductRepository;
import kr.ac.kopo.final_hanaasset360.retirement.repository.SavingTransactionRepository;
import kr.ac.kopo.final_hanaasset360.account.vo.AccountTransactionVO;
import kr.ac.kopo.final_hanaasset360.retirement.vo.SavingApplicationVO;
import kr.ac.kopo.final_hanaasset360.retirement.vo.SavingTransactionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Random;

@Service
public class SavingProductServiceImpl implements SavingProductService{
    private final SavingProductRepository repository;

    private final AccountRepository accountRepository;

    private final AccountTransactionRepository accountTransactionRepository;

    private final SavingTransactionRepository savingTransactionRepository;


    @Autowired
    public SavingProductServiceImpl(SavingProductRepository repository, AccountRepository accountRepository, AccountTransactionRepository accountTransactionRepository, SavingTransactionRepository savingTransactionRepository) {
        this.repository = repository;
        this.accountRepository = accountRepository;
        this.accountTransactionRepository = accountTransactionRepository;
        this.savingTransactionRepository = savingTransactionRepository;
    }

    @Transactional
    public void submitApplication(SavingApplicationVO vo) {

        vo.setAccountId(generateRandomAccountNumber());
        vo.setStatus("진행중");
        // 적금 계좌 개설
        repository.save(vo);


        // 가입 금액 차감
        accountRepository.updateBalance(vo.getAccount(), vo.getSavingAmount());

        // 거래 내역 추가

        // 계좌에서 가입금액 출금
        AccountTransactionVO transaction = new AccountTransactionVO();
        transaction.setAccountid(vo.getAccount());
        transaction.setTransactionDate(new Date());  // 현재 날짜와 시간을 직접 설정
        transaction.setTransactionType("출금");
        transaction.setCounterpartyAccountId(vo.getAccountId());
        transaction.setTransactionAmount(vo.getSavingAmount());
        transaction.setTransactionFee(0);  // Transaction fee를 0으로 설정
        transaction.setRemarks("[하나은행] 적금 가입");

        accountTransactionRepository.save(transaction);  // Save the transaction


        // 적금 계좌에서 가입금액 입금
        SavingTransactionVO savingTransaction = new SavingTransactionVO();
        savingTransaction.setAccountId(vo.getAccountId());
        savingTransaction.setTransactionDate(new Date());
        savingTransaction.setTransactionType("입금");
        savingTransaction.setCounterpartyAccountId(vo.getAccount());
        savingTransaction.setTransactionAmount(vo.getSavingAmount());
        savingTransaction.setTransactionFee(0);
        savingTransaction.setTransactionAmount(vo.getSavingAmount());
        savingTransaction.setRemarks("[하나은행] 적금 가입");

        savingTransactionRepository.save(savingTransaction);

    }

    @Override
    public List<SavingApplicationVO> findByUserId(String userId) {
        return repository.findByUserId(userId);
    }


    public static String generateRandomAccountNumber() {
        Random random = new Random();

        // 각 세그먼트의 길이에 따른 랜덤 숫자를 생성
        int firstSegment = 100 + random.nextInt(900);  // 100 ~ 999
        int secondSegment = 100000 + random.nextInt(900000);  // 100000 ~ 999999
        int thirdSegment = 10000 + random.nextInt(90000);  // 10000 ~ 99999

        // 생성된 랜덤 숫자를 형식에 맞게 조합
        return String.format("%d-%d-%d", firstSegment, secondSegment, thirdSegment);
    }
}
