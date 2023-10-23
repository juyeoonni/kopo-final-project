<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>은퇴 시뮬레이션</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/retire/retire-common.css">
    <link rel="stylesheet" href="/css/retire/retire-main.css">
    <link rel="stylesheet" href="/css/retire/retire-media.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .modal {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6); /* 흐릿한 배경 */
            overflow: auto;
            z-index: 1000;
        }

        .modal-content {
            background-color: #ffffff;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width:800px;
            border-radius: 10px;
            position: relative;
        }
        #loginModal .modal-content {
            width: 400px;  /* 작은 크기로 조절 */
        }

        #loginModal .modal-content h2::before {
            content: '';
            display: inline-block;
            background: url('/img/homtaxLogo.png') no-repeat center;
            background-size: contain;
            width: 30px;
            height: 30px;
        }

        /* pensionModal에 대한 스타일 */
        #pensionModal .modal-content {
            width: 800px;  /* 큰 크기로 유지 */
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close-btn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover{
            color: black;
        }

        .close-btn:hover {
            color: #000;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn_pink {
            background-color: #ff69b4;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn_pink:hover {
            background-color: #ff3d8b;
        }

        /* 로고 스타일 */
        .modal-content h2 {
            display: flex;
            align-items: center;
            gap: 10px;
        }


        .input-group {
            margin: 20px 0;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn_pink {
            padding: 10px 20px;
            background-color: #ff6b81;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
        }

        .btn_pink:hover {
            background-color: #ff8ba0;
        }

        /* 표 스타일 */
        table {
            width: 100%;
            border-collapse: collapse; /* 테두리 겹치게 */
        }

        th, td {
            border: 1px solid #ddd; /* 셀 테두리 */
            padding: 8px; /* 셀 안쪽 여백 */
            text-align: center; /* 텍스트 중앙 정렬 */
        }

        th {
            background-color: #f2f2f2; /* 헤더 배경색 */
        }

        tr:hover {
            background-color: #f5f5f5; /* 행에 마우스 오버 시 배경색 */
        }


        .plan_box input[type="text"] {
            height: 35px; /* 높이 조절 */
            width: 80px;
            padding: 10px; /* 텍스트와 input 경계 사이의 여백 추가 */
            font-size: 16px; /* 텍스트 크기 조절 */
        }

        .min_section table input[type="text"] {
            width: 120px;  /* 입력창의 너비 설정 */
            height: 35px;  /* 입력창의 높이 설정 */
            padding: 5px 10px;  /* 내부 패딩 설정 */
            font-size: 16px;  /* 글씨 크기 설정 */
            border: 1px solid #ccc;  /* 테두리 설정 */
        }

        .min_section .table_sec input[type="text"] {
            width: 80px;  /* 입력창의 너비 설정 */
            height: 35px;  /* 입력창의 높이 설정 */
            padding: 5px 10px;  /* 내부 패딩 설정 */
            font-size: 16px;  /* 글씨 크기 설정 */
            border: 1px solid #ccc;  /* 테두리 설정 */
        }

    </style>
    <script>
        function openModal() {
            document.getElementById('loginModal').style.display = "block";
        }

        function closeModal() {
            document.getElementById('loginModal').style.display = "none";
        }

        $(document).ready(function() {
            $("form").on("submit", function(event) {
                event.preventDefault(); // 폼의 기본 제출 동작을 막습니다.

                var formData = {
                    username: $("#username").val(),
                    password: $("#password").val()
                };

                $.ajax({
                    type: "POST",
                    url: "/retirement/hometax",
                    contentType: "application/json", // 내용 유형을 JSON으로 설정
                    data: JSON.stringify(formData),  // 데이터를 JSON 문자열로 변환
                    success: function(response) {
                        if (response && response.length > 0) {
                            // 첫 번째 응답값을 사용합니다. 다른 로직이 필요하다면 변경하세요.
                            var data = response[0];

                            // 연 지출 계산
                            var annualExpenditure = data.creditCardUsage + data.debitCardUsage + data.cashReceipt;

                            // 월 소비금액 계산
                            var monthlyExpenditure = annualExpenditure / 12;

                            // 은퇴 후 예상 생활비 계산
                            var expectedRetirementExpenditure = monthlyExpenditure * 0.7;

                            // 원 단위 값을 만원 단위로 변환하고 소수점 이하 제거
                            var monthlyExpenditureInTenThousands = Math.round(monthlyExpenditure / 10000);
                            var expectedRetirementExpenditureInTenThousands = Math.round(expectedRetirementExpenditure / 10000);

                            // 값을 입력 요소에 설정
                            $("p > input[name='current_monthly_expenditure']").val(monthlyExpenditureInTenThousands);
                            $("p > input[name='expected_retirement_expenditure']").val(expectedRetirementExpenditureInTenThousands);
                            closeModal();
                            Swal.fire({
                                title: '성공!',
                                text: '로그인 성공',
                                icon: 'success',
                                confirmButtonText: '확인'
                            });
                        } else {
                            Swal.fire({
                                title: '실패!',
                                text: '로그인 실패: 응답 데이터가 비어 있습니다.',
                                icon: 'error',
                                confirmButtonText: '확인'
                            });
                        }
                    },
                    error: function(error) {
                        // 요청 처리 중에 오류가 발생한 경우 실행될 코드를 작성합니다.
                        Swal.fire({
                            title: '실패!',
                            text: '로그인 실패: 응답 데이터가 비어 있습니다.',
                            icon: 'error',
                            confirmButtonText: '확인'
                        });
                    }
                });
            });
        });

        $(document).ready(function() {
            $("#loadAssets").on("click", function() {
                $.ajax({
                    type: "GET",
                    url: "/accounts-info",
                    success: function(response) {
                        // 결과 확인용
                        console.log(response);

                        // accountBalance의 합계 계산
                        var totalBalance = 0;
                        $.each(response, function(index, account) {
                            totalBalance += account.accountBalance;
                        });

                        // 합계 값을 문자열 형태로 포맷팅하고 천 단위로 쉼표(,)를 추가합니다.
                        var formattedBalance = totalBalance.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                        // 해당 <input> 요소에 합계 값을 설정합니다.
                        $("#otherBankTotal").val(formattedBalance);
                        $.ajax({
                            type: "GET",
                            url: "/hana-accounts-info",
                            success: function(response2) {
                                // 두 번째 요청의 응답을 처리하는 로직
                                console.log(response2);
                                var totalBalance2 = 0;
                                $.each(response2, function(index, accounts) {
                                    totalBalance2 += accounts.accountBalance;
                                });
                                var formattedBalance2 = totalBalance2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                $("input[name='hanaBankTotal']").val(formattedBalance2);  // 해당 입력 필드에 값 설정
                            },
                            error: function(error2) {
                                console.log(error2);
                                Swal.fire({
                                    title: '오류!',
                                    text: '두 번째 요청이 실패했습니다.',
                                    icon: 'error',
                                    confirmButtonText: '확인'
                                });
                            }
                        });

                        Swal.fire({
                            title: '성공!',
                            text: '금융 자산 정보를 불러왔습니다.',
                            icon: 'success',
                            confirmButtonText: '확인'
                        });
                    },
                    error: function(error) {
                        console.log(error);
                        Swal.fire({
                            title: '오류!',
                            text: '금융 자산 정보를 불러오는데 실패했습니다.',
                            icon: 'error',
                            confirmButtonText: '확인'
                        });
                    }
                });
            });
        });

        $(document).ready(function() {
            $("#loadLoans").on("click", function() {
                $.ajax({
                    type: "GET",
                    url: "/other-loans-info",  // "타행" 부채 정보를 가져오는 엔드포인트
                    success: function(response) {
                        var totalOtherLoan = 0;

                        $.each(response, function(index, loan) {
                            totalOtherLoan += loan.loanBalance;
                        });

                        var formattedOtherLoan = totalOtherLoan.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        $("input[name='otherLoanTotal']").val(formattedOtherLoan);

                        // 이제 "하나금융" 부채 정보를 가져옵니다.
                        $.ajax({
                            type: "GET",
                            url: "/hana-loans-info",  // "하나금융" 부채 정보를 가져오는 엔드포인트
                            success: function(responseHana) {
                                var totalHanaLoan = 0;

                                $.each(responseHana, function(index, loan) {
                                    totalHanaLoan += loan.loanBalance;
                                });

                                var formattedHanaLoan = totalHanaLoan.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                $("input[name='hanaLoanTotal']").val(formattedHanaLoan);

                                Swal.fire({
                                    title: '성공!',
                                    text: '금융 부채 정보를 불러왔습니다.',
                                    icon: 'success',
                                    confirmButtonText: '확인'
                                });

                            },
                            error: function(error) {
                                console.log(error);
                                Swal.fire({
                                    title: '오류!',
                                    text: '금융 부채 정보를 불러오는데 실패했습니다.',
                                    icon: 'error',
                                    confirmButtonText: '확인'
                                });

                            }
                        });
                    },
                    error: function(error) {
                        console.log(error);
                        Swal.fire({
                            title: '오류!',
                            text: '금융 부채 정보를 불러오는데 실패했습니다.',
                            icon: 'error',
                            confirmButtonText: '확인'
                        });
                    }
                });
            });
        });

        $(document).ready(function() {
            $("#connectHometaxBtn").on("click", function() {
                $.ajax({
                    type: "GET",
                    url: "/hometax-info",  // 여기에 실제 컨트롤러의 경로를 입력하세요.
                    success: function(response) {
                        if (response.length > 0) { // 추가된 검사 로직
                            var totalUsage = response[0].creditCardUsage + response[0].debitCardUsage + response[0].cashReceipt;
                            var formattedTotalUsage = totalUsage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                            $("input[name='totalUsage']").val(formattedTotalUsage);

                            var annualIncome = response[0].annualIncome;
                            var formattedAnnualIncome = annualIncome.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

                            $("input[name='annualIncome']").val(formattedAnnualIncome);
                            Swal.fire({
                                title: '성공!',
                                text: '홈택스 정보를 성공적으로 가져왔습니다.',
                                icon: 'success',
                                confirmButtonText: '확인'
                            });
                        } else {
                            console.log("Response does not contain any data.");
                        }
                    },
                    error: function(error) {
                        // 요청 처리 중에 오류가 발생한 경우 실행될 코드를 작성합니다.
                        Swal.fire({
                            title: '오류!',
                            text: '홈택스 연동에 실패했습니다.',
                            icon: 'error',
                            confirmButtonText: '확인'
                        });
                    }
                });
            });
        });

        $(document).ready(function() {
            $("#submitButton").on("click", function(event) {
                event.preventDefault();

                var data = {
                    userBirth: $("#userBirth").text(),
                    age: parseInt($("#userAge").text(), 10),
                    retirementAge: parseInt($("input[name='retirementAge']").val(), 10),
                    lifeExpectancy: parseInt($("input[name='lifeExpectancy']").val(), 10),

                    // 원과 콤마 제거 후 숫자로 변환
                    monthlyExpenditure: parseInt($("input[name='current_monthly_expenditure']").val().replace(/원|,/g, ''), 10) * 10000,
                    retirementExpenditure: parseInt($("input[name='expected_retirement_expenditure']").val().replace(/원|,/g, ''), 10) * 10000,
                    hanaBankTotal: parseInt($("input[name='hanaBankTotal']").val().replace(/원|,/g, ''), 10),
                    otherBankTotal: parseInt($("#otherBankTotal").val().replace(/원|,/g, ''), 10),
                    otherAsset: parseInt($("input[name='otherAsset']").val().replace(/원|,/g, ''), 10),
                    hanaLoanTotal: parseInt($("input[name='hanaLoanTotal']").val().replace(/원|,/g, ''), 10),
                    otherLoanTotal: parseInt($("input[name='otherLoanTotal']").val().replace(/원|,/g, ''), 10),
                    otherDept: parseInt($("input[name='otherDept']").val().replace(/원|,/g, ''), 10),
                    totalUsage: parseInt($("input[name='totalUsage']").val().replace(/원|,/g, ''), 10),
                    annualIncome: parseInt($("input[name='annualIncome']").val().replace(/원|,/g, ''), 10),
                    pensionType: $("select[name='pensionType']").val(),
                    // 만원 단위를 실제 숫자로 변환
                    pension: parseInt($("input[name='pension']").val(), 10) * 10000
                };

                $.ajax({
                    type: "POST",
                    url: "/save-retirement-info",
                    data: JSON.stringify(data),
                    contentType: "application/json",
                    success: function(response) {
                        Swal.fire({
                            title: '성공!',
                            text: '성공적으로 제출 되었습니다.',
                            icon: 'success',
                            confirmButtonText: '확인'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = '/retirement/result';
                            }
                        });
                    },
                    error: function(error) {
                        console.log(error);
                        Swal.fire({
                            title: '오류!',
                            text: '데이터 저장에 실패했습니다.',
                            icon: 'error',
                            confirmButtonText: '확인'
                        });
                    }
                });
            });
        });

        function showModal() {
            document.getElementById("pensionModal").style.display = "block";
        }

        function closeModal2() {
            document.getElementById("pensionModal").style.display = "none";
        }
    </script>
</head>

<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<div class="plan_wrap">
    <div class="plan_top">
        <h4>
            <span class="txt_c_green">하나360 </span><span class="txt_c_pink">재무설계</span>
            <p>은퇴재무설계</p>
        </h4>
<%--        <ul class="step_wrap">--%>
<%--            <li class="active step_con">재무 설계</li>--%>
<%--            <li class="step_con">재무 설계 결과</li>--%>
<%--        </ul>--%>
    </div>
    <p class="link_p txt_c_green"><a href="#">마이페이지</a></p>

    <section class="section_01">
        <h2><b>01.</b>고객님의 정보를 입력해주세요.</h2>
        <div class="plan_box">
            고객님은 <i class="txt_c_pink" id="userBirth">${userBirth.substring(0, 10)}</i>, 현재 나이는 <i class="txt_c_pink" id="userAge">${age}</i>입니다.<br>
            고객님의 예상 은퇴 나이는 <input type="text" name="retirementAge"> 세 입니다.<br>
            고객님의 기대수명은 <input type="text" name="lifeExpectancy"> 세 입니다.

        </div>
    </section>

    <section class="section_02">
        <div class="flex_c_end">
            <h2><b>02.</b>목표별 필요 자금 정보를 입력해주세요.</h2>
            <div>
                <button class="btn_pink">은퇴생활비 통계</button>
                <button class="btn_green" onclick="openModal()">홈택스랑 연동하기</button>
            </div>
        </div>
        <div class="flex_c_end section_02_info">
            <div class="list_box">
                <p class="sub_title">은퇴 후 생활비</p>
                <ul>
                    <li>예상되는 은퇴 후 월 생활비를 입력해주세요.</li>
                    <li>현 생활비의 60 ~ 80%가 은퇴 후 월 적정생활비입니다.</li>
                    <li>홈택스와 연동하기를 통해,<br>하나360이 적정 은퇴 생활비(70%)를 추천해드립니다.</li>
                </ul>
            </div>
            <div class="plan_box">
                <p>고객님의 현재 월 소비금액은 <input type="text" name="current_monthly_expenditure"> 만원 입니다.</p>
                <p>고객님의 은퇴 후 예상 생활비는 <input type="text" name="expected_retirement_expenditure"> 만원 입니다.</p>
            </div>
        </div>
    </section>

    <section class="section_03">
        <h2><b>03.</b>고객님의 자산 정보를 입력해주세요.</h2>

        <div class="min_section">
            <div class="flex_c_end">
                <p class="sub_title">금융 자산 정보</p>
                <button class="btn_green" id="loadAssets">내 금융 자산 불러오기</button>
            </div>
            <table>
                <tr class="thead">
                    <td rowspan="2">본인</td>
                    <td>하나금융</td>
                    <td>타행</td>
                    <td>기타</td>
                </tr>
                <tr>
                    <td><input type="text" name="hanaBankTotal"> 원</td>
                    <td><input type="text" id="otherBankTotal" name=""> 원</td>
                    <td><input type="text" name="otherAsset"> 원</td>
                </tr>
            </table>
        </div>


            <div class="min_section">
                <div class="flex_c_end">
                    <p class="sub_title">금융 부채 정보</p>
                    <button class="btn_green" id="loadLoans">내 금융 부채 불러오기</button>
                </div>
                <table>
                    <tr class="thead">
                        <td rowspan="2">본인</td>
                        <td>하나금융</td>
                        <td>타행</td>
                        <td>기타</td>
                    </tr>
                    <tr>
                        <td><input type="text" name="hanaLoanTotal" > 원</td>
                        <td><input type="text" name="otherLoanTotal"> 원</td>
                        <td><input type="text" name="otherDept"> 원</td>
                    </tr>
                </table>
            </div>

        <div class="min_section">
            <div class="flex_c_end">
                <p class="sub_title">종합 소득 및 지출</p>
                <button class="btn_pink" id="connectHometaxBtn">홈택스랑 연동하기</button>
            </div>
            <table>
                <tr class="thead">
                    <td rowspan="2">본인</td>
                    <td>소득금액</td>
                    <td>지출금액</td>
                    <td>지출비율</td>
                </tr>
                <tr>
                    <td><input type="text" id="annualIncome" name="annualIncome" oninput="calculateExpenseRatio()"> 원</td>
                    <td><input type="text" id="totalUsage" name="totalUsage" oninput="calculateExpenseRatio()"> 원</td>
                    <td id="expenseRatio"></td>
                </tr>

            </table>


        </div>


        <div class="min_section">
            <p class="sub_title">연금정보</p>
            <div class="table_box">
                <div class="table_fir">본인</div>
                <div class="table_sec">
                    <p>
                        예상하시는
                        <select name="pensionType">
                            <option>연금(총액)</option>
                            <option>국민연금(직장)</option>
                            <option>국민연금(직장)2</option>
                            <option>국민연금(직장)3</option>
                        </select>
                        은 65세부터, 월 수령액은 <input type="text" name="pension"> 만원 입니다.
                    </p>
                    <button class="btn_green" onclick="showModal()">국민연금수령액 예시 정보</button>
                </div>
            </div>
        </div>

    </section>

    <div class="plan_bot">
        <button class="btn_green" id="submitButton">제출</button>
    </div>

</div>
<!-- 로그인 모달 부분 -->
<div id="loginModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2>홈택스 연동 로그인</h2>
        <form action="YOUR_SERVER_ENDPOINT" method="post">
            <div class="input-group">
                <label for="username">아이디:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="input-group">
                <button type="submit" class="btn_pink">로그인</button>
            </div>
        </form>
    </div>
</div>
<div id="pensionModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal2()">&times;</span>
        <h2>국민연금수령액 예시 정보</h2>
        <br />
        <table>
            <thead>
            <tr>
                <th>순번</th>
                <th>소득평균액(월)</th>
                <th>보험료가입기간(10년)</th>
                <th>15년</th>
                <th>20년</th>
                <th>25년</th>
                <th>30년</th>
                <th>35년</th>
                <th>40년</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>2,000,000원</td>
                <td>228,200원</td>
                <td>334,960원</td>
                <td>441,730원</td>
                <td>548,490원</td>
                <td>655,250원</td>
                <td>762,020원</td>
                <td>868,780원</td>
            </tr>
            <tr>
                <td>2</td>
                <td>2,100,000원</td>
                <td>233,540원</td>
                <td>342,810원</td>
                <td>452,070원</td>
                <td>561,330원</td>
                <td>670,600원</td>
                <td>779,860원</td>
                <td>889,120원</td>

            </tr>
            <!-- 나머지 행을 위한 자리를 여기에 추가할 수 있습니다. -->
            </tbody>
        </table>
    </div>
</div>

<script src="/js/script.js"></script>
<script>
    function calculateExpenseRatio() {
        const income = parseFloat(document.getElementById("annualIncome").value);
        const expense = parseFloat(document.getElementById("totalUsage").value);

        if(isNaN(income) || isNaN(expense) || income === 0) {
            document.getElementById("expenseRatio").innerText = "올바른 값 입력 필요";
            return;
        }

        const ratio = (expense / income * 100).toFixed(2);
        document.getElementById("expenseRatio").innerText = ratio + '%';
    }
</script>
</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

</html>
