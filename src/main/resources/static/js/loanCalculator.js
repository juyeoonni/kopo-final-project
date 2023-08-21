function calculateRepayment() {
    let principal = parseFloat(document.getElementById('loanAmount').value);
    let annualRate = parseFloat(document.getElementById('interestRate').value) / 100;
    let period = parseFloat(document.getElementById('loanPeriod').value);
    let method = document.getElementById('repaymentMethod').value;

    let monthlyRate = annualRate / 12;
    let totalMonths = period * 12;
    let monthlyRepayment;

    switch (method) {
        case 'equalPrincipalAndInterest':
            monthlyRepayment = principal * monthlyRate / (1 - Math.pow(1 + monthlyRate, -totalMonths));
            break;

        case 'interestOnly':
            monthlyRepayment = principal * monthlyRate;
            break;

        case 'equalPrincipal':
            let monthlyPrincipal = principal / totalMonths;
            monthlyRepayment = monthlyPrincipal + (principal - monthlyPrincipal * (totalMonths - 1)) * monthlyRate;
            break;
    }

    document.getElementById('monthlyRepayment').innerText = monthlyRepayment.toFixed(2) + " 원";
}