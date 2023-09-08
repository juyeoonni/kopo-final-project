<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>대출 갈아타기</title>
    <link rel="stylesheet" href="/css/styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        main {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 80vh; /* viewport 높이의 80%만큼 main 높이 설정 */
        }
        .agreement label {
            margin-left: 10px;
        }

        .action-button {
            text-align: center;
        }

        .loan-card h2 {
            text-align: center;
            background-color: #e6e6e6;
            padding: 10px;
            margin: 0;
            border-bottom: 1px solid #d1d1d1;
        }

        .loan-card ul {
            list-style-type: none;
            padding: 0;
        }

        .loan-card li {
            padding: 10px;
            border-bottom: 1px solid #d1d1d1;
        }

        .loan-card li:last-child {
            border-bottom: none;
        }
        /* 원 크기 및 배치 조정 */
        .highlight-circle {
            width: 230px; /* 원 크기 조정 */
            height: 230px; /* 원 크기 조정 */
            margin-right: -30px; /* 원들이 약간 겹치게 만드는 부분 */
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            z-index: 1; /* 겹칠 때의 레이어 순서를 조절 */
        }
        .highlight-info {
            display: flex;
            justify-content: center; /* 가운데 정렬 */
            align-items: flex-start;
            margin-top: 100px;
            flex-wrap: nowrap; /* 원들이 줄 바꿈 없이 가로로 배열되게 함 */
        }
        .highlight-container:first-child .highlight-circle {
            background-color: rgba(255, 215, 0, 0.7); /* 첫 번째 원의 배경색 */
        }

        .highlight-container:nth-child(2) .highlight-circle {
            background-color: rgba(173, 216, 230, 0.7); /* 두 번째 원의 배경색 */
        }
        .highlight-container:nth-child(3) .highlight-circle {
            background-color: rgba(255, 215, 0, 0.7);  /* 세 번째 원의 배경색 */
        }

        .highlight-container:last-child .highlight-circle {
            background-color: rgba(173, 216, 230, 0.7); /* 마지막 번째 원의 배경색 */
        }


        .green-btn {
            white-space: nowrap;
            background-color: #60ca91;
            color: #fff;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;

        }
        .green-btn-form{
            margin : 3%;
        }
        .title-container {
            text-align: left; /* 텍스트 중앙 정렬 */
            margin-left: auto;  /* 중앙으로 이동 */
            margin-right: auto; /* 중앙으로 이동 */
            max-width: 70%;     /* 컨테이너 최대 너비 설정 */
        }

        .highlight-info {
            margin-top: 0; /* 원들의 위치를 위로 조정 */
            /* ... 기존의 스타일 ... */
        }

        .loan-description {
            width: 70%;          /* 화면의 70% 너비 사용 */
            margin-left: 30%;    /* 왼쪽의 30% 위치에 배치 */
            text-align: left;    /* 텍스트를 왼쪽에 정렬 */
            margin-top: 50px;    /* 원들과의 간격 조정을 위해 상단 마진 추가 */
            margin-bottom: 5%; /* 하단 마진도 추가하여 밸런스를 맞춤 */
        }

        .loan-description h2 {
            font-size: 24px;     /* 제목 글꼴 크기 */
            margin-bottom: 10px;/* 제목과 설명 사이의 간격 조정 */
        }

        .loan-description p {
            font-size: 18px;     /* 설명 글꼴 크기 */
            color: #666;        /* 설명 텍스트 색상 */
        }
        .circle-value {
            display: block;
            font-size: 24px;
        }

        .circle-label {
            display: block;
            font-size: 20px;
            margin-top: 10px; /* 원과의 간격 조정 */
            color: #666;
        }
        .highlight-container {
            display: inline-block;
            text-align: center;  /* 중앙 정렬 */
            margin-right: 18px; /* 원 사이의 간격 */
        }

        .loan--explain {
            font-family: Arial, sans-serif;
            padding: 20px;
            border: 1px solid #e1e1e1;
            background-color: #f9f9f9;
            border-radius: 8px;
            width: 60%;          /* 화면의 70% 너비 사용 */
            margin-left: 5%;    /* 왼쪽의 30% 위치에 배치 */
        }

        .loan--explain h2 {
            color: #333;
            border-bottom: 2px solid #666;
            margin-bottom: 10px;
            padding-bottom: 5px;
        }

        .loan--explain p {
            color: #555;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .loan--explain ul {
            list-style-type: disc;
            padding-left: 20px;
        }

        .loan--explain li {
            margin-bottom: 10px;
        }

        .loan--explain .note {
            margin-left: 20px;
            color: #999;
            font-style: italic;
            font-size: 0.9em;
        }

        .loan--explain .highlight {
            color: #d9534f;
            font-weight: bold;
        }
    </style>
    <script>

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
    </script>
</head>
<header class="header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
    <br />
    <div class="title-container">
        <h1>대출 상세</h1>
${selectedLoanProduct}
${selectedLoanData}
        ${creditData}

    </div>
    <div class="loan-description">
        <h2>${selectedLoanProduct.loanPdctNm}</h2>
        <br />
        <p>소득이 있는 국민인거주자를 위한 대출 갈아타기 신용상품입니다.</p>
    </div>
<main>

    <div class="highlight-info">
        <div class="highlight-container">
            <div class="highlight-circle">
                <span class="circle-value">${selectedLoanProduct.loanLimAmt}원</span>
            </div>
            <span class="circle-label">한도</span>
        </div>
        <div class="highlight-container">
            <div class="highlight-circle">
                <strong class="circle-value">5년</strong>
            </div>
            <span class="circle-label">대출 기간</span>
        </div>
        <div class="highlight-container">
            <div class="highlight-circle">
                <strong class="circle-value">${selectedLoanProduct.selectedCreditGrade}%</strong>
            </div>
            <span class="circle-label">금리</span>
        </div>
        <div class="highlight-container">
            <div class="highlight-circle">
                <strong class="circle-value">${selectedLoanProduct.earlyRepayFee}%</strong>
            </div>
            <span class="circle-label">중도상환수수료</span>
        </div>
    </div>



    <br />


    <button type="submit" class="green-btn" onclick="sendData()">다음으로</button>

    <div class="loan--explain">
        <h2>대출 대상</h2>
        <ul>
            <li>현 직장 6개월이상 국민건강보험 직장인 가입 손님으로 스크래핑에 의해 건강보험료 6개월이상 정상 납입 손님</li>
            <li>CB사 소득에 의해 대출한도가 산정되는 손님</li>
            <li>하나원큐신용대출 갈아타기(타행대환) : 타행대출 보유하여 대환 요구가 있는 손님</li>
        </ul>
        <p class="highlight">대출한도: ${selectedLoanProduct.loanLimAmt} (단, 최저 50만원부터 10만원 단위로 신청 가능)</p>
        <p>대출기간: 5년</p>
        <h2>상환 방식</h2>
        <p>만기일시상환(일시상환, 통장대출)</p>
        <p>이자 계산 방법: 대출금에 연이율과 대출일수를 곱한 후 365일(윤년인 경우 366일)로 나누어 산출. 원단위 미만은 절사.</p>
        <h3>이자계산 방법</h3>
        <p>대출금에 연이율과 대출일수를 곱한 후 이를 365일(윤년인 경우 366일)로 나누어 산출하되 원단위 미만은 절사</p>
        <p>원리금균등분할상환대출의 월별이자 계산은 대출원금에 연이율을 곱한 다음 12로 나누어 계산</p>
        <p>일수 계산은 여신당일로부터 기일 또는 상환일 (일부상환 또는 분할상환 포함)전일까지로 한다.<span>(한편넣기)</span></p>
        <p>위 내용에도 불구하고 다음의 여신은 여신당일부터 기일 또는 상환일까지로 한다.</p>
        <ul>
            <li>대출 당일에 회수되는 대출금</li>
            <li>대외기관으로부터 자금을 차입하는 대출금으로서 이자를 상환일까지 지급하는 대출금</li>
            <li>연체기간이 1일인 연체대출채권 및 지급보증대지급금</li>
            <li>대여유가증권</li>
        </ul>
        <p>원금 균등분할상환대출 : 대출금액 x 대출이자율 x 이자일수 ÷ 365(윤년은 366일)</p>
        <p>원리금 균등분할상환대출 : 대출금액 × 대출이자율 ÷ 12</p>

        <h3>원금 또는 이자의 상환시기 및 방법</h3>
        <ul>
            <li>건별대출(만기일시상환) : 원금은 만기에 일시상환, 이자는 일정주기(매1개월 등)단위로 납부</li>
            <li>한도대출(마이너스통장) : 원금은 만기에 일시상환, 이자는 일정주기(매1개월 등)단위로 납부</li>
            <li>분할상환대출 : 분할상환원금 및 이자를 일정주기(매1개월 등) 단위로 납부</li>
        </ul>
        <p>대출실행 응당일/별도지정일에 대출금 입금계좌/자동등록계좌에서 자동이체 처리</p>
        <p>손님이 선택하시는 대출방식 및 상품별로 원금/이자의 상환시기 및 방법이 일부 상이할 수 있으므로, 대출 취급시 작성하시는 대출거래약정서의 상환 방법 및 이자지급방법 내용을 참조하여 주시기 바랍니다.</p>

        <h3>이용시간</h3>
        <p>고객센터의 인터넷뱅킹 이용시간 안내를 참조하시기 바랍니다.<a href="#">바로가기 ></a></p>

        <h3>계약해지 또는 갱신방법</h3>
        <ul>
            <li>건별대출 계약해지 : 손님이 대출금 전액을 상환한 때</li>
            <li>한도대출(마이너스통장방식) 계약해지 : 손님이 통장대출 약정에 대한 해지의사를 표시한 때</li>
        </ul>
        <p>계약갱신 : 대출금은 약정기일(만기일)에 상환이 원칙이나, 당행에서 정한 일정요건을 갖춘 경우 기간연장 가능</p>
        <p>※ 대출기간 만료시 은행이 정한 기준에 따라 기간연장 가능여부 심사 후 승인을 득한 경우 계약갱신 가능하며, 손님의 신용도, 대출상품 등에 따라 영업점방문/고객센터 연장/ 전자금융채널(인터넷뱅킹· 스마트폰뱅킹)등의 방법을 통해 연장 가능합니다.</p>

        <h3>중도상환 해약금</h3>
        <p>하나원큐신용대출: 없음</p>
        <p>하나원큐신용대출 갈아타기(타행대환): 중도상환대출금액 X 중도상환해약금율* X 대출잔여일수 / 대출기간</p>
        <ul>
            <li>- 최초 대출일로부터 3년(기한연장 포함)까지 적용합니다.</li>
            <li>- 대출잔여기간 3개월 이내 상환 시 면제</li>
            <li>*중도 상환 해약금율: 0.5%</li>
        </ul>
    </div>

    <br />



    <section>


    </section>
</main>

<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>
</body>
</html>



</html>
