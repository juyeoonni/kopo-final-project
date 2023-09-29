<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>은퇴 시뮬레이션</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/retire-common.css">
    <link rel="stylesheet" href="/css/retire-main.css">
    <link rel="stylesheet" href="/css/retire-media.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<div class="plan_wrap">
    <div class="plan_top">
        <h4>
            <span class="txt_c_green">하나360 </span><span class="txt_c_pink">재무설계</span>
            <p>은퇴재무설계</p>
        </h4>
        <ul>
            <li>재무 설계</li>
            <li class="active">재무 설계 결과</li>
        </ul>
    </div>
    <p class="link_p txt_c_green"><a href="/mypage/loanManagement">마이페이지</a></p>



    <p><strong>은퇴시 필요한 총 금액:</strong> <span class="txt_c_pink" id="requiredAmount">${requiredAmount}</span>원</p>
    <p><strong>현재 준비된 금액:</strong> <span class="txt_c_green" id="currentAmount">${currentAmount}</span>원</p>
    <p><strong>부족한 금액:</strong> <span class="txt_c_red" id="shortageAmount">${shortageAmount}</span>원</p>

    <!-- 시각적인 그래프 및 차트 (예시로 바 차트를 사용) -->
    <div class="bar_chart">
        <div class="bar required" style="width: ${requiredPercentage}%;">필요 금액</div>
        <div class="bar current" style="width: ${currentPercentage}%;">현재 금액</div>
    </div>

    <!-- 짧은 설명 문구 -->
    <p class="description">위 그래프는 고객님의 은퇴시 필요한 금액과 현재 준비된 금액을 비교한 것입니다.</p>
    <section class="section_01">
        <h2>준비 자산</h2>
        <div class="plan_box">
            고객님은 <i class="txt_c_pink" id="userBirth">${userBirth}</i>, 현재 나이는 <i class="txt_c_pink" id="userAge">${age}</i>입니다.<br>
            고객님의 예상 은퇴 나이는 <input type="text" name="retirementAge"> 세 입니다.<br>
            고객님의 기대수명은 <input type="text" name="lifeExpectancy"> 세 입니다.

        </div>
    </section>
</div>



<script src="/js/script.js"></script>

</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

</html>
