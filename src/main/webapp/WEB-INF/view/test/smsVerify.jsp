<%@ page import="kr.ac.kopo.final_hanaasset360.vo.UserVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>HanaAsset360</title>
    <link rel="stylesheet" href="/css/styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>


<body>
<%--    알림문자보내기--%>
<div class="form-group">
    <label for="phoneNumber">전화번호</label>
    <div class="input-wrapper">
        <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="010XXXXXXXX" required maxlength="11">
        <!-- <button type="submit" id="sendSmsButton">인증번호 전송</button> -->
        <button onclick="sendSmsRequest()" class="button">인증번호 전송</button>
    </div>
</div>

<input type="tel" id="userOuathNum" name="userOuathNum" placeholder="인증번호입력" required maxlength="5">
<button onclick="verifySmsCode()" class="button">인증번호 확인</button>
<div id="result"></div>

<script>
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
                } else {
                    resultDiv.textContent = '본인인증실패';
                }
            },
            error: function () {
                console.error("본인인증인증과정에러");
            }
        });

    }
</script>
</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>