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
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Bootstrap JS library -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        /* 기본 스타일 */
        .loan--audit--title {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            background-color: #f4f4f4;
        }

        .loan--audit--title, .firm_cal_head {
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .firm_cal_check {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* 테이블 스타일 */
        .loan_apply_table {
            width: 100%;
            border-collapse: collapse;
        }

        .loan_apply_table th, .loan_apply_table td {
            padding: 15px;
            border: 1px solid #e6e6e6;
        }

        .loan_apply_table th {
            background-color: #f7f7f7;
            font-weight: 600;
        }

        .form-control, .form-select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        /* 체크박스 스타일 */
        .form-check-input {
            margin-right: 10px;
            transform: scale(1.2);
        }

        .applyCheck {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .downloadApply img {
            width: 24px;
            margin-right: 10px;
        }
        .all-agree-btn {
            margin-top: 20px;
            text-align: center;
        }

        #agreeAll {
            padding: 10px 20px;
            background-color: #007BFF;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #agreeAll:hover {
            background-color: #0056b3;
        }

        .container mt-5 {
            z-index : -1;
        }

        .step.active .circle {
            background-color: #60ca91;
            color: white;
        }
        .step {
            text-align: center;
            width: 25%;
            position: relative;
            z-index: -1; /* 기본적으로 모든 단계의 z-index를 1로 설정 */
        }

        .circle {
            width: 30px;
            height: 30px;
            background-color: #e9ecef;
            border-radius: 50%;
            color: black;
            line-height: 30px;
            margin: 0 auto;
            z-index: 1; /* 원에도 z-index 1을 설정하여 원이 연결선 위에 올라오도록 함 */
            position: relative;
        }

        .step p {
            margin-top: 10px;
        }

        .step::before {
            content: "";
            position: absolute;
            top: 15px;
            left: 50%;
            right: -50%;
            height: 2px;
            background-color: #e9ecef;
        }

        .step:last-child::before,
        .step.last::before {
            /* 마지막 단계에서 연결선을 숨김 */
            display: none;
        }

        .step.active .circle {
            background-color: #60ca91;
            color: white;
        }
        #submitButton2 {
            background-color: #4CAF50; /* 버튼의 배경색 */
            color: white; /* 버튼의 글씨색 */
            padding: 10px 20px; /* 버튼 내부의 상하, 좌우 패딩 */
            border: none; /* 테두리 제거 */
            border-radius: 4px; /* 버튼의 모서리 둥글게 */
            cursor: pointer; /* 마우스 포인터가 버튼 위에 올라갔을 때의 모양 */
            font-size: 16px; /* 글씨 크기 */
            transition: 0.3s; /* 애니메이션 효과 시간 */
        }

        #submitButton2:hover {
            background-color: #45a049; /* 마우스 호버 시 버튼의 배경색 */
        }
        .custom-table td,
        .custom-table th {
            padding: 20px 8px;  /* 20px는 세로 패딩, 8px는 가로 패딩입니다. 원하는 값으로 조절할 수 있습니다. */
        }

        .custom-select-height {
            height: 50px;  /* 원하는 높이로 설정 */
        }


    </style>
    <script>
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




    </script>

</head>

<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>

<script>
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
                alert("대출 갈아타기 신청이 완료되었습니다.");  // 사용자에게 알림 표시
                window.location.href = '/mypage/loanManagement';  // 다른 페이지로 이동
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
</script>

<body>
<div class="container mt-5">
    <ul class="list-unstyled d-flex justify-content-between">
        <li class="step">
            <div class="circle">1</div>
            <p>대출 상세</p>
        </li>
        <li class="step">
            <div class="circle">2</div>
            <p>약관동의</p>
        </li>
        <li class="step">
            <div class="circle">3</div>
            <p>서류제출</p>
        </li>
        <li class="step last active">
            <div class="circle">4</div>
            <p>대출 신청</p>
        </li>
    </ul>
</div>
<div class="container mt-5">
    <b style="font-size: 40px;" class="mb-5">대출 신청</b>

    <hr>

    <!-- 기존 대출 -->
    <div class="card mb-4">
        <div class="card-body">
            <b style="font-size: 20px;" class="card-title mb-4">기존 대출</b>
            <hr>
            <table class="table table-bordered">
                <tr>
                    <th><span class="text-danger">*</span> 대출종류</th>
                    <td colspan="4" id="loanName2"></td>
                    <th><span class="text-danger">*</span> 대출신청금액</th>
                    <td colspan="4" id="loanAmount2"></td>
                </tr>
                <tr>
                    <th><span class="text-danger">*</span> 대출이자</th>
                    <td colspan="4" id="interestRate2"></td>
                    <th><span class="text-danger">*</span>중도상환수수료</th>
                    <td colspan="4" id="overdue2"></td>
                </tr>
            </table>
        </div>
    </div>

    <!-- 갈아탈 대출 -->
    <div class="card mb-4">
        <div class="card-body">
            <b style="font-size: 20px;" class="card-title mb-8">갈아탈 대출</b>
            <hr>
            <table class="table table-bordered">
                <tr>
                    <th><span class="text-danger">*</span> 대출종류</th>
                    <td colspan="1" id="loanName"></td>
                    <th><span class="text-danger">*</span>대출금 상환은행</th>
                    <td colspan="2">
                        <select class="form-control custom-select-height" name="bankName" onchange="updateAccountOptions()">
                            <option value="하나은행">하나은행</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><span class="text-danger">*</span> 대출신청금액</th>
                    <td colspan="1" id="loanAmount"></td>
                    <th><span class="text-danger">*</span>대출금 상환계좌</th>
                    <td colspan="2">
                        <select class="form-control custom-select-height" name="repaymentAccount" id="accountSelect">
                            <c:forEach var="account" items="${accounts}">
                                <option value="${account.accountId}">${account.accountId}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><span class="text-danger">*</span> 대출이자</th>
                    <td id="interestRate"></td>
                    <th><span class="text-danger">*</span> 이자납부일</th>
                    <td colspan="4">
                        <select class="form-control custom-select-height" name="interestPaydate">
                            <option value="1">매달 1일</option>
                            <option value="5">매달 5일</option>
                            <option value="10">매달 10일</option>
                            <option value="15">매달 15일</option>
                            <option value="20">매달 20일</option>
                            <option value="25">매달 25일</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><span class="text-danger">*</span> 상환방법</th>
                    <td>
                        <select class="form-control custom-select-height" name="loanPayType" id="loanPayTypeSelect">
                            <option value="원리금균등방식">원리금균등방식</option>
                            <option value="원금균등방식">원금균등방식</option>
                        </select>
                    </td>
                    <th><span class="text-danger">*</span> 희망대출기한</th>
                    <td>
                        <select class="form-control custom-select-height" name="loanTerm" id="loanTerm">
                            <option value="3">3년</option>
                            <option value="4">4년</option>
                            <option value="5">5년</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <!-- 대출약관동의 -->
    <div class="card mb-4">
        <div class="card-header">
            <h4>대출약관동의</h4>
        </div>
        <div class="card-body">
            <div class="form-check d-flex mb-2">
                <input class="form-check-input" type="checkbox" id="agree1">
                <label class="form-check-label" for="agree1">은행여신거래기본약관에 동의합니다.</label>
                <a href="#" class="ml-auto d-inline-block"><img src="/resources/img/pdf-file.png" alt=""> 은행여신거래기본약관</a>
            </div>
            <div class="form-check d-flex mb-2">
                <input class="form-check-input" type="checkbox" id="agree2">
                <label class="form-check-label" for="agree2">여신거래약정서에 동의합니다.</label>
                <a href="#" class="ml-auto d-inline-block"><img src="/resources/img/pdf-file.png" alt=""> 여신거래약정서</a>
            </div>
            <div class="form-check d-flex mb-2">
                <input class="form-check-input" type="checkbox" id="agree3">
                <label class="form-check-label" for="agree3">기업대출상품설명서를 읽고 이해했으며 동의합니다.</label>
                <a href="#" class="ml-auto d-inline-block"><img src="/resources/img/pdf-file.png" alt=""> 기업대출상품설명서</a>
            </div>
            <div class="form-check d-flex mb-2">
                <input class="form-check-input" type="checkbox" id="agree4">
                <label class="form-check-label" for="agree4">재무상태표 열람에 동의합니다.</label>
                <a href="#" class="ml-auto d-inline-block"><img src="/resources/img/pdf-file.png" alt=""> 열람동의서</a>
            </div>
            <div class="text-center mt-4">
                <button id="agreeAll" class="btn btn-primary">모두 동의하기</button>
            </div>
        </div>
    </div>

    <div class="text-center mb-5">
        <button id="submitButton2" class="btn btn-primary">확인</button>
    </div>
</div>


</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>