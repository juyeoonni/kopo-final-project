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
        /* 공통 스타일 */
        .container {
            max-width: 600px; /* 원하는 최대 너비 설정 */
            max-height: 500px;
            margin: 0 auto; /* 가운데 정렬 */
            padding: 20px;
        }

        .loan-process {
            text-align: center;
        }

        .loan-doc-card {

            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            text-align: center;
        }

        .image-placeholder {
            width: 150px; /* 원하는 이미지 너비 설정 */
            height: 150px; /* 원하는 이미지 높이 설정 */
            background-color: #f5f5f5; /* 플레이스홀더 배경색 */
            border-radius: 10px;
            margin: 20px auto;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .retrieve-doc-btn {
            display: block;
            width: 200px;
            padding: 10px;
            background-color: #007BFF; /* 버튼 배경색 */
            color: #ffffff; /* 버튼 글씨색 */
            border: none;
            border-radius: 5px;
            margin: 20px auto;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .retrieve-doc-btn:hover {
            background-color: #0056b3; /* 버튼 호버시 배경색 */
        }

        .loading-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 9999;
        }

        .loading-icon {
            position: absolute;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
        }

        .popup-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 10000;
        }

        .popup-content {
            position: absolute;
            top: 50%; left: 50%;
            width: 600px;
            height: 600px;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        .popup-close-btn {
            position: absolute;
            top: 10px; right: 10px;
            cursor: pointer;
        }

        .popup-image img {
            width: 100px;
            margin-right: 20px;
        }
        .close-btn {
            position: absolute;
            right: 10px;
            top: 10px;
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
    </style>
    <script>

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
            document.querySelector('.popup-content').style.display = 'block';
        }

        const hidePopup = () => {
            document.querySelector('.popup-content').style.display = 'none';
        }


        const getDocument = () => {
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
                    document.getElementById('creditCardUsage').innerText = homtaxData.creditCardUsage;
                    document.getElementById('debitCardUsage').innerText = homtaxData.debitCardUsage;
                    document.getElementById('cashReceipt').innerText = homtaxData.cashReceipt;
                    document.getElementById('annualIncome').innerText = homtaxData.annualIncome;
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
                        alert('데이터가 성공적으로 제출되었습니다.');
                    } else {
                        alert('데이터 제출 중 오류가 발생했습니다.');
                    }
                })
                .catch((error) => {
                    console.error('오류 발생:', error);
                    alert('네트워크 또는 서버 오류가 발생했습니다.');
                });
        }


    </script>
</head>
<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<h2>Selected Loan Product</h2>
<p>${selectedLoanProduct}</p>

<h2>Selected Loan Data</h2>
<p>${selectedLoanData}</p>

<h2>Credit Data</h2>
<p>${creditData}</p>
${loggedInUser}
<h2>주민번호</h2>
<p></p>
<body>
<div class ="title--submit">
    <h1>대출 신청</h1>
</div>

<div class="loan-process container">
    <p style="color: lightblue; font-size: small;">오늘 오후 4시까지 대출 진행할 수 있어요</p>
    <h3 style="color: black;">대출심사를 위한 서류준비</h3>

    <div class="loan-doc-card">
        <h4 style="font-size: medium; color: black;">한 번에 가져오기</h4>
        <p style="font-size: smaller; color: gray;">공공마이데이터로 안전하고 간편하게</p>
        <div class="image-placeholder">
            <img src = "/img/document.jpg" alt="검색어" width="180px" height="180px">
        </div>
    </div>
    <br />
    <p style="color: darkgray; font-weight: bold;">확인해주세요</p>
    <p style="color: gray;">그에 대한 설명들을 해줘</p>

    <button class="retrieve-doc-btn" onclick="getDocument()">한번에 서류 조회</button>
    <!-- 서류조회 로딩 인디케이터 -->
    <div class="loading-overlay" id="loadingOverlay">
        <img src="/img/loading.gif" alt="Loading..." class="loading-icon">
    </div>

    <div class="popup-content" style="display: none;">
        <!-- 홈택스 정보 --> <button onclick="closePopup2()">Close</button>


        국세청, 올크레딧 스크래핑이 완료되었습니다.
        <div class="popup-image">
            <img src="/img/homtax-image.jpg" alt="Homtax" width="100px" height="100px">
            <button onclick="toggleInfo('homtaxInfo')">홈택스 자세히 보기</button>
            <div id="homtaxInfo" style="display: none;">
                <p>연소득: <span id="annualIncome">불러오는 중...</span></p>
                <p>신용카드 사용액: <span id="creditCardUsage">불러오는 중...</span></p>
                <p>직불카드 사용액: <span id="debitCardUsage">불러오는 중...</span></p>
                <p>현금영수증: <span id="cashReceipt">불러오는 중...</span></p>
            </div>
        </div>
        <!-- KCB 정보 -->
        <div class="popup-image">
            <img src="/img/kcb-image.png" alt="KCB" width="100px" height="100px">
            <button onclick="toggleInfo('kcbInfo')">KCB 자세히 보기</button>
            <div id="kcbInfo" style="display: none;">
                <p>신용 점수: <span id="creditScore">불러오는 중...</span></p>
                <p>신용거래점수: <span id="creditPeriodScore">불러오는 중...</span></p>
                <p>상환점수: <span id="repaymentScore">불러오는 중...</span></p>
                <p>부채점수: <span id="loanScore">불러오는 중...</span></p>
                <p>신용위험도점수: <span id="creditRisk">불러오는 중...</span></p>
            </div>
        </div>
        <button id="submitDataButton" onclick="submitData()">제출</button>

    </div>


    <button class="gostep5" onclick="go()">다음</button>

</div>

</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>