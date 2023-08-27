<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>예금 계산기</title>
    <link rel="stylesheet" href="/css/styles.css">
    <script src="/js/depositCalculator.js"></script>


    <style>
        main {
            width: 50%;
            margin: 0 auto;
            padding: 0 20px;
        }

        #depositCalculator {
            width: 100%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
        }

        #depositCalculator label {
            display: inline-block;
            width: 200px;
            margin-bottom: 10px;
        }

        #depositCalculator input[type=number] {
            width: 200px;
            height: 30px;
            margin-bottom: 10px;
        }

        #depositCalculator input[type=button] {
            width: 100%;
            height: 40px;
            margin-bottom: 10px;
            background-color: #333;
            color: #fff;
            border: none;
        }

        #depositCalculator #result {
            width: 100%;
            height: 100px;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
        }
</style>
</head>
<body>
<div id="container">
    <header class = "header">
        <jsp:include page="../../layout/header.jsp" />
    </header>
    <div class="blank"></div>
    <script src="/js/script.js"></script>
    <main>
        <h2>예금 계산기</h2>
        <p>아래의 정보를 입력하면 필요한 월 납입액을 계산해 드립니다. <br/>
            필요한 정보를 모두 입력한 후 '계산하기' 버튼을 클릭해주세요.</p>

        <section id="depositCalculator">
            <h2>예금 계산기</h2>

            <label for="targetAmount">최종 목표금액:</label>
            <input type="number" id="targetAmount">

            <label for="savingsPeriod">적립 기간(개월):</label>
            <input type="number" id="savingsPeriod">

            <label for="interestRate">연 이율(%):</label>
            <input type="number" id="interestRate">

            <input type="button" value="계산하기" onclick="calculateDeposit()">

            <div id="result"></div>
        </section>
    </main>


    <footer class="footer">
        <jsp:include page="../../layout/footer.jsp" />
    </footer>
</div>

</body>
</html>