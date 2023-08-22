<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>대출 상환 계산기</title>
    <link rel="stylesheet" href="/css/styles.css">
    <script src="/js/loanCalculator.js"></script>
</head>
<body>
<div id="container">
    <header class = "header">
        <jsp:include page="../../layout/header.jsp" />
    </header>
    <div class="blank"></div>
    <script src="/js/script.js"></script>
    <main>
        <h2>대출 상환 계산기</h2>
        <p>아래의 정보를 입력하면 월 상환액을 계산해 드립니다. 필요한 정보를 모두 입력한 후 '계산하기' 버튼을 클릭해주세요.</p>
        <section id="calculator">
            <h2>대출 상환 계산기</h2>

            <label for="loanAmount">대출 금액:</label>
            <input type="number" id="loanAmount">

            <label for="interestRate">연 이율(%):</label>
            <input type="number" id="interestRate">

            <label for="loanPeriod">대출 기간(년):</label>
            <input type="number" id="loanPeriod">

            <label for="repaymentMethod">상환 방식:</label>
            <select id="repaymentMethod">
                <option value="equalPrincipalAndInterest">원리금 균등 상환</option>
                <option value="interestOnly">이자만 상환</option>
                <option value="equalPrincipal">원금 균등 상환</option>
            </select>

            <input type="button" value="계산하기" onclick="calculateRepayment()">

            <div id="result">월 상환액: <span id="monthlyRepayment"></span></div>
        </section>
    </main>


    <footer class="footer">
        <jsp:include page="../../layout/footer.jsp" />
    </footer>

</div>

</body>
</html>
