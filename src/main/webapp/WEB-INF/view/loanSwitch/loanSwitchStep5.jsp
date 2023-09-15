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
            loanAmount2Element.textContent  = loanData.balance + '원';
            loanAmountElement.textContent  = loanData.balance + '원'
            interestRate2Element.textContent  = loanData.interest + '%';
            overdue2Element.textContent = loanData.overdue + '%';
        }

        function setLoanProductData(loanData){
            const loanNameElement = document.getElementById('loanName');

            const interestRateElement = document.getElementById('interestRate');

            loanNameElement.textContent = loanData.loanPdctNm;
            interestRateElement.textContent = loanData.selectedCreditGrade;
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
            loanLimAmt : retrievedLoanProduct.loanLimAmt,
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
</script>

<body>
    <div class="firm_cal_check">
        <div class = "loan--audit--title">
            <h1>대출 신청</h1>
            <br />

            <h2>기존 대출</h2>
            <table class="loan_apply_table">
                <tr>
                    <th><span>*</span> 대출종류</th>
                    <td colspan="4" id="loanName2"></td>
                    <th><span>*</span> 대출신청금액</th>
                    <td colspan="4" id="loanAmount2"></td>
                </tr>
                <tr>
                    <th><span>*</span> 대출이자</th>
                    <td colspan="4" id="interestRate2"></td>
                    <th><span>*</span>중도상환수수료</th>
                    <td colspan="4" id="overdue2"></td>
                </tr>

                <!-- ... 기존 코드 ... -->
            </table>
            <br/>
    </div>
    <div class="firm_cal_check">
        <h2>갈아탈 대출</h2>
        <table class="loan_apply_table">
            <tr>
                <th><span>*</span> 대출종류</th>
                <td colspan="1" id="loanName">
                </td>

                <th><span>*</span>대출금 상환은행</th>
                <td colspan="2">
                    <select class="form-select bank-select" name="bankName" onchange="updateAccountOptions()">
                        <option value="하나은행">하나은행</option>
                        <option value="우리은행">우리은행</option>

                    </select>
                </td>

            </tr>
            <tr>
                <th><span>*</span> 대출신청금액</th>
                <td colspan="1" id="loanAmount"></td>

                <th><span>*</span>대출금 상환계좌</th>
                <td colspan="2" id="accountContainer">
                    <!-- 기본적으로는 하나은행의 계좌정보를 보여줍니다. -->
                    <select class="form-select" name="repaymentAccount" id="accountSelect">
                        <c:forEach var="account" items="${accounts}">
                            <option value="${account.accountId}">${account.accountId}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>




            </tr>
            <tr>
                <th><span>*</span> 대출이자</th>
                <td id="interestRate"></td>

                <th><span>*</span> 이자납부일</th>
                <td colspan="4"><select class="form-select"
                                        name="interestPaydate">
                    <option value="1">매달 1일</option>
                    <option value="5">매달 5일</option>
                    <option value="10">매달 10일</option>
                    <option value="15">매달 15일</option>
                    <option value="20">매달 20일</option>
                    <option value="25">매달 25일</option>
                </select></td>
            </tr>
            <tr>
                <th><span>*</span> 상환방법</th>
                <td><select class="form-select" name="loanPayType"
                            id="loanPayTypeSelect">
                    <option value="원리금균등상환">원리금균등상환</option>
                    <option value="원금균등상환">원금균등상환</option>
                </select></td>
                <th><span>*</span> 희망대출기한</th>
                <td><select class="form-select" name="loanTerm" id="loanTerm">
                    <option value="3">3년</option>
                    <option value="4">4년</option>
                    <option value="5">5년</option>

                </select></td>

            </tr>
        </table>


    </div>
    <div class = "agree-apply">
        <div class="firm_cal_head" style="margin-top: 80px;">
            <div class="d-flex" style="margin-bottom: 10px;">
                <span class="material-icons-sharp" style="margin-right: 5px"></span>
                <h4>대출약관동의</h4>
            </div>
        </div>

        <div class="firm_cal_check">
            <div class="applyCheck">
                <div class="d-flex justify-content-center align-items-center">
                    <input class="form-check-input" type="checkbox" id=""
                           style="margin-right: 10px;">
                    <p>은행여신거래기본약관에 동의합니다.</p>
                </div>
                <a href="#" class="downloadApply"> <img
                        src="/resources/img/pdf-file.png" alt="">
                    <p>은행여신거래기본약관</p>
                </a>
            </div>
            <div class="applyCheck">
                <div class="d-flex justify-content-center align-items-center">
                    <input class="form-check-input" type="checkbox"
                           style="margin-right: 10px;">
                    <p>여신거래약정서에 동의합니다.</p>
                </div>
                <a href="#" class="downloadApply"> <img
                        src="/resources/img/pdf-file.png" alt="">
                    <p>여신거래약정서</p>
                </a>
            </div>
            <div class="applyCheck">
                <div class="d-flex justify-content-center align-items-center">
                    <input class="form-check-input" type="checkbox"
                           style="margin-right: 10px;">
                    <p>기업대출상품설명서를 읽고 이해했으며 동의합니다.</p>
                </div>
                <a href="#" class="downloadApply"> <img
                        src="/resources/img/pdf-file.png" alt="">
                    <p>기업대출상품설명서</p>
                </a>
            </div>
            <div class="applyCheck">
                <div class="d-flex justify-content-center align-items-center">
                    <input class="form-check-input" type="checkbox"
                           style="margin-right: 10px;">
                    <p>재무상태표 열람에 동의합니다.</p>
                </div>
                <a href="#" class="downloadApply"> <img
                        src="/resources/img/pdf-file.png" alt="">
                    <p>열람동의서</p>
                </a>
            </div>
            <div class="all-agree-btn">
                <button id="agreeAll">모두 동의하기</button>
            </div>
        </div>

    </div>
        <button id = "submitButton2">확인</button>

        <input type="hidden" id="loggedInUserName" value="${loggedInUser.getName()}">
</div>

</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>