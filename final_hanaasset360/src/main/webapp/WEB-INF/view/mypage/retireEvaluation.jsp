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

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

    <link rel="stylesheet" href="/css/mypage/mypage.css">
    <link rel="stylesheet" href="/css/mypage/common.css">
    <link rel="stylesheet" href="/css/mypage/main.css">
    <link rel="stylesheet" href="/css/mypage/media.css">
    <script src="https://rawgit.com/kimmobrunfeldt/progressbar.js/1.0.0/dist/progressbar.js"></script>

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>


    <style>
        /* 공통 */
        a {
            text-decoration: none; /* 밑줄 제거 */
            color: inherit; /* 상위 요소의 텍스트 색상을 상속 */
        }

        a:hover {
            text-decoration: none; /* :hover 상태에서도 밑줄 제거 */
            color: inherit; /* 상위 요소의 텍스트 색상을 상속 */
        }
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

    </style>

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
                    <li><a href="/mypage/loanManagement">대출 관리</a></li>
                    <li class="active"><a href="/mypage/loanEvaluation">대출 평가</a></li>
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
            <h2 class="right_title">노후 진단</h2>
            <div>
                <a href="/mypage/loanManagement" class="link_btn">대출 상태 평가<img src="/img/link_arrow.png" alt=""></a>
                <a href="/mypage/dsr" class="link_btn">DSR 계산기<img src="/img/link_arrow.png" alt=""></a>
            </div>
        </div>
        <div class="box">
            <ul class="tab">
                <li><a href="/mypage/loanEvaluation">대출</a></li>
                <li class="active"><a href="/mypage/retireEvaluation">노후 설계</a></li>
                <li><a href="">총 평가</a></li>
            </ul>
            <ul class="pay_info">
                <li class="flex_end bg_orange">
                    <div>
                        <h2 class="big_txt">잘하고 있어요!</h2>
                    </div>
                    <img src="/img/sun.png" alt="">
                </li>
                <li>
                    <h2 class="mid_txt"><b>수입 대비 적절한 지출</b>이 이루어지고 있어요.</h2>
                    <p>
                        <b>수입 대비 적절한 지출</b>은 노후를 준비하는 데 중요한 요소입니다. 적절한 지출 관리는 노후 자금 마련에 큰 도움이 되며, 불필요한 부채 없이 안정된 노후 생활을 보장합니다. 지출을 계획적으로 관리하면서 저축과 투자를 적절히 조합하면 노후에도 원하는 라이프 스타일을 유지할 수 있습니다.
                    </p>
                </li>
                <li class="flex_end bg_blue">
                    <div>
                        <h2 class="big_txt">관리가 필요해요.</h2>
                    </div>
                    <img src="/img/rain.png" alt="">
                </li>

                <li>
                    <h2 class="mid_txt"><b>은퇴 후 생활비</b>가 부족할 예정이에요.</h2>
                    <p>
                        <b>은퇴 후 생활비</b>의 준비는 미래의 안정적인 생활을 위해 중요합니다. 노후를 대비하여 투자와 저축을 통해 자금을 준비하는 것이 필요합니다. 대출 상환을 통해 부채를 감소시키는 것도 중요한 점입니다. 특히, 제1금융권(은행)이 아닌 기관의 고금리 대출이나 연체 중인 대출부터 상환하면, 노후 자금 확보에 도움이 됩니다.
                    </p>
                </li>
            </ul>
        </div>
    </div>




</div>
<script src="/js/mypage.js"></script>


<script>
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