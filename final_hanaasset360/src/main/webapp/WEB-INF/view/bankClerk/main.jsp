<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="/css/bank-clerk/bankClerk.css" />
    <link rel="stylesheet" href="/css/styles.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>

    <script>
        function filterTable(status) {
            var rows = document.querySelectorAll(".data-table tbody tr");
            var count = 0;

            rows.forEach(function(row) {
                var loanStatus = row.querySelector("td:last-child").innerText;

                if (loanStatus === status) {
                    row.style.display = "";
                    count++;
                } else {
                    row.style.display = "none";
                }
            });

            return count;
        }

        function showAll() {
            var rows = document.querySelectorAll(".data-table tbody tr");
            rows.forEach(function(row) {
                row.style.display = "";
            });
        }

        function countRowsByStatus(status) {
            var rows = document.querySelectorAll(".data-table tbody tr");
            var count = 0;

            rows.forEach(function(row) {
                var loanStatus = row.querySelector("td:last-child").innerText;
                if (loanStatus === status) {
                    count++;
                }
            });

            return count;
        }

        function filterTableByBox(element) {
            var status = element.getAttribute('data-status');
            filterTable(status);
        }

        function initializeCounts() {
            var boxes = document.querySelectorAll(".rounded-box[data-status]");

            var totalCount = 0;

            boxes.forEach(function(box) {
                var status = box.getAttribute('data-status');
                var count = countRowsByStatus(status);
                totalCount += count;

                var label = box.querySelector(".count-label");
                label.textContent = count + "건"; // 여기서 "건"을 추가하여 개수를 표시
            });

            // 총 할당건수 설정
            document.querySelector(".count-total-label").textContent = totalCount + "건";
        }

        // 페이지 로딩 시 카운트 초기화
        document.addEventListener('DOMContentLoaded', initializeCounts);

        $(document).ready(function() {
            $('.data-table').DataTable({
                "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
                "pageLength": 10,
                "language": {
                    "info": "_START_ - _END_ / _TOTAL_개",
                    "infoEmpty": "0개",
                    "infoFiltered": "(전체 _MAX_개 중 검색결과)",
                    "search": "검색:",
                    "zeroRecords": "검색된 데이터가 없습니다.",
                    "lengthMenu": "_MENU_ 개씩 보기",
                    "loadingRecords": "데이터 로딩중...",
                    "processing": "처리중...",
                    "paginate": {
                        "first": "처음",
                        "last": "마지막",
                        "next": "다음",
                        "previous": "이전"
                    }
                }
            });
        });




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
                <span class="status-label">대기</span>
                <span class="count-label"></span>
            </div>

            <div class="rounded-box" data-status="심사완료" onclick="filterTableByBox(this)">
                <img class="img--banker--icon" src="/img/bank2.png" alt="loan" width="50px"/>
                <span class="status-label">누적 처리량</span>
                <span class="count-label"></span>
            </div>

            <div class="rounded-box" onclick="showAll()">
                <img class="img--banker--icon" src="/img/bank3.png" alt="loan" width="50px"/>
                <span class="total-label">총 할당건수: <span class="count-total-label"></span></span>
            </div>

        </div>

        <div class = "table-container-title">
            <h3>신규 신청</h3>
        </div>

        <div class="table-container">
            <br>
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>대출명</th>
                    <th>대출종류</th>
                    <th>신청일자</th>
                    <th>진행상황</th>
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

