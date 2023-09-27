<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>은퇴 시뮬레이션</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel = "stylesheet" href = "/css/loan.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<main>
    나이 : ${age}
    이름 : ${userName}
    생년 : ${userBirth}

    수입 : ${creditInfoList[0].annualIncome}
    신용카드 지출 : ${creditInfoList[0].debitCardUsage}
    직불카드 지출 : ${creditInfoList[0].creditCardUsage}
    현금영수증 : ${creditInfoList[0].cashReceipt}

    하나은행 자산 : ${totalBalance}
    타행 자산 : ${otherTotalBalance}

    하나은행 부채 : ${totalLoan}
    타행 부채 : ${otherTotalLoan}

</main>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

<script src="/js/script.js"></script>
<script src="/js/loan.js"></script>

</body>


</html>
