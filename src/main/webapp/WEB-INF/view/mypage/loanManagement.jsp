<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

    <link rel="stylesheet" href="/css/mypage.css">
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/media.css">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Bootstrap JS library -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>




    <style>
        /* 공통 */
        .flex_end {
            display: flex;
            justify-content: space-between;
        }
        .link_btn {
            font-size: 13px;
            border-bottom: 1px solid #2b9fcb;
            color: #2b9fcb;
            font-weight: 500;
        }
        .link_btn img {
            width:8px;
            height: 10px;
            margin-left: 3px;
        }

        .ico_und {
            width:20px;
            height: 20px;
        }

        /* Style the buttons */
        .accordion-button {
            cursor: pointer;
            border: none;
            text-align: left;
            outline: none;
            transition: 0.4s;
            width: 100%;
            padding: 10px;
            background-color: #f1f1f1;
        }

        .accordion-button.active {
            background-color: #ddd;
        }

        /* Style the accordion content panel */
        .accordion-content {
            display: none;
            padding: 0 10px;
            overflow: hidden;
            border-top: 1px solid #f1f1f1;
        }

        .modal-dialog {
            max-width: 110%;  /* 원하는 크기로 조정 */
            max-height: 110%;
        }

        .bank_wrap {
            position: relative;
            display: flex;
            padding: 0 20px;
        }

        .bank_left {
            width:25%;
            max-width: 300px;
        }
        .bank_left .left_title {
            position: relative;
            padding: 20px 0;
            font-size: 34px;
            font-weight: 500;
            color: #9be3bc;
        }
        .bank_menu {

        }
        .bank_menu .bank_menu_section {

        }
        .bank_menu .bank_menu_section .menu_title {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            font-size: 20px;
            font-weight: 500;
            border-bottom: 2px solid #f3f3f3;
            cursor: pointer;
        }
        .bank_menu .bank_menu_section .menu_title.on {
            background: #f9f9f9;
        }
        .bank_menu .bank_menu_section:first-child .menu_title {
            border-top: 1px solid #3a5d4c;

        }
        .bank_menu .bank_menu_section ul {
            display: none;
            border-bottom: 2px solid #f3f3f3;
        }
        .bank_menu .bank_menu_section ul.on {
            background:#f9f9f9;
        }

        .bank_menu .bank_menu_section ul li {
            padding: 20px 20px;
            font-size: 16px;

        }
        .bank_menu .bank_menu_section ul li.active {
            background:#60ca91;
            font-weight: 600;
        }


        .bank_right {
            width:85%;
            padding-left: 40px;
            padding-right: 20px;
        }
        .right_top {
            align-items: flex-end;
        }
        .right_title {
            padding-top: 20px;
            font-size: 25px;
            font-weight: 500;
        }
        .right_top div .link_btn:nth-of-type(1) {
            margin-right:5px;
        }
        .bank_tab {
            display: flex;
            margin-top: 20px;
        }
        .bank_tab li {
            padding: 20px 0px;
            width: 50%;
            text-align: center;
            font-size: 18px;
            border-bottom: 1px solid #3a5d4c;
            background:#f9f9f9;
        }
        .bank_tab li.active {
            font-weight: 600;
            background: #fff;
            border-bottom: 0;
            border-top: 2px solid #3a5d4c;
            border-right:1px solid #3a5d4c;
            border-left:1px solid #3a5d4c;
        }

        .hamburger {
            display: none;
            position: absolute;
            right: 20px;
            top: 20px;
            z-index: 10;
        }
        .menu-trigger {

        }
        .menu-trigger,
        .menu-trigger span {
            display: inline-block;
            transition: all .4s;
            box-sizing: border-box;
        }

        .menu-trigger {
            position: relative;
            width: 30px;
            height: 20px;
        }

        .menu-trigger span {
            position: absolute;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #60ca91;
            border-radius: 4px;
        }

        .menu-trigger span:nth-of-type(1) {
            top: 0;
        }

        .menu-trigger span:nth-of-type(2) {
            top: 9px;
        }

        .menu-trigger span:nth-of-type(3) {
            bottom: 0;
        }

        .menu-trigger.active span:nth-of-type(1) {
            -webkit-transform: translateY(10px)rotate(-45deg);
            transform: translateY(8px) rotate(-45deg);
        }

        .menu-trigger.active span:nth-of-type(2) {
            opacity: 0;
        }

        .menu-trigger.active span:nth-of-type(3) {
            -webkit-transform: translateY(-10px) rotate(45deg);
            transform: translateY(-10px) rotate(45deg);
        }

        /* 토글버튼 */
        .toggleSwitch {
            width: 60px;
            height: 30px;
            display: block;
            position: relative;
            border-radius: 30px;
            background-color: #fff;
            box-shadow: 0 0 16px 3px rgba(0 0 0 / 9%);
            cursor: pointer;
            margin-left: 10px;
        }
        .toggleSwitch .toggleButton {
            width: 20px;
            height: 20px;
            position: absolute;
            top: 50%;
            left: 4px;
            transform: translateY(-50%);
            border-radius: 50%;
            background: #60ca91;
        }

        #toggle:checked ~ .toggleSwitch {
            background: #60ca91;
        }

        #toggle:checked ~ .toggleSwitch .toggleButton {
            left: calc(100% - 29px);
            background: #fff;
        }


        .sub_tit h2 {
            font-size: 1.5em;
        }


        .flex_end_style {
            width: 100%;
        }


        .loan-info {
            display: flex;
            justify-content: space-between; /* 양쪽 끝으로 요소를 보냄 */
            width: 100%;
        }

        .loan-name {
            text-align: left;
            font-weight: bold;  /* 글씨를 굵게 */
            font-size: 1.5em;  /* 글씨 크기 조정 */
        }

        .loan-status {
            text-align: right;
        }

        .loan-status.waiting {
            color: green;
            font-weight: bold;
        }

        .emphasized {
            font-weight: bold;
            color: red;
        }

        .custom-nav-item .nav-link {
            color: #495057;
            background-color: #fff;
            border: 1px solid #dee2e6;
            font-size: 16px;
            padding: 10px 15px;
        }

        .custom-nav-item .nav-link.active {
            color: #fff;
            background-color: #007bff;
            border: 1px solid #007bff;
        }

    </style>


</head>
<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
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
                    <li><a href="/mypage/otherAccount">다른금융 조회</a></li>
                </ul>
            </div>
            <div class="bank_menu_section">
                <p class="menu_title">대출관리<img src="/img/ico_und.png" alt="" class="ico_und"></p>
                <ul>
                    <li class="active"><a href="/mypage/loanManagement">대출 관리</a></li>
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
        <div class="flex_end right_top" style="margin-bottom: 5%">
            <h2 class="right_title">대출 관리</h2>
            <div>
                <a href="/mypage/loanEvaluation" class="link_btn">대출 상태 평가<img src="/img/link_arrow.png" alt=""></a>
                <a href="/mypage/dsr" class="link_btn">DSR 계산기<img src="/img/link_arrow.png" alt=""></a>
            </div>
        </div>
        <div class="round_bx pay_top">
            <div class="flex_end">
                <ul>
                    <li>나의 남은 대출은?</li>
                    <li><b><fmt:formatNumber value="${totalCombinedLoanAmount}" pattern="#,##0" /></b>원</li>

                    <li id="currentDateTime"> 기준</li>
                </ul>
                <div class="right_img">
                    <img src="" alt="">
                </div>
            </div>
            <div class="detail_btn">
                <a href="/mypage/subIndex" class="flex_end">
                    <b>나의 대출 상세보기</b>
                    <img src="/img/ico_arrow.png" alt="" class="ico_arrow">
                </a>
            </div>
        </div>
        <div class="flex_end sub_tit">
            <h2 class="">대출심사결과<img src="/img/ico_info.png" alt="" class="ico_info" ></h2>
        </div>
        <div class="round_bx pay_top">
            <!-- 탭 메뉴 -->
            <ul class="nav nav-tabs" id="loanTabs" role="tablist">
                <li class="nav-item custom-nav-item">
                    <a class="nav-link active" id="waiting-tab" data-toggle="tab" href="#waiting" role="tab">대기</a>
                </li>
                <li class="nav-item custom-nav-item">
                    <a class="nav-link" id="completed-tab" data-toggle="tab" href="#completed" role="tab">심사완료</a>
                </li>
            </ul>

            <!-- 탭 내용 -->
            <div class="tab-content" id="loanTabsContent">
                <!-- 대기 탭 -->
                <div class="tab-pane fade show active" id="waiting" role="tabpanel">
                    <c:forEach var="loanSwitch" items="${matchingLoanSwitches}" varStatus="status">
                        <c:if test="${loanSwitch.newLoanStatus == '대기'}">
                            <div class="loan-info">
                                <div class="loan-name">${loanSwitch.newLoanName}</div>
                                <div class="loan-status waiting">${loanSwitch.newLoanStatus}</div>
                                <div class="loan-amount">대출 실행 금액: <fmt:formatNumber value="${loanSwitch.newLoanAmount}" pattern="#,##0" />원</div>
                                <div class="loan-interest">대출 이자율: ${loanSwitch.newLoanInterest}%</div>
                                <div class="application-date">신청 시간: ${loanSwitch.applicationDate}</div>
                            </div>
                            <hr>
                        </c:if>
                    </c:forEach>
                </div>

                <!-- 심사완료 탭 -->
                <div class="tab-pane fade" id="completed" role="tabpanel">
                    <c:forEach var="loanSwitch" items="${matchingLoanSwitches}" varStatus="status">
                        <c:if test="${loanSwitch.newLoanStatus != '대기'}">
                            <div class="loan-info">
                                <div class="loan-name">${loanSwitch.newLoanName}</div>
                                <div class="loan-status emphasized">${loanSwitch.newLoanStatus}</div>
                                <div class="loan-amount">대출 실행 금액: <fmt:formatNumber value="${loanSwitch.newLoanAmount}" pattern="#,##0" />원</div>
                                <div class="loan-interest">대출 이자율: ${loanSwitch.newLoanInterest}%</div>
                                <div class="application-date">신청 시간: ${loanSwitch.applicationDate}</div>
                            </div>
                            <hr>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>


        <div class="flex_end sub_tit">
            <h2 class="">다가오는 상환일정<img src="/img/ico_info.png" alt="" class="ico_info" ></h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ShowCalendar">
            달력 보기
            </button>
        </div>
        <div class="round_bx calendar_list">
            <ul id="dateList"></ul>
        </div>
        <ul class="pay_list">
            <c:forEach var="repayment" items="${combinedLoans}" varStatus="status">
                <li class="flex_end">
                    <div>
                        <p><c:out value="${repayment.repaymentDate}"/>일 예상</p>
                        <c:set var="monthlyInterest" value="${repayment.loanBalance * repayment.interestRate / 1200}" />
                        <span><fmt:formatNumber value="${monthlyInterest}" pattern="#,##0"/>원 예상,  <c:out value="${repayment.finance}"/></span>
                    </div>
                    <div>
                        <img src="">
                    </div>
                </li>
                <c:if test="${status.last}">
                    <c:set var="totalCount" value="${status.count}" />
                </c:if>
            </c:forEach>
        </ul>
        <div class="round_bx flex_end pay_alert">
            <span class="ico_bub"></span>
            <p>총 대출에 대한 이자 상환 수는 : <c:out value="${totalCount}" /> 건 있습니다.</p>
        </div>
    </div>




</div>
<script src="/js/mypage.js"></script>


<!-- Modal -->

<div class="modal fade" id="ShowCalendar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">이자 상환</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="calendar" class="calendar"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    var repaymentDates = [];
    <c:forEach var="repayment" items="${combinedLoans}">
    repaymentDates.push('<c:out value="${repayment.repaymentDate}"/>');
    </c:forEach>


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