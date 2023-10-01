<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/css/mypage.css">
    <link rel="stylesheet" href="/css/commonIndex.css">
    <link rel="stylesheet" href="/css/mainIndex.css">
    <link rel="stylesheet" href="/css/mediaIndex.css">

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<div class="hamburger">
    <a class="menu-trigger" href="#">
        <span></span>
        <span></span>
        <span></span>
    </a>
</div>
<div class="bank_wrap">
    <div class="bank_left">
        <h2 class="left_title">
            마이페이지
        </h2>
        <div class="bank_menu">
            <div class="bank_menu_section">
                <p class="menu_title">계좌조회<img src="/img/ico_und.png" alt="" class="ico_und"></p>
                <ul>
                    <li><a href="/mypage/index">하나은행 계좌조회</a></li>
                    <li class="active"><a href="/mypage/otherAccount">다른금융 조회</a></li>
                </ul>
            </div>
            <div class="bank_menu_section">
                <p class="menu_title">대출관리<img src="/img/ico_und.png" alt="" class="ico_und"></p>
                <ul>
                    <li><a href="/mypage/loanManagement">대출 관리</a></li>
                    <li><a href="/mypage/loanEvaluation">대출 평가</a></li>
                    <li><a href="/mypage/dsr">DSR 계산</a></li>
                </ul>

            </div>
            <div class="bank_menu_section">
                <p class="menu_title">개인정보수정<img src="/img/ico_und.png" alt="" class="ico_und"></p>
                <ul>
                    <li><a href="#">회원정보 수정</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="bank_right">
        <div class="flex_end right_top">
            <h2 class="right_title">타은행 계좌조회</h2>
            <div>
                <a href="/mypage/index" class="link_btn">하나은행 계좌조회<img src="/img/link_arrow.png" alt=""></a>
                <a href="/mypage/subIndex" class="link_btn">하나은행 대출조회<img src="/img/link_arrow.png" alt=""></a>
            </div>
        </div>
        <ul class="bank_tab">
            <li class="active"><a href="/mypage/otherAccount">예금</a></li>
            <li><a href="/mypage/otherLoan">대출</a></li>
        </ul>
        <div class="bank_content">
            <span class="bank_date">조회기준일시 : 2023.09.20 14:40:37</span>
            <div class="flex_end">
                <div class="bank_name">
                    <h2>
                        <b>${UserName} 고객님,</b>
                        날씨가 쌀쌀해지니,<br/>
                        항상 몸 건강에 유의하세요.
                    </h2>
                </div>
                <div class="bank_money">
                        <span class="b_switch">
                            잔액보기
                            <input type="checkbox" id="toggle" hidden>
                            <label for="toggle" class="toggleSwitch">
                                <span class="toggleButton"></span>
                            </label>
                        </span>
                    <div class="bank_money_num">
                        <p>총 잔액(입출금)</p>
                        <div class="b_num">
                            <b class=""><fmt:formatNumber value="${totalBalance}" groupingUsed="true" /></b>원
                        </div>
                        <span>잔액에 포함되지 않는 계좌 안내<img src="/img/ico_q.png" alt="" class="ico_q"></span>
                    </div>
                </div>
            </div>
            <p class="bank_sub">안전한 금융거래를 위해 사용자암호 변경을 권장 드립니다.<a href="#" class="link_btn">바로가기<img src="/img/link_arrow.png" alt=""></a></p>
        </div>
        <div class="bank_history">
            <div class="flex_end">
                <h2 class="history_top">총 예금 잔액<b class="font_col"><fmt:formatNumber value="${totalBalance}" groupingUsed="true" /></b>원 <span class="min_txt"></span></h2>
                <span class="bank_btn">카드형 보기</span>
            </div>
            <div class="bank_history_title flex_end">
                <div class="flex_end">
                    <p><b>입출금</b> <span class="min_txt">(2계좌)</span></p>
                    <p>잔액<b class="font_col"><fmt:formatNumber value="${totalBalance}" groupingUsed="true" /></b>원</p>
                </div>
                <div class="bank_sort">
                    계좌순서변경
                    <img src="/img/ico_under.png" alt="" class="ico_under">
                </div>
            </div>
            <ul>
                <c:forEach var="account" items="${otherAccounts}">
                    <li>
                        <div class="row_0" style="margin-right: 5%">
                            <c:choose>
                                <c:when test="${account.financialCode eq '우리은행'}">
                                    <img src="/img/WOORI.png" width="70px" alt="우리은행" />
                                </c:when>
                                <c:when test="${account.financialCode eq '국민은행'}">
                                    <img src="/img/KB.png" width="70px" alt="국민은행" />
                                </c:when>
                                <c:when test="${account.financialCode eq '신한은행'}">
                                    <img src="/img/SH.png" width="70px" alt="신한은행" />
                                </c:when>
                                <c:otherwise>
                                    <!-- 기본 이미지 또는 텍스트 -->
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="row_1">
                           <strong> <p>${account.accountName}</p></strong>
                        </div>
                        <div class="row_2">
                            <p>잔액 <span><fmt:formatNumber value="${account.accountBalance}" groupingUsed="true" />원</span></p>
                        </div>
                        <div class="row_3">
                            <div>
                                <a class="bank_btn">조회</a>
                                <a class="bank_btn">이체</a>
                            </div>
                            <a class="bank_btn">계좌관리</a>
                        </div>
                    </li>
                </c:forEach>

            </ul>
        </div>
    </div>
</div>

<script>
    $('.hamburger').click(function(){
        $('.menu-trigger').toggleClass('active');
        $('.bank_left').toggleClass('active');
    })

    /* side menu */
    $('.menu_title').click(function(){
        $('.bank_menu_section ul').stop().slideUp(500);
        $(this).next('ul').stop().slideToggle(500).addClass('on');

        $('.menu_title').removeClass('on');
        $(this).addClass('on');
    })

    $('.bank_menu_section ul li').click(function(){
        $(this).parent().children().removeClass('active');
        $(this).addClass('active');
    })
</script>

</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>
</html>