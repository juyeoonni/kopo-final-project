<%@ page import="kr.ac.kopo.final_hanaasset360.vo.UserVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        /* 공통 스타일 */
        .container {

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
            background-color: #60ca91; /* 버튼 배경색 */
            color: #ffffff; /* 버튼 글씨색 */
            border: none;
            border-radius: 5px;
            margin: 20px auto;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .retrieve-doc-btn:hover {
            background-color: #60ca91; /* 버튼 호버시 배경색 */
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



        .popup-content {
            position: absolute;
            top: 50%; left: 50%;
            width: 500px;
            height: 500px;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }


        /* 이미지 컨테이너 스타일 */
        .popup-image {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .popup-image img {
            margin-right: 10px;
            border-radius: 5px;
        }
        /* 자세히 보기 버튼 스타일 */
        .popup-image button {
            margin-left: auto;
        }
        /* 자세히 보기 내용 스타일 */
        #homtaxInfo, #kcbInfo {
            margin-top: 10px;
            padding: 10px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
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










        #phoneNumber, #userOuathNum {
            height: 30px;
            width:  200px;
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

        .custom-table {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        }

        .custom-table th, .custom-table td {
            padding: 15px;
            border: none !important;
        }

        .custom-table th {
            background-color: #a2eac4;
            color: white;
        }

        .btn-connect {
            background-color: #60ca91;
            border-color: #60ca91;
        }


        .btn-connect:hover {
            background-color: #4fa97a; /* 조금 더 어두운 색상으로 설정하여 호버 효과 추가 */
            border-color: #4fa97a;
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
                        alert('데이터가 성공적으로 제출되었습니다.');

                        hidePopup();
                        go();
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


<div class=" mt-5">
    <ul class="list-unstyled d-flex justify-content-between">
        <li class="step">
            <div class="circle">1</div>
            <p>대출 상세</p>
        </li>
        <li class="step">
            <div class="circle">2</div>
            <p>약관동의</p>
        </li>
        <li class="step active">
            <div class="circle">3</div>
            <p>서류제출</p>
        </li>
        <li class="step last">
            <div class="circle">4</div>
            <p>대출 신청</p>
        </li>
    </ul>
</div>
<body>

<div class="loan-process container mt-5">
    <div class="title-container mb-4">
        <b style="font-size: 35px; font-family: 'Roboto', sans-serif;">서류제출</b>
    </div>

    <p class="text-primary mb-4" style="font-size: small; font-family: 'Roboto', sans-serif;">오늘 오후 4시까지 대출 진행할 수 있어요</p>
    <h3 class="mb-4" style="color: black; font-family: 'Roboto', sans-serif;">대출심사를 위한 서류준비</h3>

    <div class="loan-doc-card mb-4 mx-auto col-6">
        <h4 class="mb-2" style="font-size: medium; color: black; font-family: 'Roboto', sans-serif;">한 번에 가져오기</h4>
        <p class="text-muted mb-4" style="font-size: smaller;">공공마이데이터로 안전하고 간편하게</p>
        <div class="image-placeholder mb-4 text-center">
            <img src="/img/document.jpg" alt="검색어" class="img-fluid rounded-circle">
        </div>
    </div>

    <button class="btn btn-success btn-connect  mb-4 retrieve-doc-btn" onclick="showSmsAuthModal()">한번에 서류 조회</button>

    <!-- 서류조회 로딩 인디케이터 -->
    <div class="loading-overlay mb-4" id="loadingOverlay">
        <img src="/img/loading.gif" alt="Loading..." class="loading-icon">
    </div>
    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <b class="modal-title">국세청, 올크레딧 스크래핑이 완료되었습니다.</b>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="row">
                        <!-- 홈택스 정보 -->
                        <!-- 홈택스 정보 -->
                        <div class="col-sm-6">
                            <img src="/img/homtax-image.jpg" alt="Homtax" class="img-fluid mb-3" style="max-width: 100px;">
                            <table class="table custom-table" id="homtaxInfo" style="display: none;">
                                <tbody>
                                <tr>
                                    <th>연소득</th>
                                    <td><span id="annualIncome">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>신용카드 사용액</th>
                                    <td><span id="creditCardUsage">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>직불카드 사용액</th>
                                    <td><span id="debitCardUsage">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>현금영수증</th>
                                    <td><span id="cashReceipt">불러오는 중...</span></td>
                                </tr>
                                </tbody>
                            </table>
                            <button class="btn btn-primary mb-2" onclick="toggleInfo('homtaxInfo')">홈택스 자세히 보기</button>
                        </div>

                        <!-- 올크레딧 정보 -->
                        <div class="col-sm-6">
                            <img src="/img/All-credit.png" alt="KCB" class="img-fluid mb-3" style="max-width: 120px;">
                            <table class="table custom-table" id="kcbInfo" style="display: none;">
                                <tbody>
                                <tr>
                                    <th>신용 점수</th>
                                    <td><span id="creditScore">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>신용거래점수</th>
                                    <td><span id="creditPeriodScore">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>상환점수</th>
                                    <td><span id="repaymentScore">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>부채점수</th>
                                    <td><span id="loanScore">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>신용위험도점수</th>
                                    <td><span id="creditRisk">불러오는 중...</span></td>
                                </tr>
                                </tbody>
                            </table>
                            <button class="btn btn-primary mb-2" onclick="toggleInfo('kcbInfo')">올크레딧 자세히 보기</button>
                        </div>
                    </div>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="submitData()">제출</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

<%--    <div class="text-center mt-4" id="gostepdiv">--%>
<%--        <button id="gostep5" class="btn btn-primary" onclick="go()">다음</button>--%>
<%--    </div>--%>
</div>
<!-- 본인인증 모달 -->
<div class="modal" tabindex="-1" role="dialog" id="smsAuthModal">
    <div class="modal-dialog modal-md" role="document"> <!-- 모달 가로 길이 변경 -->
        <div class="modal-content">
            <div class="modal-header">
                <b>휴대폰 본인인증</b>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body pb-0">
                <div class="text-center mb-5 mt-5">
                    <img src="/img/smartphone.png" alt="본인인증" width="180px" height="180px">
                </div>

                <table class="table">
                    <tr>
                        <td><input type="text" class="form-control" id="phoneNumber" placeholder="하이폰(-) 제외"></td>
                        <td><button class="btn btn-primary" onclick="sendSmsRequest()">인증번호 받기</button></td>
                    </tr>
                    <tr>
                        <td><input type="text" class="form-control" id="userOuathNum" placeholder="인증번호를 입력하세요"></td>
                        <td><button class="btn btn-primary" onclick="verifySmsCode()">인증 확인</button></td>
                    </tr>
                </table>

                <div id="result"></div>

                <table class="table">
                    <tr>
                        <td><input type="checkbox" id="privacyPolicy"> 개인정보 수집에 동의합니다</td>
                    </tr>
                </table>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="nextButton" onclick="getDocument()" disabled>다음</button>
            </div>
        </div>
    </div>
</div>


<script src="/js/loanSwitchStep4.js"></script>
</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>