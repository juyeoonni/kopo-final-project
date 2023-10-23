<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>대출 상품</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel = "stylesheet" href = "/css/loan/loan-product.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/loan-product.js"></script>
    <style>
        h2 {
            margin-left: 50px; /* 원하는 값으로 조정하세요. */
        }
    </style>
</head>

<body>
<main>
    <header class="header">
        <jsp:include page="../../layout/header.jsp" />
    </header>
    <div class="section-wrapper">
        <section class="loan-products">
            <h2>신용대출</h2>
            <br />
            <select id="sorting">
                <option value="avgIntRate">금리순</option>
                <option value="loanLimAmt">한도순</option>

            </select>

            <hr>
            <ul id="product-list" class="product-list">
                <!-- 대출 상품 목록이 들어갈 자리 -->
            </ul>
        </section>
    </div>
    <footer>
        <jsp:include page="../../layout/footer.jsp" />
    </footer>
</main>
</body>
</html>
