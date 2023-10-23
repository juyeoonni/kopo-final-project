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