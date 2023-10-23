<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>적금 계산기</title>
    <link rel="stylesheet" href="/css/styles.css">
    <script src="/js/incomedeductionCalculator.js"></script>
</head>
<body>
<div id="container">
    <header class = "header">
        <jsp:include page="../../layout/header.jsp" />
    </header>
    <div class="blank"></div>
    <script src="/js/script.js"></script>
    <main>
        <h2>소득공제 계산기</h2>
        <p>아래의 정보를 입력하면 예상 소득공제 금액을 계산해 드립니다.</p>
        <!--총급여액에 대한 최대 소득공제 가능 금액 계산:

총급여액 5,000만원의 25% = 1,250만원

각 결제 수단별로 소득공제 가능한 금액 계산:

신용카드: 1,200만원 중 1,250만원까지는 15% 공제
현금영수증: 500만원 중 50만원(1,250만원 - 1,200만원)까지는 30% 공제, 나머지 450만원은 공제 초과
체크카드: 200만원은 모두 공제 초과
공제 금액 계산:

신용카드 공제 금액 = 1,200만원 × 15% = 180만원
현금영수증 공제 금액 = 50만원 × 30% = 15만원
체크카드 공제 금액 = 0만원 (모두 공제 초과)
총 소득공제 금액 = 180만원 + 15만원 = 195만원

세율을 고려한 아낄 수 있는 세금 계산:

아낄 수 있는 세금 = 195만원 × 15% (일반적인 소득세율) = 292,500원

따라서, 급여액 5,000만원, 신용카드 1,200만원, 현금영수증 500만원, 체크카드 200만원을 입력하면 아낄 수 있는 세금은 292,500원입니다. -->
        <form id="taxForm">
            연간 급여액: <input type="number" id="salary" placeholder="예: 1000만원"> 만원<br>
            신용카드(연간): <input type="number" id="creditCard" placeholder="예: 500만원"> 만원<br>
            현금영수증(연간): <input type="number" id="cashReceipt" placeholder="예: 300만원"> 만원<br>
            체크카드(연간): <input type="number" id="checkCard" placeholder="예: 100만원"> 만원<br>
            <input type="button" value="계산하기" onclick="calculateTax()">
        </form>

        <p id="result"></p>
    </main>


    <footer class="footer">
        <jsp:include page="../../layout/footer.jsp" />
    </footer>
</div>

</body>
</html>