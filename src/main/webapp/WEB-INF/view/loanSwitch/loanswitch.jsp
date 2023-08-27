<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>대출 상환 계산기</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel = "stylesheet" href = "/css/loan.css">

</head>

<body>
<main>
    <header class = "header">
        <jsp:include page="../../layout/header.jsp" />
    </header>
    <h2>대출 갈아타기</h2>
    <div class="section-container">
        <!-- Section 1: 금융사에서 나의 대출 가져오기 -->
        <section class="step" id="section1">
            <h3>1. 금융사 대출 정보 가져오기</h3>
            <hr>
            <button onclick="showNextSection('section2')">마이데이터 연동하기</button>
        </section>
    </div>
    <br />
    <!-- Section 2: 대출 선택하기 -->
    <div class="section-container">
        <section class="step" id="section2">
            <h3>2. 받은 대출 정보 확인 및 선택</h3>
            <hr>
                <div class="loan-container" id="loanList">
                    <!-- 여기에 동적으로 대출 카드가 추가될 것입니다. -->
                </div>
            <!-- 로딩 인디케이터 -->
            <div id="loadingIndicator" style="display: none;">
                <img src="/img/loading.gif" alt="로딩..." width="330" height="200" />
            </div>
            <button onclick="showNextSection('section3')">홈텍스 연동해서, 최적의 대출 찾기</button>
        </section>
    </div>
    <br />
    <!-- Section 3: 금리 비교 및 대출 변경 -->
    <div class="section-container">
        <section class="step" id="section3">
            <h3>3. 최적의 대출로 변경하기</h3>
            <hr>
            <div id="bestLoan">최적의 대출 정보가 여기에 표시됩니다.</div>
            <button>갈아타기 확인</button>
        </section>
    </div>
</main>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

<script src="/js/script.js"></script>
<script src="/js/loan.js"></script>
</body>


</html>
