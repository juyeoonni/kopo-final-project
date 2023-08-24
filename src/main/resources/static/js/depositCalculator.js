function calculateDeposit() {
    const targetAmount = parseFloat(document.getElementById('targetAmount').value);
    const savingsPeriod = parseFloat(document.getElementById('savingsPeriod').value);
    const annualInterestRate = parseFloat(document.getElementById('interestRate').value) / 100;

    // 예금 단리 계산
    const monthlyDeposit = targetAmount / (1 + annualInterestRate * (savingsPeriod / 12));

    const resultElement = document.getElementById('result');
    resultElement.innerHTML = `목표금액 ${targetAmount.toLocaleString()}원을 모으려면 연 이율 ${annualInterestRate * 100}%의 단리로 ${savingsPeriod}개월 동안  ${monthlyDeposit.toLocaleString()}원을 납입하셔야 합니다.`;
}