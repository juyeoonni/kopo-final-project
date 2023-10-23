package kr.ac.kopo.final_hanaasset360.config;

import kr.ac.kopo.final_hanaasset360.account.repository.AccountRepository;
import kr.ac.kopo.final_hanaasset360.loan.repository.LoanRecordsRepository;
import kr.ac.kopo.final_hanaasset360.account.vo.Accounts;
import kr.ac.kopo.final_hanaasset360.loan.vo.LoanRecords;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Component
public class RepaymentSchedulerConfig implements SchedulingConfigurer {
    @Autowired
    private LoanRecordsRepository loanRecordRepository;

    @Autowired
    private AccountRepository accountRepository;

    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        taskRegistrar.addTriggerTask(
                this::processRepayment,
                triggerContext -> {
                    Calendar nextExecutionTime = Calendar.getInstance();
                    Date lastActualExecutionTime = triggerContext.lastActualExecutionTime();

                    if (lastActualExecutionTime == null) {
                        lastActualExecutionTime = new Date();
                    }

                    nextExecutionTime.setTime(lastActualExecutionTime);

                    int currentDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
                    List<LoanRecords> loanRecords = loanRecordRepository.findAll();

                    for (LoanRecords loanRecord : loanRecords) {
                        if(loanRecord.getRepaymentDate() == currentDay) {

                            nextExecutionTime.add(Calendar.MONTH, 1);
                            nextExecutionTime.set(Calendar.DAY_OF_MONTH, loanRecord.getRepaymentDate());
                            break;
                        } else if(loanRecord.getRepaymentDate() > currentDay) {
                            nextExecutionTime.set(Calendar.DAY_OF_MONTH, loanRecord.getRepaymentDate());
                            break;
                        } else {
                            nextExecutionTime.add(Calendar.MONTH, 1); // Next month
                            nextExecutionTime.set(Calendar.DAY_OF_MONTH, loanRecord.getRepaymentDate());
                            break;
                        }
                    }

                    Instant nextInstant = nextExecutionTime.getTime().toInstant();
                    System.out.println("Next scheduled time: " + nextInstant);

                    return nextInstant;
                }
        );
    }


    public void processRepayment() {
        int currentDay = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
        List<LoanRecords> loanRecords = loanRecordRepository.findAll();
        System.out.println("Current Day: " + currentDay);
        for (LoanRecords loanRecord : loanRecords) {
            System.out.println("Checking loan record with ID: " + loanRecord.getLoanRecordId());
            if(loanRecord.getRepaymentDate() == currentDay) {
                System.out.println("Processing repayment for loan record ID: " + loanRecord.getLoanRecordId());
                int monthlyRepayment = (int) (loanRecord.getLoanBalance() * (loanRecord.getInterestRate() / 12));  // 가정: 연이율 기준
                System.out.println("Calculated monthly repayment: " + monthlyRepayment);

                Accounts account = accountRepository.findById(loanRecord.getRepaymentAccount()).orElse(null);

                if (account != null) {
                    System.out.println("Before deduction, account balance: " + account.getAccountBalance());
                    account.setAccountBalance(account.getAccountBalance() - monthlyRepayment);
                    accountRepository.save(account);
                    System.out.println("After deduction, account balance: " + account.getAccountBalance());
                } else {
                    System.out.println("Account not found for loan record ID: " + loanRecord.getLoanRecordId());
                }
            } else {
                System.out.println("Skipping loan record ID: " + loanRecord.getLoanRecordId());
            }
        }
    }
}