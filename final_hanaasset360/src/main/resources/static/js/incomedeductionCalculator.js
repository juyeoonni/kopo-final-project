function calculateTax() {
    const salary = document.getElementById("salary").value * 10000;
    const creditCard = document.getElementById("creditCard").value * 10000;
    const cashReceipt = document.getElementById("cashReceipt").value * 10000;
    const checkCard = document.getElementById("checkCard").value * 10000;

    const salaryDeduction = salary * 0.25;
    const creditDeduction = Math.max(creditCard - salaryDeduction, 0) * 0.15;
    const cashReceiptDeduction = cashReceipt * 0.30;
    const checkCardDeduction = checkCard * 0.30;

    const totalDeduction = creditDeduction + cashReceiptDeduction + checkCardDeduction;

    const taxSavings = totalDeduction * 0.06;

    document.getElementById("result").textContent = `아낄 수 있는 공제액은 ${taxSavings.toLocaleString()}원 입니다.`;
}