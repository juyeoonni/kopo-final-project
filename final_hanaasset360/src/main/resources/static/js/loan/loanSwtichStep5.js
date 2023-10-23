function setLoanData(loanData) {
    // 필요한 요소를 가져옵니다.
    const loanName2Element = document.getElementById('loanName2');
    const loanAmount2Element = document.getElementById('loanAmount2');
    const loanAmountElement = document.getElementById('loanAmount');
    const interestRate2Element = document.getElementById('interestRate2');
    const overdue2Element = document.getElementById('overdue2');

    // 가져온 데이터를 요소에 할당합니다.
    loanName2Element.textContent = loanData.title;
    loanAmount2Element.textContent = Number(loanData.balance).toLocaleString() + '원';
    loanAmountElement.textContent = Number(loanData.balance).toLocaleString() + '원';
    interestRate2Element.textContent  = loanData.interest + '%';
    overdue2Element.textContent = loanData.overdue + '%';
}

function setLoanProductData(loanData){
    const loanNameElement = document.getElementById('loanName');

    const interestRateElement = document.getElementById('interestRate');

    loanNameElement.textContent = loanData.loanPdctNm;
    interestRateElement.textContent = loanData.selectedCreditGrade + '%';
}

function convertToObject(dataStr) {
    // {} 괄호를 제거하고, 콤마(,)로 나누기
    let entries = dataStr.slice(1, -1).split(', ');

    let resultObject = {};

    entries.forEach(entry => {
        let [key, value] = entry.split('=');
        // 숫자인지 문자열인지 판단하여 저장
        resultObject[key] = isNaN(value) ? value : parseFloat(value);
    });

    return resultObject;
}

window.onload = function() {
    // localStorage에서 값을 가져옵니다.
    const retrievedHomtaxData = JSON.parse(localStorage.getItem('homtaxData'));
    const retrievedKcbCreditData = JSON.parse(localStorage.getItem('kcbCreditData'));
    const retrievedLoanProduct = convertToObject(JSON.parse(localStorage.getItem('loanProduct')));
    const retrievedLoanData = convertToObject(JSON.parse(localStorage.getItem('loanData')));


    console.log(retrievedHomtaxData);
    console.log(retrievedKcbCreditData);
    console.log(retrievedLoanProduct);
    console.log(retrievedLoanData);

    // // 화면에 값을 출력하기 위한 함수
    // function displayData(elementId, data) {
    //     const element = document.getElementById(elementId);
    //     element.textContent = JSON.stringify(data, null, 2);
    // }



    setLoanData(retrievedLoanData);
    setLoanProductData(retrievedLoanProduct);
}

var personalId = '${personalId}';
function submitLoanData() {
    // localStorage에서 데이터 가져오기\
    console.log("1");

    const retrievedLoanProduct = convertToObject(JSON.parse(localStorage.getItem('loanProduct')));
    const retrievedLoanData = convertToObject(JSON.parse(localStorage.getItem('loanData')));
    var personalId = '${personalId}';
    // 필요한 데이터만 가져오기
    console.log(retrievedLoanProduct);
    console.log(retrievedLoanData);

    console.log(document.getElementById('loanTerm').value);
    console.log(document.querySelector('select[name="interestPaydate"]').value);
    console.log(document.getElementById('loanPayTypeSelect').value);
    console.log(document.querySelector('select[name="repaymentAccount"]').value);

    const dataToSend = {
        id : retrievedLoanData.id,
        bank : retrievedLoanData.bank,

        loanDataid : retrievedLoanProduct.id,
        fnstDvVal: retrievedLoanProduct.fnstDvVal,
        loanPdctNm: retrievedLoanProduct.loanPdctNm,
        loanLimAmt : retrievedLoanData.balance,
        selectedCreditGrade: retrievedLoanProduct.selectedCreditGrade,
        earlyRepayFee: retrievedLoanProduct.earlyRepayFee,

        loanTerm: document.getElementById('loanTerm').value,
        interestPaydate: document.querySelector('select[name="interestPaydate"]').value,
        loanPayType: document.getElementById('loanPayTypeSelect').value,
        repaymentAccount: document.querySelector('select[name="repaymentAccount"]').value


    };


    // AJAX 요청으로 백엔드에 데이터 전송
    fetch('/api/insertData', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(dataToSend)
    })
        .then(response => response.text())
        .then(data => {
            console.log(data);
            Swal.fire({
                title: '성공!',
                text: '대출 갈아타기 신청이 완료되었습니다.',
                icon: 'success',
                confirmButtonText: '확인'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '/mypage/loanManagement';
                }
            });
        });
}

// 확인 버튼 클릭 시 함수 호출
document.addEventListener("DOMContentLoaded", function() {
    document.getElementById('submitButton2').addEventListener('click', submitLoanData);
});

function updateAccountOptions() {
    var selectedBank = $(".bank-select").val();
    console.log(selectedBank);
    console.log(personalId);
    if (selectedBank !== "하나은행") {
        // 외부 API로 부터 계좌 정보를 가져옵니다.
        $.ajax({
            url: "http://16.171.189.30:8080/gwanjung/", // 실제 API 주소로 변경해야 합니다.
            type: "GET",
            data: {personalId: personalId},
            success: function(data) {
                var options = "";
                $.each(data.accounts, function(index, account) {
                    options += '<option value="' + account.accountId + '">' + account.accountId + '</option>';
                });
                $("#accountSelect").empty().append(options);
            },
            error: function(error) {
                console.log(error);
            }
        });
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const agreeAllButton = document.getElementById('agreeAll');
    agreeAllButton.addEventListener('click', function() {
        const checkboxes = document.querySelectorAll('.form-check-input');
        checkboxes.forEach(function(checkbox) {
            checkbox.checked = true;
        });
    });
});