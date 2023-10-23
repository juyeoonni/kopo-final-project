
function sendSmsRequest() {
    const phoneNumber = document.getElementById('phoneNumber').value;

    const ouathNum = String(Math.floor(10000 + Math.random() * 90000));
    console.log("ouathNum", ouathNum);

    const requestData = {
        recipientPhoneNumber: phoneNumber,
        content: '[하나360] 서류 제출을 위한 인증번호 [' + ouathNum + '] 를 입력하세요.',
        ouathNum: ouathNum // 생성한 무작위 숫자 할당
    };

    $.ajax({
        url: '/sms/sendUser',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function (data) {
            // 성공적인 응답 처리
            console.log('서버 응답:', data);
            // 여기에서 원하는 동작을 수행할 수 있습니다.
        },
        error: function () {
            console.error("사용자에게 인증번호 전송 중 에러");
        }
    });

}

// 본인인증 메세지를 받은 사용자가 인증번호를 입력하면 service에서 동일한지 확인한 후 return
function verifySmsCode() {
    const smsConfirmNum = document.getElementById('userOuathNum').value;

    const resultDiv = document.getElementById('result');

    $.ajax({
        url: '/sms/verify',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({smsConfirmNum: smsConfirmNum}),
        success: function (data) {
            // 성공적인 응답 처리
            console.log('서버 응답:', data);
            if (data === '본인인증성공') {
                resultDiv.textContent = '본인인증성공';
                nextButton.removeAttribute('disabled');  // 다음 버튼 활성화
            } else {
                resultDiv.textContent = '본인인증실패';
            }
        },
        error: function () {
            console.error("본인인증인증과정에러");
        }
    });

}
function showSmsAuthModal() {
    $('#smsAuthModal').modal('show');
}

function closeSmsAuthModal() {
    $('#smsAuthModal').modal('hide');
}


let selectedCarrier = '';

function selectCarrier(element) {
    // 모든 통신사 이미지에서 선택 효과 제거
    const allImages = document.querySelectorAll('.carrier-image');
    for (let img of allImages) {
        img.classList.remove('selected');
    }

    // 클릭된 이미지에 선택 효과 추가
    element.classList.add('selected');
}

let selectedLoanProduct = "${selectedLoanProduct}";
let selectedLoanData = "${selectedLoanData}";
let globalHomtaxData;
let globalKcbAssetsData;
let globalKcbCreditData;


function closePopup2() {
    const popup = document.querySelector('.popup-content');
    popup.style.display = 'none';
}
// 서류 조회 버튼 클릭 시 실행될 함수
const showLoading = () => {
    document.getElementById('loadingOverlay').style.display = 'block';
}

const hideLoading = () => {
    document.getElementById('loadingOverlay').style.display = 'none';
}

const showPopup = () => {
    $('#myModal').modal('show');
}

const hidePopup = () => {
    $('#myModal').modal('hide');
}


const getDocument = () => {
    // 본인 인증 모달을 닫습니다.
    closeSmsAuthModal();
    showLoading();


    fetch('/api/document', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => response.json())
        .then(data => {
            console.log(data);

            // 홈택스 정보와 KCB 정보를 가져옵니다.
            const homtaxData = data.homtax[0];
            const kcbCreditData = data.kcbCredit.creditInfos[0];

            // 전역 변수에 데이터 저장
            globalHomtaxData = data.homtax[0];
            globalKcbCreditData = data.kcbCredit.creditInfos[0];

            // 홈택스 데이터를 DOM에 삽입합니다.
            document.getElementById('creditCardUsage').innerText = Number(homtaxData.creditCardUsage).toLocaleString() + '원';
            document.getElementById('debitCardUsage').innerText = Number(homtaxData.debitCardUsage).toLocaleString() + '원';
            document.getElementById('cashReceipt').innerText = Number(homtaxData.cashReceipt).toLocaleString() + '원';
            document.getElementById('annualIncome').innerText = Number(homtaxData.annualIncome).toLocaleString() + '원';
            // KCB 데이터를 DOM에 삽입합니다.

            document.getElementById('creditScore').innerText = kcbCreditData.creditScore + "점";
            document.getElementById('creditPeriodScore').innerText = kcbCreditData.creditPeriodScore + "점";
            document.getElementById('creditRisk').innerText = kcbCreditData.creditRisk + "점";
            document.getElementById('loanScore').innerText = kcbCreditData.loanScore + "점";
            document.getElementById('repaymentScore').innerText = kcbCreditData.repaymentScore + "점";

            hideLoading();
            showPopup();
        })
        .catch(error => {
            console.error('Error:', error);
            hideLoading();
        });
};

function toggleInfo(infoId) {
    const infoElement = document.getElementById(infoId);
    if (infoElement.style.display === "none" || infoElement.style.display === "") {
        infoElement.style.display = "block";
    } else {
        infoElement.style.display = "none";
    }
}


function go() {
    // 여기서 원하는 방식(URL Query Parameters 또는 Local Storage)으로 값을 넘긴다.
    // 예를 들어, Local Storage 방식을 사용하면:

    localStorage.setItem('homtaxData', JSON.stringify(globalHomtaxData));
    localStorage.setItem('kcbAssetsData', JSON.stringify(globalKcbAssetsData));
    localStorage.setItem('kcbCreditData', JSON.stringify(globalKcbCreditData));
    localStorage.setItem('loanProduct', JSON.stringify(selectedLoanProduct));
    localStorage.setItem('loanData', JSON.stringify(selectedLoanData));

    window.location.href = '/loanSwitch/loanSwitchStep5';
}
function submitData() {
    // 데이터를 서버로 전송할 때 사용할 변수들
    const annualIncome = globalHomtaxData.annualIncome;
    const creditCardUsage = globalHomtaxData.creditCardUsage;
    const debitCardUsage = globalHomtaxData.debitCardUsage;
    const cashReceipt = globalHomtaxData.cashReceipt;
    const creditScore = globalKcbCreditData.creditScore;
    const creditPeriodScore = globalKcbCreditData.creditPeriodScore;
    const repaymentScore = globalKcbCreditData.repaymentScore;
    const loanScore = globalKcbCreditData.loanScore;
    const creditRisk = globalKcbCreditData.creditRisk;

    console.log({
        annualIncome,
        creditCardUsage,
        debitCardUsage,
        cashReceipt,
        creditScore,
        creditPeriodScore,
        repaymentScore,
        loanScore,
        creditRisk,
    });






    // 데이터를 서버로 보내는 fetch 요청을 생성
    fetch('/credit-data', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            annualIncome,
            creditCardUsage,
            debitCardUsage,
            cashReceipt,
            creditScore,
            creditPeriodScore,
            repaymentScore,
            loanScore,
            creditRisk,
        }),
    })
        .then((response) => {
            if (response.ok) {
                Swal.fire({
                    title: '성공!',
                    text: '데이터가 성공적으로 제출되었습니다.',
                    icon: 'success',
                    confirmButtonText: '확인'
                }).then((result) => {
                    if (result.isConfirmed) {
                        hidePopup();
                        go();
                    }
                });
            } else {
                Swal.fire({
                    title: '오류!',
                    text: '데이터 제출 중 오류가 발생했습니다.',
                    icon: 'error',
                    confirmButtonText: '확인'
                });
            }
        })
        .catch((error) => {
            console.error('오류 발생:', error);

            Swal.fire({
                title: '오류 발생!',
                text: '네트워크 또는 서버 오류가 발생했습니다.',
                icon: 'error',
                confirmButtonText: '확인'
            });
        });
}