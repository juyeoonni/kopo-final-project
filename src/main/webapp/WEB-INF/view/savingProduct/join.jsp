<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/loanSwitchStep2.css">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
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
                var interestRate = $("#interestRate").text();
                var interestPaydate = $("select[name='interestPaydate']").val();
                var loanPayType = $("#savingsType").val();
                var password = $("#password").val();
                var monthlyPayment = $("#monthlyPayment").val();

                // AJAX 요청을 보냅니다.
                $.ajax({
                    url: "/join-saving", // 백엔드 URL을 여기에 적어주세요.
                    type: "POST",
                    data: {
                        savingName: savingName,
                        bankName: bankName,
                        savingmount: savingAmount,
                        account: account,
                        interestRate: interestRate,
                        interestPaydate: interestPaydate,
                        loanPayType: loanPayType,
                        password: password,
                        monthlyPayment: monthlyPayment
                    },
                    success: function (response) {
                        // 성공적으로 요청이 완료되면 여기의 코드가 실행됩니다.
                        console.log(response);
                    },
                    error: function (xhr, status, error) {
                        // 오류 발생 시 실행됩니다.
                        console.error(error);
                    }
                });
            });
        });
    </script>
    <style>
        /* 기본 스타일 */
        .loan--audit--title {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            background-color: #f4f4f4;
        }

        .loan--audit--title, .firm_cal_head {
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .firm_cal_check {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* 테이블 스타일 */
        .loan_apply_table {
            width: 100%;
            border-collapse: collapse;
        }

        .loan_apply_table th, .loan_apply_table td {
            padding: 15px;
            border: 1px solid #e6e6e6;
        }

        .loan_apply_table th {
            background-color: #f7f7f7;
            font-weight: 600;
        }

        .form-control, .form-select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        /* 체크박스 스타일 */
        .form-check-input {
            margin-right: 10px;
            transform: scale(1.2);
        }

        .applyCheck {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .downloadApply img {
            width: 24px;
            margin-right: 10px;
        }
        .all-agree-btn {
            margin-top: 20px;
            text-align: center;
        }

        #agreeAll {
            padding: 10px 20px;
            background-color: #007BFF;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #agreeAll:hover {
            background-color: #0056b3;
        }

        .progress-bar {
            display: flex;
            justify-content: space-between;
            padding: 20px 0;
            width: 70%;
            margin: 0 auto;
            z-index: -1;
        }

        .progress-bar .step {
            width: 80%;
            margin: 10px 10px;
            position: relative;
            flex: 0.3;
            text-align: center;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 10px;  /* 네모모양으로 바꾸려면 이 줄을 삭제하십시오. */
            transition: background-color 0.3s ease;
            z-index: -1;
        }
    </style>

</head>
<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<h1 style="margin-left: 3%;">적금 신청</h1>
    <div class="firm_cal_check">
        <table class="loan_apply_table">
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
                <td>${product.subscriptionPeriod} 개월</td>

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


    <div class = "agree-apply">
        <div class="firm_cal_head" style="margin-top: 80px;">
            <div class="d-flex" style="margin-bottom: 10px;">
                <span class="material-icons-sharp" style="margin-right: 5px"></span>
                <h4>대출약관동의</h4>
            </div>
        </div>

        <div class="firm_cal_check">
            <div class="applyCheck">
                <div class="d-flex justify-content-center align-items-center">
                    <input class="form-check-input" type="checkbox" id=""
                           style="margin-right: 10px;">
                    <p>은행여신거래기본약관에 동의합니다.</p>
                </div>
                <a href="#" class="downloadApply"> <img
                        src="/resources/img/pdf-file.png" alt="">
                    <p>은행여신거래기본약관</p>
                </a>
            </div>
            <div class="applyCheck">
                <div class="d-flex justify-content-center align-items-center">
                    <input class="form-check-input" type="checkbox"
                           style="margin-right: 10px;">
                    <p>여신거래약정서에 동의합니다.</p>
                </div>
                <a href="#" class="downloadApply"> <img
                        src="/resources/img/pdf-file.png" alt="">
                    <p>여신거래약정서</p>
                </a>
            </div>
            <div class="applyCheck">
                <div class="d-flex justify-content-center align-items-center">
                    <input class="form-check-input" type="checkbox"
                           style="margin-right: 10px;">
                    <p>적금상품설명서를 읽고 이해했으며 동의합니다.</p>
                </div>
                <a href="#" class="downloadApply"> <img
                        src="/resources/img/pdf-file.png" alt="">
                    <p>적금상품설명서</p>
                </a>
            </div>
            <div class="applyCheck">
                <div class="d-flex justify-content-center align-items-center">
                    <input class="form-check-input" type="checkbox"
                           style="margin-right: 10px;">
                    <p>SMS 메일 수신에 동의합니다.</p>
                </div>
                <a href="#" class="downloadApply"> <img
                        src="/resources/img/pdf-file.png" alt="">
                    <p>메일동의서</p>
                </a>
            </div>
            <div class="all-agree-btn">
                <button id="agreeAll">모두 동의하기</button>
            </div>
        </div>

    </div>
    <div style="text-align: center; margin : 5%">
        <button id="submitButton2">확인</button>
    </div>


</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

</html>