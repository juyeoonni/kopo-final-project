
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
    document.getElementById('smsAuthModal').style.display = 'block';
}

function closeSmsAuthModal() {
    document.getElementById('smsAuthModal').style.display = 'none';
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