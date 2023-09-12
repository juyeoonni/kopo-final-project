<%@ page import="kr.ac.kopo.final_hanaasset360.vo.UserVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            overdue2Element.textContent = loanData.overdue;
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

            // 화면에 값을 출력하기 위한 함수
            function displayData(elementId, data) {
                const element = document.getElementById(elementId);
                element.textContent = JSON.stringify(data, null, 2);
            }

            // 화면에 각 값을 출력합니다.
            displayData('displayHomtaxData', retrievedHomtaxData);
            displayData('displayKcbCreditData', retrievedKcbCreditData);
            displayData('displayLoanProduct', retrievedLoanProduct);
            displayData('displayLoanData', retrievedLoanData);

            setLoanData(retrievedLoanData);
            setLoanProductData(retrievedLoanProduct);
        }




    </script>

</head>

<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>

<script>
    function submitLoanData() {
        // localStorage에서 데이터 가져오기\
        console.log("1");

        const retrievedLoanProduct = convertToObject(JSON.parse(localStorage.getItem('loanProduct')));
        const retrievedLoanData = convertToObject(JSON.parse(localStorage.getItem('loanData')));

        // 필요한 데이터만 가져오기
        console.log(retrievedLoanProduct);
        console.log(retrievedLoanData);
        console.log(document.getElementById('selectAccountNo').value);
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

                <tr>


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
                <td colspan="4" id="loanName">
                </td>

            </tr>
            <tr>
                <th><span>*</span> 대출신청금액</th>
                <td colspan="4" id="loanAmount"></td>
            </tr>
            <tr>
                <th><span>*</span> 대출금 입금계좌</th>
                <td>
                    <select class="form-select" name="accountNo"
                            id="selectAccountNo">
                        <option value="3212-1231-11111">3212-1231-11111</option>
                    </select>
                </td>
                <th><span>*</span> 희망대출기한</th>
                <td><select class="form-select" name="loanTerm" id="loanTerm">
                    <option value="3">3년</option>
                    <option value="4">4년</option>
                    <option value="5">5년</option>

                </select></td>
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
                    <option value="LM002">원리금균등상환</option>
                    <option value="LM003">원금균등상환</option>
                </select></td>
                <th><span>*</span> 상환계좌</th>
                <td colspan="2"><select class="form-select"
                                        name="repaymentAccount">
                    <option value="3291-1231-1233">3291-1231-1233<option>
                    <option value="6231-2561-1566">6231-2561-1566</option>
                </select></td>

            </tr>
        </table>
        <button class="btn_5" data-bs-toggle="modal"
                data-bs-target="#interestModal" type="button" onclick="javascript:calculateInterest()">
            <span class="material-icons-sharp" style="margin-right: 5px;">calculate</span>월상환금
            비교
        </button>

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

    <div>
        <h3>Homtax Data:</h3>
        <pre id="displayHomtaxData"></pre>

        <h3>KCB Assets Data:</h3>
        <pre id="displayKcbAssetsData"></pre>

        <h3>KCB Credit Data:</h3>
        <pre id="displayKcbCreditData"></pre>

        <h3>Loan Product:</h3>
        <pre id="displayLoanProduct"></pre>

        <h3>Loan Data:</h3>
        <pre id="displayLoanData"></pre>

        <h3>${loggedInUser.getName()}
            ${loggedInUser}
        </h3>
    </div>

        <input type="hidden" id="loggedInUserName" value="${loggedInUser.getName()}">
</div>

</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>