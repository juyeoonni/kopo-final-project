<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Bootstrap JS library -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        a {
            text-decoration: none; /* 밑줄 제거 */
            color: inherit; /* 상위 요소의 텍스트 색상을 상속 */
        }

        a:hover {
            text-decoration: none; /* :hover 상태에서도 밑줄 제거 */
            color: inherit; /* 상위 요소의 텍스트 색상을 상속 */
        }
    </style>
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
                    <li class="active"><a href="/mypage/index">하나은행 조회</a></li>
                    <li><a href="/mypage/otherAccount">다른금융 조회</a></li>
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
            <h2 class="right_title">하나은행 계좌조회</h2>
            <div>
                <a href="/mypage/otherAccount" class="link_btn">다른금융 계좌조회<img src="/img/link_arrow.png" alt=""></a>
                <a href="/mypage/otherLoan" class="link_btn">다른금융 대출조회<img src="/img/link_arrow.png" alt=""></a>
            </div>
        </div>
        <ul class="bank_tab">
            <li><a href="/mypage/index">예금</a></li>
            <li><a href="/mypage/savingIndex">적금</a></li>
            <li class="active"> <a href="/mypage/subIndex">대출</a></li>
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
                            대출보기
                            <input type="checkbox" id="toggle" hidden>
                            <label for="toggle" class="toggleSwitch">
                                <span class="toggleButton"></span>
                            </label>
                        </span>
                    <div class="bank_money_num">
                        <p>총 대출</p>
                        <div class="b_num">
                            <b class=""><fmt:formatNumber value="${totalBalance}" groupingUsed="true" /></b>원
                        </div>
                        <span>포함되지 않는 대출 안내<img src="/img/ico_q.png" alt="" class="ico_q"></span>
                    </div>
                </div>
            </div>
            <p class="bank_sub">안전한 금융거래를 위해 사용자암호 변경을 권장 드립니다.<a href="#" class="link_btn">바로가기<img src="/img/link_arrow.png" alt=""></a></p>
        </div>
        <div class="bank_history">
            <div class="flex_end">
                <h2 class="history_top">총 대출 잔액<b class="font_col"><fmt:formatNumber value="${totalBalance}" groupingUsed="true" /></b>원 <span class="min_txt"></span></h2>
                <span class="bank_btn">카드형 보기</span>
            </div>
            <div class="bank_history_title flex_end">
                <div class="flex_end">
                    <p><b>신용 대출</b> <span class="min_txt">(${fn:length(loanRecords)}계좌)</span></p>
                    <p>잔액<b class="font_col"><fmt:formatNumber value="${totalBalance}" groupingUsed="true" /></b>원</p>
                </div>
                <div class="bank_sort">
                    계좌순서변경
                    <img src="/img/ico_under.png" alt="" class="ico_under">
                </div>
            </div>
            <ul>
                <c:forEach var="loan" items="${loanRecords}">
                    <li>
                        <div class="row_1">
                            <p>${loan.loanProductId}</p>
                        </div>
                        <div class="row_2">
                            <p>잔액 <span><fmt:formatNumber value="${loan.loanBalance}" groupingUsed="true" />원</span></p>
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