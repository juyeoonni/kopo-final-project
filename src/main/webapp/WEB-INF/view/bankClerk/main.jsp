<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="/css/bankClerk.css" />
    <link rel="stylesheet" href="/css/styles.css" />
    <style>
        .box-container {
            display: flex;
            width : 800px;
            justify-content: space-between;
        }

        .rounded-box {
            flex: 1;
            height: 150px;
            background-color: #ffffff;
            border-radius: 15px;
            margin: 0 10px;
            box-shadow: 10px 10px 10px 10px rgba(0, 0, 0, 0.1);
        }

        .detail__right {
            width: 100%;  // 이 부분을 추가하여 detail__right가 부모 요소의 전체 폭을 차지하도록 합니다.
        }
        .table-container-title{
            margin-top : 5%;
        }
        .table-container{
            margin-right : 5%;
            margin-bottom : 10%;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th, .data-table td {
            border: 1px solid #e0e0e0;
            padding: 8px 12px;
        }

        .data-table th {
            background-color: #f5f5f5;
            font-weight: bold;
        }

        .data-table tbody tr:hover {
            background-color: #e9f2ff;
        }
        .img--banker--icon{
            margin-left : 10%;
            margin-top: 20%;
        }
    </style>
    <script>
        function filterTable(status) {
            // 모든 행을 가져옴
            var rows = document.querySelectorAll(".data-table tbody tr");

            // 각 행을 순회하며 해당 행의 상태를 확인
            rows.forEach(function(row) {
                var loanStatus = row.querySelector("td:last-child").innerText; // 마지막 컬럼 (진행상황)의 텍스트 가져오기

                if (loanStatus === status) {
                    row.style.display = ""; // 해당 상태의 행만 표시
                } else {
                    row.style.display = "none"; // 다른 상태의 행은 숨김
                }
            });
        }

        function showAll() {
            var rows = document.querySelectorAll(".data-table tbody tr");
            rows.forEach(function(row) {
                row.style.display = ""; // 모든 행을 다시 표시
            });
        }

        function filterTableByBox(element) {
            var status = element.getAttribute('data-status'); // 해당 박스의 data-status 값을 가져옵니다.
            filterTable(status);
        }
    </script>
</head>
<body>
<jsp:include page="../../layout/bankerHeader.jsp" />
<section class="details">
    <jsp:include page="../../layout/bankerSide.jsp" />
    <div class="detail__right">
        <h2 class="details____title">대출관리</h2>
        <div class="box-container">

                <div class="rounded-box" data-status="대기" onclick="filterTableByBox(this)">
                    <img class="img--banker--icon" src="/img/bank1.png" alt="loan" width="50px"/>
                </div>


                <div class="rounded-box" data-status="심사완료" onclick="filterTableByBox(this)">
                    <img class="img--banker--icon" src="/img/bank2.png" alt="loan" width="50px" />
                </div>


                <div class="rounded-box" onclick="showAll()">
                    <img class="img--banker--icon" src="/img/bank3.png" alt="loan" width="50px" />
                </div>

        </div>
        <div class = "table-container-title">
            <h3>신규 신청</h3>
        </div>

        <div class = "table-container">

            <br>
            <!-- 테이블로 데이터베이스 데이터 표시 -->
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>대출명</th>
                    <th>대출종류</th>
                    <th>신청일자</th>
                    <th>진행상황</th>
                    <!-- 필요한 다른 컬럼들도 여기에 추가 -->
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${loans}" var="loan">
                    <tr onclick="window.location.href='/loanDetails?id=${loan.id}';" style="cursor: pointer;">
                        <td>${loan.id}</td>
                        <td>${loan.newLoanName}</td>

                        <td>신용대출 갈아타기</td>
                        <td>${loan.applicationDate}</td>
                        <td>${loan.newLoanStatus}</td>
                        <!-- 필요한 다른 컬럼들의 데이터도 여기에 추가 -->
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>


</section>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
<script src="/js/bank.js"></script>
</body>
</html>

