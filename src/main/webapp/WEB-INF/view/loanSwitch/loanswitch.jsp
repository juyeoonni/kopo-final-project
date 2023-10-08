<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>대출 상환 계산기</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel = "stylesheet" href = "/css/loan.css">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Bootstrap JS library -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


    <script>
        function toggleDetails(loanCard) {
            const details = loanCard.querySelector('.loan-details');
            if (details.style.display === 'none' || !details.style.display) {
                details.style.display = 'block';
            } else {
                details.style.display = 'none';
            }
        }

    </script>
    <style>
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .loan-container {
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); /* 카드의 너비를 250px로 설정하고 화면 크기에 따라 자동으로 개수 조정 */
            gap: 20px; /* 카드 사이의 간격 */
        }

        .text-gray-30, .text-gray-40 {
            --tw-text-opacity: 1!important;
        }
        .text-gray-30 {
            color: #333!important;
            color: rgb(51 51 51/var(--tw-text-opacity))!important;
        }
        .tracking-\[-0\.02em\] {
            letter-spacing: -.02em!important;
        }
        .leading-\[26\.4px\] {
            line-height: 26.4px!important;
        }
        .font-bold {
            font-weight: 700!important;
        }
        .text-2xl {
            font-size: 1.5rem!important;
            line-height: 2rem!important;
        }
        .mb-2 {
            margin-bottom: 0.5rem!important;
        }
        .h1--text {
            width: 50%;
            margin: 0 auto;  /* 상하로 20px 마진 추가 */
            padding: 20px;  /* 패딩 20px로 설정 */
        }

        .modal-header {
            justify-content: center; /* 헤더 내의 아이템들을 가운데로 정렬 */
        }
        .header-image {
            width: 250px;
            margin-left: 95px; /* 이미지와 닫기 버튼 사이의 간격을 줄임 */
        }

        .btn-connect {
            background-color: #60ca91;
            border-color: #60ca91;
        }


        .btn-connect:hover {
            background-color: #4fa97a; /* 조금 더 어두운 색상으로 설정하여 호버 효과 추가 */
            border-color: #4fa97a;
        }


        .modal-footer {
            display: flex;
            align-items: center; /* 아이템들을 수직으로 중앙 정렬 */
            justify-content: flex-end; /* 아이템들을 수평으로 오른쪽 정렬 */
        }

    </style>
</head>

<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<main>

    <div class="h1--text">
        <h1 class="mb-2 text-2xl font-bold leading-[26.4px] tracking-[-0.02em] text-gray-30">대출 갈아타기</h1>
    </div>


    <div class="section-container">

        <!-- Section 1: 금융사에서 나의 대출 가져오기 -->
        <section class="step" id="section1">
            <b>1. 금융사 대출 정보 가져오기</b>
            <hr>
            <button onclick="showNextSection('section2')"><b style="font-size: 14px">마이데이터 연동하기</b></button>
        </section>
    </div>
    <br />
    <!-- Section 2: 대출 선택하기 -->
    <div class="section-container">
        <section class="step" id="section2">
            <b>2. 받은 대출 정보 확인 및 선택</b>
            <hr>
            <div class="btn-container" style="display: flex; justify-content: center; align-items: center;">
                <img src="/img/lbtn.png" id="scrollLeftBtn" style="cursor: pointer;  width: 50px; margin-right: 1%">
                <div class="loan-container" id="loanList">
                    <div class="loan-details" style="display: none;">
                        <!-- 상세 정보 내용 -->
                    </div>
                </div>
                <img src="/img/rbtn.png" id="scrollRightBtn" style="cursor: pointer; width: 50px; margin-left: 1%">
            </div>
            <div style="display: flex; justify-content: center; align-items: center; margin-top: 20px;">
                <!-- 추가한 div. 버튼을 중앙에 위치시키기 위해 flexbox를 사용합니다. -->
                <button id="showPopupBtn" ><b style="font-size: 15px">올 크레딧 연동하고, 최적의 대출 찾기</b></button>
            </div>
        </section>
    </div>
    <br />
    <!-- Section 3: 금리 비교 및 대출 변경 -->
    <div class="section-container">
        <section class="step" id="section3">
        </section>
    </div>
</main>
<!-- 로딩 인디케이터 -->
<div id="loadingIndicator">
    <div class="loading-content">
        <b style="font-size: 24px">마이데이터 연동중..</b>
        <img src = "/img/mydata.gif" width="100%">
    </div>
</div>

<!-- 은행 선택 팝업 주변 투명 검정-->
<div id="overlay" class="hidden"></div>

<!-- 팝업 창 -->
<div class="modal fade" id="bankPopup" tabindex="-1" aria-labelledby="bankPopupLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <b class="modal-title" id="bankPopupLabel">연동할 은행을 선택해주세요</b>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <div class="row">
                    <div class="col-md-6 mb-2">
                        <button class="bank-btn btn btn-outline-primary d-block w-100" onclick="selectBank('우리은행')">
                            <img src="/img/WOORI.png" width="40px" height="40px">
                            <br />
                            우리은행
                        </button>
                    </div>
                    <div class="col-md-6 mb-2">
                        <button class="bank-btn btn btn-outline-primary d-block w-100" onclick="selectBank('국민은행')">
                            <img src="/img/KB.png" width="40px" height="40px">
                            <br />
                            국민은행
                        </button>
                    </div>
                    <div class="col-md-6 mb-2">
                        <button class="bank-btn btn btn-outline-primary d-block w-100" onclick="selectBank('신한은행')">
                            <img src="/img/SH.png" width="40px" height="40px">
                            <br />
                            신한은행
                        </button>
                    </div>
                    <div class="col-md-6 mb-2">
                        <button class="bank-btn btn btn-outline-primary d-block w-100" onclick="selectBank('기업은행')">
                            <img src="/img/IBK.png" width="40px" height="40px">
                            <br />
                            기업은행
                        </button>
                    </div>
                    <div class="col-md-6 mb-2">
                        <button class="bank-btn btn btn-outline-primary d-block w-100" onclick="selectBank('농협은행')">
                            <img src="/img/NH.png" width="40px" height="40px">
                            <br />
                            농협은행
                        </button>
                    </div>
                    <div class="col-md-6 mb-2">
                        <button class="bank-btn btn btn-outline-primary d-block w-100" onclick="selectBank('토스뱅크')">
                            <img src="/img/TOSS.png" width="40px" height="40px">
                            <br />
                            토스뱅크
                        </button>
                    </div>
                </div>

                <hr>
            </div>
            <div class="modal-footer justify-content-end">
                <button class="btn btn-primary btn-connect" onclick="loadLoanData()">연동하기</button>
            </div>
        </div>
    </div>
</div>




<!-- Bootstrap 모달로 변환된 코드 -->
<div class="modal" tabindex="-1" role="dialog" id="myModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <img src="/img/all-credit.png" alt="Image" class="header-image">

                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <label for="username" class="input-label">아이디:</label>
                <input type="text" id="username" class="input-field">
                <br>
                <label for="password" class="input-label">비밀번호:</label>
                <input type="password" id="password" class="input-field">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="loginBtn">로그인</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<div id="loanProductsContainer"></div>


<!-- Bootstrap 모달 형식의 'savingsModal' -->
<div class="modal fade" id="savingsModal" tabindex="-1" role="dialog" aria-labelledby="savingsModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="savingsModalLabel">절약액 정보</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="monthlySavings">월 절약액: </p>
                <p id="totalSavings">총 절약액: </p>
                <p style="color: red; font-size: small;">제시된 절약값은 기존 대출 기간, 상환방식에 따른 데이터의 추정치입니다. <br />
                    실제 대출조건(대출기간, 상환방식)에 따라 많은 차이가 발생할 수 있습니다.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-connect" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- Data Modal -->
<div class="modal" tabindex="-1" role="dialog" id="dataModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">하나 360</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body d-flex flex-column align-items-center">
                <img src="/img/All-credit.png" class="mb-3">
                <p class="mb-4 text-center"><strong>올 크레딧 연동 결과, 신용점수는 <span id="creditScoreText" style="color: red;">Loading...</span> 점입니다.</strong></p>

                <table class="table table-bordered table-striped text-center">
                    <thead>
                    <tr>
                        <th>구분</th>
                        <th>점수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr><td>상환점수</td><td id="repaymentScoreText"></td></tr>
                    <tr><td>대출점수</td><td id="loanScoreText"></td></tr>
                    <tr><td>신용위험도점수</td><td id="creditRiskText"></td></tr>
                    <tr><td>신용거래점수</td><td id="creditPeriodScoreText"></td></tr>
                    </tbody>
                </table>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-connect" data-dismiss="modal">추천 대출 보기</button>
            </div>
        </div>
    </div>
</div>


<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

<script src="/js/script.js"></script>
<script src="/js/loan.js"></script>

</body>


</html>
