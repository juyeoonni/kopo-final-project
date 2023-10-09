package kr.ac.kopo.final_hanaasset360.calculator.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CalculatorController {

    @GetMapping("/calculator")
    public String calculator() {
        return "/calculator/loanCalculator";
    }

    @GetMapping("/calculator/loanCalculator")
    public String loanCalculator() {
        return "/calculator/loanCalculator";
    }

    @GetMapping("/calculator/savings")
    public String savingsCalculator() {
        return "/calculator/savings";
    }

    @GetMapping("/calculator/deposit")
    public String depositCalculator() {
        return "/calculator/deposit";
    }

    @GetMapping("/calculator/incomededuction")
    public String incomedeductionCalculator() {
        return "/calculator/incomededuction";
    }
}
