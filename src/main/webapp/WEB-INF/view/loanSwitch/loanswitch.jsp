<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>대출 상환 계산기</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel = "stylesheet" href = "/css/loan.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap CSS -->


</head>
<script>
    function toggleDetails(loanCard) {
        const details = loanCard.querySelector('.loan-details');
        if (details.style.display === 'none' || !details.style.display) {
            details.style.display = 'block';
        } else {
            details.style.display = 'none';
        }
    }

</script>
<style>
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }

    .loan-container {
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); /* 카드의 너비를 250px로 설정하고 화면 크기에 따라 자동으로 개수 조정 */
        gap: 20px; /* 카드 사이의 간격 */
    }

</style>
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
            <div class="btn-container" style="display: flex; justify-content: center; align-items: center;">
                <img src="/img/lbtn.png" id="scrollLeftBtn" style="cursor: pointer;  width: 60px;">
                <div class="loan-container" id="loanList">
                    <div class="loan-details" style="display: none;">
                        <!-- 상세 정보 내용 -->
                    </div>
                </div>
                <img src="/img/rbtn.png" id="scrollRightBtn" style="cursor: pointer; width: 50px; margin-left: 1%">
            </div>
            <div style="display: flex; justify-content: center; align-items: center; margin-top: 20px;">
                <!-- 추가한 div. 버튼을 중앙에 위치시키기 위해 flexbox를 사용합니다. -->
                <button id="showPopupBtn">올 크레딧 연동하고, 최적의 대출 찾기</button>
            </div>
        </section>
    </div>
    <br />
    <!-- Section 3: 금리 비교 및 대출 변경 -->
    <div class="section-container">
        <section class="step" id="section3">
        </section>
    </div>
</main>
<!-- 로딩 인디케이터 -->
<div id="loadingIndicator">
    <div class="loading-content">
        <h2>마이데이터 연동중..</h2>
        <img src = "/img/mydata.gif" width="100%">
    </div>
</div>

<!-- 은행 선택 팝업 주변 투명 검정-->
<div id="overlay" class="hidden"></div>

<!-- 팝업 창 -->
<div id="bankPopup" class="popup">
    <div class="popup-content">
        <span class="close" onclick="closePopup()">&times;</span>
        <h4>은행을 선택해주세요</h4>
        <button class="bank-btn" onclick="selectBank('우리은행')">
            <img src="/img/WOORI.png" width="40px" height="40px">
            <br />
            우리은행</button>
        <button class="bank-btn" onclick="selectBank('하나은행')">
            <img src="/img/HANA.png" width="40px" height="40px">
            <br />
            하나은행</button>
        <button class="bank-btn" onclick="selectBank('국민은행')">
            <img src="/img/KB.png" width="40px" height="40px">
            <br />
            국민은행</button>
        <button class="bank-btn" onclick="selectBank('신한은행')">
            <img src="/img/SH.png" width="40px" height="40px">
            <br />
            신한은행</button>
        <button class="bank-btn" onclick="selectBank('기업은행')">
            <img src="/img/IBK.png" width="40px" height="40px">
            <br />
            기업은행</button>
        <button class="bank-btn" onclick="selectBank('농협은행')">
            <img src="/img/NH.png" width="40px" height="40px">
            <br />
            농협은행</button>
        <button class="bank-btn" onclick="selectBank('카카오뱅크')">
            <img src="/img/KAKAO.png" width="40px" height="40px">
            <br />
            카카오뱅크</button>
        <button class="bank-btn" onclick="selectBank('케이뱅크')">
            <img src="/img/KBANK.png" width="40px" height="40px">
            <br />
            케이뱅크</button>
        <button class="bank-btn" onclick="selectBank('토스뱅크')">
            <img src="/img/TOSS.png" width="40px" height="40px">
            <br />
            토스뱅크</button>
        <hr>

        <!-- 다른 은행들 -->
        <div style="text-align: right">
            <button onclick="loadLoanData()">연동하기</button> <!-- 연동하기 버튼 -->
        </div>

    </div>
</div>

<div id="popup" class="hidden">
    <button id="closePopupBtn">X</button>
    <img src="/img/allCredit.png">


    <div id="popupBody">
        <label for="username" class="input-label">아이디:</label>
        <input type="text" id="username" class="input-field">
        <br>
        <label for="password" class="input-label">비밀번호:</label>
        <input type="password" id="password" class="input-field">
        <br>
        <button id="loginBtn">로그인</button>
    </div>
</div>

<div id="loanProductsContainer"></div>


<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

<script src="/js/script.js"></script>
<script src="/js/loan.js"></script>

</body>


</html>
