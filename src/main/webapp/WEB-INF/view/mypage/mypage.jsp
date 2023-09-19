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
    <link rel="stylesheet" href="/css/mypage.css">
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/media.css">
    <style>
        #modal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            z-index: 1000;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            z-index: 1001;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script src="https://rawgit.com/kimmobrunfeldt/progressbar.js/1.0.0/dist/progressbar.js"></script>
</head>
<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<div class="contain">
    <div class="box">
        <div class="round_bx pay_top">
            <div class="flex_end">
                <ul>
                    <li>나의 남은 대출은?</li>
                    <li><b>${totalLoan}</b>원</li>
                    <li id="currentDateTime"> 기준</li>
                </ul>
                <div class="right_img">
                    <img src="/img/pay.png" alt="">
                </div>
            </div>
            <div class="detail_btn">
                <a href="#" class="flex_end">
                    <b>나의 대출 상세보기</b>
                    <img src="/img/ico_arrow.png" alt="" class="ico_arrow">
                </a>
            </div>
        </div>
        <div class="flex_end sub_tit">
            <h2 class="">다가오는 상환일정<img src="/img/ico_info.png" alt="" class="ico_info" ></h2>
            <a href="" class="cal_btn">달력 보기</a>
        </div>
        <div class="round_bx calendar_list">
            <ul id="dateList"></ul>
        </div>
        <ul class="pay_list">
            <c:forEach var="repayment" items="${repayments}" varStatus="status">
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
            <p>총 대출로 인해 이자 상환 수는 : <c:out value="${totalCount}" /> 건 있습니다.</p>
        </div>
    </div>

    <div class="box">
        <ul class="tab">
            <li class="active"><a href="">대출</a></li>
            <li><a href="">노후 설계</a></li>
            <li><a href="">총 평가</a></li>
        </ul>
        <ul class="pay_info">
            <li class="flex_end bg_orange">
                <div>
                    <h2 class="big_txt">잘하고 있어요!</h2>
                    <p>신용평가에 긍정적 요인이 될 수 있어요.</p>
                </div>
                <img src="/img/sun.png" alt="">
            </li>
            <li>
                <h2 class="mid_txt"><b>제1금융권(은행) 대출</b>을 이용하고 계시네요.</h2>
                <p>
                    비 은행업종 대출은 일반적으로 은행 대비 금리가 높아 리스크 수준이 높게 평가됩니다.
                    가급적 지금처럼 제1금융권 대출 위주로 사용하는 것이 신용관리에 도움이 됩니다.
                </p>
            </li>
            <li>
                <h2 class="mid_txt"><b>대출금을 상환</b>해가고 계시네요.</h2>
                <p>
                    대출 상환 시 부채가 감소되어 신용평가에 도움이 됩니다. 특히 연체가 발생한 대출,
                    제1금융권(은행)이 아닌 기관의 대출부터 상환 하시는 것이 좋습니다.
                </p>
            </li>
            <li class="flex_end bg_blue">
                <div>
                    <h2 class="big_txt">관리가 필요해요.</h2>
                    <p>신용평가에 부정적 요인이 될 수 있어요.</p>
                </div>
                <img src="/img/rain.png" alt="">
            </li>
        </ul>
    </div>

    <div class="box">
        <div class="tob_back">
            <img src="/img/ico_back.png" alt="" class="ico_back">
            <p>DSR 계산기</p>
            <img src="/img/ico_menu.png" alt="" class="ico_menu" >
        </div>
        <div class="progress">
            <h2>DSR 계산결과</h2>
            <div class="multigraph">
                <span class="graph"></span>
            </div>
            <p>37.13 %</p>
        </div>
        <div class="round_bx center_txt">
            추가대출이 가능해요.<br>
            예상 대출한도를 확인해 보세요!
        </div>
        <div class="pay_money">
            <h2>신용대출</h2>
            <div class="flex_end">
                <P>예상한도 <img src="/img/ico_info.png" alt="" class="ico_info"></P>
                <b>8,000만원</b>
            </div>
            <div class="round_bx pay_per">
                <p>계산기준</p>
                <div class="flex_end">
                    <span>개인신용대출 최저금리</span>
                    <span>2.08%</span>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/js/mypage.js"></script>

<!-- 모달 창 -->
<div id="modal" style="display:none;">
    <div class="modal-content">
        <span class="close">&times;</span>
        <p>대출 상세 정보가 여기에 표시됩니다.</p>
    </div>
</div>

</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>
</html>