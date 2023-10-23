<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>대출 갈아타기</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/loan/loanSwitchStep2.css">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Bootstrap JS library -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <script>
        function formatAmount(amount) {
            if (amount >= 100000000) { // 1억 이상일 경우
                return (amount / 100000000) + "억원";
            } else if (amount >= 10000) { // 1만 이상일 경우
                return (amount / 10000) + "만원";
            } else {
                return amount + "원";
            }
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

        document.getElementById('step1').classList.remove('active');
        document.getElementById('step2').classList.add('active');


    </script>
</head>
<header class="header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
    <br />
    <div class="container mt-5">
        <ul class="list-unstyled d-flex justify-content-between">
            <li class="step active">
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
            <li class="step last">
                <div class="circle">4</div>
                <p>대출 신청</p>
            </li>
        </ul>
    </div>
    <div class="title-container">
        <b style="font-size: 35px">대출 상세</b>

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


    <div class="d-flex justify-content-center mt-4">
        <button type="submit" class="green-btn" onclick="sendData()">다음으로</button>
    </div>

    <br>


    <div class="loan--explain" style="width: 70%; margin: 0 auto;">
        <h2>대출 대상</h2>
        <ul>
            <li>현 직장 6개월이상 국민건강보험 직장인 가입 손님으로 스크래핑에 의해 건강보험료 6개월이상 정상 납입 손님</li>
            <li>CB사 소득에 의해 대출한도가 산정되는 손님</li>
            <li>하나원큐신용대출 갈아타기(타행대환) : 타행대출 보유하여 대환 요구가 있는 손님</li>
        </ul>
        <p class="highlight">대출한도: <fmt:formatNumber value="${selectedLoanProduct.loanLimAmt}" pattern="#,##0" />원 (단, 최저 50만원부터 10만원 단위로 신청 가능)</p>
        <p>최대 대출기간: 5년</p>
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
            <li><p class="highlight">*중도 상환 해약금율: ${selectedLoanProduct.earlyRepayFee} % </p></li>
        </ul>
    </div>

    <br />


</main>

<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>
    <script src="/js/loanSwitchStep2.js"></script>
</body>
</html>



</html>
