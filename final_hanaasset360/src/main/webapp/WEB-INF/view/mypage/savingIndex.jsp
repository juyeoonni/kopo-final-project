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

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

    <!-- 하나의 jQuery 버전만 로드 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>



    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>

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

        .history_top, .bank_money_num, .font_col, .toggle-content {
            display: none;  /* 초기에는 숨겨져 있음 */
        }
    </style>
    <script>
        $(document).ready(function() {
            $("#toggle").change(function() {
                if ($(this).is(":checked")) {
                    $(".history_top, .bank_money_num, .font_col, span:has(fmt), .toggle-content").show();
                } else {
                    $(".history_top, .bank_money_num, .font_col, span:has(fmt), .toggle-content").hide();
                }
            });
        });
        $(document).ready(function() {
            $(".bank_btn_select").click(function() {
                var accountId = $(this).data("accountid");

                $.ajax({
                    url: '/saving-account/transaction',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ accountId: accountId }),

                    success: function(transactions) {

                        transactions.sort(function(a, b) {
                            return b.transactionDate.localeCompare(a.transactionDate);
                        });
                        var htmlContent = '<table id="transactionTable"  class="table table-bordered">';
                        htmlContent += '<thead>';
                        htmlContent += '<tr>';

                        htmlContent += '<th>나의 계좌</th>';
                        htmlContent += '<th>거래일시</th>';
                        htmlContent += '<th>거래유형</th>';
                        htmlContent += '<th>상대계좌번호</th>';
                        htmlContent += '<th>거래금액</th>';
                        htmlContent += '<th>거래수수료</th>';
                        htmlContent += '<th>비고</th>';
                        htmlContent += '</tr>';
                        htmlContent += '</thead>';
                        htmlContent += '<tbody>';

                        transactions.forEach(function(transaction) {
                            htmlContent += '<tr>';
                            htmlContent += '<td>' + transaction.accountId + '</td>';
                            htmlContent += '<td>' + formatDate(transaction.transactionDate) + '</td>';
                            htmlContent += '<td>' + transaction.transactionType + '</td>';
                            htmlContent += '<td>' + (transaction.counterpartyAccountId || '-') + '</td>'; // 상대계좌번호가 없을 경우 '-' 표시
                            htmlContent += '<td>' + formatNumberWithCommas(transaction.transactionAmount) + '</td>';
                            htmlContent += '<td>' + formatNumberWithCommas(transaction.transactionFee) + '</td>';
                            htmlContent += '<td>' + (transaction.remarks || '-') + '</td>'; // 비고가 없을 경우 '-' 표시
                            htmlContent += '</tr>';
                        });

                        htmlContent += '</tbody>';
                        htmlContent += '</table>';

                        $("#myModalContent").html(htmlContent);
                        $("#transactionModal table").DataTable();
                        $("#transactionModal").modal('show');
                    },
                    error: function() {
                        alert("거래내역 조회에 실패했습니다.");
                    }
                });
            });
        });

        function formatDate(dateString) {
            let date = new Date(dateString);

            let yyyy = date.getFullYear();
            let mm = String(date.getMonth() + 1).padStart(2, '0');
            let dd = String(date.getDate()).padStart(2, '0');

            let hh = String(date.getHours()).padStart(2, '0');
            let min = String(date.getMinutes()).padStart(2, '0');
            let ss = String(date.getSeconds()).padStart(2, '0');

            return yyyy + '-' + mm + '-' + dd + ' ' + hh + ':' + min + ':' + ss;
        }

        function formatNumberWithCommas(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
    </script>
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
                    <li class="active"><a href="/mypage/index">하나은행 계좌조회</a></li>
                    <li><a href="/mypage/otherAccount">다른금융 조회</a></li>
                </ul>
            </div>
            <div class="bank_menu_section">
                <p class="menu_title">대출관리<img src="/img/ico_und.png" alt="" class="ico_und"></p>
                <ul>
                    <li><a href="/mypage/loanManagement">대출 관리</a></li>
                    <li><a href="/mypage/loanEvaluation">대출 평가</a></li>
                    <li><a href="#">DSR 계산</a></li>
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
            <li  class="active"><a href="/mypage/savingIndex">적금</a></li>
            <li><a href="/mypage/subIndex">대출</a></li>
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
                        <p>총 잔액(적금)</p>
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
                    <p><b>적금</b> <span class="min_txt">(${fn:length(savingApplicationVOList)}계좌)</span></p>
                    <p>잔액<b class="font_col"><fmt:formatNumber value="${totalBalance}" groupingUsed="true" /></b>원</p>
                </div>
                <div class="bank_sort">
                    계좌순서변경
                    <img src="/img/ico_under.png" alt="" class="ico_under">
                </div>
            </div>
            <ul>
                <c:forEach var="account" items="${savingApplicationVOList}">
                    <li>
                        <div class="row_1">
                            <p>${account.savingName}</p>
                        </div>
                        <div class="row_2">
                            <p class ="toggle-content">잔액 <span><fmt:formatNumber value="${account.currentSavedAmount}" groupingUsed="true" />원</span></p>
                        </div>
                        <div class="row_3">
                            <div>
                                <a class="bank_btn_select" data-accountid="${account.accountId}">조회</a>
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

<div class="modal fade" id="transactionModal" tabindex="-1" role="dialog" aria-labelledby="transactionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="transactionModalLabel">거래내역</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="myModalContent">
                <!-- 여기에 AJAX로 받아온 거래내역 정보가 표시됩니다 -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
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