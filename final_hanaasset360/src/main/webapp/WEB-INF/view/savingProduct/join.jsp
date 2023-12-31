<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/loan/loanSwitchStep2.css">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Bootstrap JS library -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function showTable() {
            var selectedValue = document.getElementById("savingsType").value;
            if (selectedValue == "정액적립식") {
                document.getElementById("paymentTable").style.display = "table";
            } else {
                document.getElementById("paymentTable").style.display = "none";
            }
        }
        $(document).ready(function() {
            $("#submitButton2").click(function (event) {
                // 기본 submit 이벤트를 방지합니다.
                event.preventDefault();

                // 입력값 가져오기
                var savingName = $("#savingName").text();
                var bankName = $(".bank-select").val();
                var savingAmount = $("#savingAmountInput").val();
                var account = $("#accountSelect").val();
                var interestRateValue = $("#interestRate").text();
                var interestRate = parseFloat(interestRateValue.replace('%', ''));
                var interestPaydate = $("select[name='interestPaydate']").val();
                var savingsType = $("#savingsType").val();
                var password = $("#password").val();
                var monthlyPayment = $("#monthlyPayment").val();
                var subscriptionPeriodValue = $("#subscriptionPeriod").text();
                subscriptionPeriodValue = subscriptionPeriodValue.replace("개월", "").trim();
                subscriptionPeriodValue = parseInt(subscriptionPeriodValue, 10);

                // AJAX 요청을 보냅니다.
                $.ajax({
                    url: "/join-saving",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({
                        savingName: savingName,
                        bankName: bankName,
                        savingAmount: savingAmount, // 오타 수정: savingmount -> savingAmount
                        account: account,
                        interestRate: interestRate,
                        interestPaydate: interestPaydate,
                        savingsType: savingsType,
                        password: password,
                        monthlyPayment: monthlyPayment,
                        subscriptionPeriodValue : subscriptionPeriodValue
                    }),
                    success: function (response) {
                        // 성공적으로 요청이 완료되면 여기의 코드가 실행됩니다.
                        console.log(response);
                        window.location.href = "/mypage/savingIndex";

                    },
                    error: function (xhr, status, error) {
                        // 오류 발생 시 실행됩니다.
                        console.error(error);
                    }
                });
            });
        });
    </script>

</head>
<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<div class="container mt-5">
    <h1 class="mb-5">적금 신청</h1>
    <div class="mb-5">
        <table class="table table-bordered">
            <tr>
                <th><span>*</span> 적금 이름</th>
                <td colspan="1" id="savingName">
                ${product.name}</td>

                <th><span>*</span>출금 은행</th>
                <td colspan="1">
                    <select class="form-select bank-select" name="bankName" onchange="updateAccountOptions()">
                        <option value="하나은행">하나은행</option>

                    </select>
                </td>

            </tr>
            <tr>
                <th><span>*</span> 가입신청금액</th>
                <td colspan="1">
                    <input type="number" id="savingAmountInput" name="loanAmount" min="0" placeholder="금액을 입력하세요"> (원)
                </td>

                <th><span>*</span>출금 계좌</th>
                <td colspan="1" id="accountContainer">
                    <!-- 기본적으로는 하나은행의 계좌정보를 보여줍니다. -->
                    <select class="form-select" name="repaymentAccount" id="accountSelect">
                        <c:forEach var="account" items="${accounts}">
                            <option value="${account.accountId}">${account.accountId}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>

            </tr>
            <tr>
                <th><span>*</span> 적금이자</th>
                <td id="interestRate">${product.annualExpectedReturn}%</td>

                <th><span>*</span>자동이체일</th>
                <td colspan="4"><select class="form-select"
                                        name="interestPaydate">
                    <option value="1">매달 1일</option>
                    <option value="5">매달 5일</option>
                    <option value="10">매달 10일</option>
                    <option value="15">매달 15일</option>
                    <option value="20">매달 20일</option>
                    <option value="25">매달 25일</option>
                </select></td>
            </tr>
            <tr>
                <th><span>*</span> 적립방법</th>
                <td><select class="form-select" name="loanPayType"
                            id="savingsType"  onchange="showTable()">
                    <option value="자유적립식">자유적립식(자유적금)</option>
                    <option value="정액적립식">정액적립식(정기예금)</option>
                </select></td>
                <th><span>*</span> 적금기한</th>
                <td id="subscriptionPeriod"><fmt:formatNumber value="${product.subscriptionPeriod}" pattern="#"/> 개월</td>


            </tr>
            <tr>
                <th colspan="1"><span>*</span>계좌 비밀번호</th>
                <td colspan="1" >
                    <input type="password" id="password" name="loanAmount" min="0" placeholder="비밀번호를 입력하세요.">
                </td>

                <th colspan="1"><span>*</span>비밀번호 확인</th>
                <td colspan="1">
                    <input type="password" id="passwordChk" name="loanAmount" min="0" placeholder="비밀번호 확인해주세요.">
                </td>
            </tr>
            <tr id ="paymentTable" style="display:none;">
                <th colspan="1"><span>*</span>월 납입료</th>
                <td colspan="1"><input type="number" id="monthlyPayment"></td>
            </tr>

        </table>
    </div>






        <div class="mb-5">
            <h4 class="mb-4 d-flex align-items-center"><span class="material-icons-sharp mr-2"></span>상품약관동의</h4>
            <div class="list-group">
                <div class="list-group-item">
                    <div class="form-check d-flex justify-content-between align-items-center">
                        <%--@declare id="agreement1"--%><input class="form-check-input" type="checkbox">
                        <label class="form-check-label" for="agreement1">은행여신거래기본약관에 동의합니다.</label>
                        <a href="#" class="downloadApply">
                            은행여신거래기본약관
                        </a>
                    </div>
                </div>
                <div class="list-group-item">
                    <div class="form-check d-flex justify-content-between align-items-center">
                        <%--@declare id="agreement2"--%><input class="form-check-input" type="checkbox">
                        <label class="form-check-label" for="agreement2">여신거래약정서에 동의합니다.</label>
                        <a href="#" class="downloadApply">
                            여신거래약정서
                        </a>
                    </div>
                </div>
                <div class="list-group-item">
                    <div class="form-check d-flex justify-content-between align-items-center">
                        <%--@declare id="agreement3"--%><input class="form-check-input" type="checkbox">
                        <label class="form-check-label" for="agreement3">상품설명서를 읽고 이해했으며 동의합니다.</label>
                        <a href="#" class="downloadApply">
                            적금상품설명서
                        </a>
                    </div>
                </div>
                <div class="list-group-item">
                    <div class="form-check d-flex justify-content-between align-items-center">
                        <%--@declare id="agreement4"--%><input class="form-check-input" type="checkbox">
                        <label class="form-check-label" for="agreement4">SMS 메일 수신에 동의합니다.</label>
                        <a href="#" class="downloadApply">
                            메일동의서
                        </a>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <button id="agreeAll" class="btn btn-primary">모두 동의하기</button>
            </div>
        </div>


    </div>
<div class="text-center mt-5 mb-5">
    <button id="submitButton2" class="btn custom-btn-color">확인</button>
</div>


</div>
<script>
    document.getElementById("agreeAll").addEventListener("click", function() {
        let checkboxes = document.querySelectorAll(".form-check-input");
        checkboxes.forEach(checkbox => {
            checkbox.checked = true;
        });
    });
</script>
</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

</html>