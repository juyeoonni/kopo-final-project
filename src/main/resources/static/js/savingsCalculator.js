function calculateSavings() {
    const targetAmount = parseFloat(document.getElementById('targetAmount').value);
    const savingsPeriod = parseFloat(document.getElementById('savingsPeriod').value);
    const annualInterestRate = parseFloat(document.getElementById('interestRate').value) / 100;
    const interestMethod = document.getElementById('interestMethod').value;

    let monthlySavings;

    if (interestMethod === 'simpleInterest') {
        monthlySavings = targetAmount / (1 + annualInterestRate * (savingsPeriod / 12)) / savingsPeriod;
    } else {
        // 복리 계산
        const monthlyRate = Math.pow(1 + annualInterestRate, 1/12) - 1;
        monthlySavings = targetAmount / ((Math.pow(1 + monthlyRate, savingsPeriod) - 1) / monthlyRate);
    }

    const resultElement = document.getElementById('result');
    resultElement.innerHTML = `목표금액 ${targetAmount.toLocaleString()}원을 모으려면 연 이율 ${annualInterestRate * 100}%의 ${interestMethod === 'simpleInterest' ? '단리' : '복리'}로 ${savingsPeriod}개월 동안 월 ${monthlySavings.toLocaleString()}원을 저축하셔야 합니다.`;
}