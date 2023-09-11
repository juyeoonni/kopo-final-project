function formatAmount(amount) {
    return (amount / 10000) + "만원";
}
window.onload = function() {
    let element = document.querySelector('.highlight-circle .circle-value');
    element.textContent = formatAmount(${selectedLoanProduct.loanLimAmt});
}


function sendData() {
    const data = {
        selectedLoanProduct: "${selectedLoanProduct}",
        selectedLoanData: "${selectedLoanData}",
        creditData: "${creditData}"
    };

    fetch('/loanSwitch/loanSwitchStep3', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
        .then(response => response.json())
        .then(data => {
            window.location.href = "/loanSwitch/loanSwitchStep3";
        });
}