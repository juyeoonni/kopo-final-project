<%@ page import="kr.ac.kopo.final_hanaasset360.user.vo.UserVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>HanaAsset360</title>
    <link rel="stylesheet" href="/css/styles.css">
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

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

</head>
<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>


<div class=" mt-5">
    <ul class="list-unstyled d-flex justify-content-between">
        <li class="step">
            <div class="circle">1</div>
            <p>대출 상세</p>
        </li>
        <li class="step">
            <div class="circle">2</div>
            <p>약관동의</p>
        </li>
        <li class="step active">
            <div class="circle">3</div>
            <p>서류제출</p>
        </li>
        <li class="step last">
            <div class="circle">4</div>
            <p>대출 신청</p>
        </li>
    </ul>
</div>
<body>

<div class="loan-process container mt-5">
    <div class="title-container mb-4">
        <b style="font-size: 35px; font-family: 'Roboto', sans-serif;">서류제출</b>
    </div>

    <p class="text-primary mb-4" style="font-size: small; font-family: 'Roboto', sans-serif;">오늘 오후 4시까지 대출 진행할 수 있어요</p>
    <h3 class="mb-4" style="color: black; font-family: 'Roboto', sans-serif;">대출심사를 위한 서류준비</h3>

    <div class="loan-doc-card mb-4 mx-auto col-6">
        <h4 class="mb-2" style="font-size: medium; color: black; font-family: 'Roboto', sans-serif;">한 번에 가져오기</h4>
        <p class="text-muted mb-4" style="font-size: smaller;">공공마이데이터로 안전하고 간편하게</p>
        <div class="image-placeholder mb-4 text-center">
            <img src="/img/document.jpg" alt="검색어" class="img-fluid rounded-circle">
        </div>
    </div>

    <button class="btn btn-success btn-connect  mb-4 retrieve-doc-btn" onclick="showSmsAuthModal()">한번에 서류 조회</button>

    <!-- 서류조회 로딩 인디케이터 -->
    <div class="loading-overlay mb-4" id="loadingOverlay">
        <img src="/img/loading.gif" alt="Loading..." class="loading-icon">
    </div>
    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <b class="modal-title">국세청, 올크레딧 정보를 가져왔습니다.</b>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="row">
                        <!-- 홈택스 정보 -->
                        <!-- 홈택스 정보 -->
                        <div class="col-sm-6">
                            <img src="/img/homtax-image.jpg" alt="Homtax" class="img-fluid mb-3" style="max-width: 100px;">
                            <table class="table custom-table" id="homtaxInfo" style="display: none;">
                                <tbody>
                                <tr>
                                    <th>연소득</th>
                                    <td><span id="annualIncome">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>신용카드 사용액</th>
                                    <td><span id="creditCardUsage">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>직불카드 사용액</th>
                                    <td><span id="debitCardUsage">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>현금영수증</th>
                                    <td><span id="cashReceipt">불러오는 중...</span></td>
                                </tr>
                                </tbody>
                            </table>
                            <button class="btn btn-primary mb-2" onclick="toggleInfo('homtaxInfo')">홈택스 자세히 보기</button>
                        </div>

                        <!-- 올크레딧 정보 -->
                        <div class="col-sm-6">
                            <img src="/img/All-credit.png" alt="KCB" class="img-fluid mb-3" style="max-width: 120px;">
                            <table class="table custom-table" id="kcbInfo" style="display: none;">
                                <tbody>
                                <tr>
                                    <th>신용 점수</th>
                                    <td><span id="creditScore">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>신용거래점수</th>
                                    <td><span id="creditPeriodScore">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>상환점수</th>
                                    <td><span id="repaymentScore">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>부채점수</th>
                                    <td><span id="loanScore">불러오는 중...</span></td>
                                </tr>
                                <tr>
                                    <th>신용위험도점수</th>
                                    <td><span id="creditRisk">불러오는 중...</span></td>
                                </tr>
                                </tbody>
                            </table>
                            <button class="btn btn-primary mb-2" onclick="toggleInfo('kcbInfo')">올크레딧 자세히 보기</button>
                        </div>
                    </div>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="submitData()">제출</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

<%--    <div class="text-center mt-4" id="gostepdiv">--%>
<%--        <button id="gostep5" class="btn btn-primary" onclick="go()">다음</button>--%>
<%--    </div>--%>
</div>
<!-- 본인인증 모달 -->
<div class="modal" tabindex="-1" role="dialog" id="smsAuthModal">
    <div class="modal-dialog modal-md" role="document"> <!-- 모달 가로 길이 변경 -->
        <div class="modal-content">
            <div class="modal-header">
                <b>휴대폰 본인인증</b>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body pb-0">
                <div class="text-center mb-5 mt-5">
                    <img src="/img/smartphone.png" alt="본인인증" width="180px" height="180px">
                </div>

                <table class="table">
                    <tr>
                        <td><input type="text" class="form-control" id="phoneNumber" placeholder="하이폰(-) 제외"></td>
                        <td><button class="btn btn-primary" onclick="sendSmsRequest()">인증번호 받기</button></td>
                    </tr>
                    <tr>
                        <td><input type="text" class="form-control" id="userOuathNum" placeholder="인증번호를 입력하세요"></td>
                        <td><button class="btn btn-primary" onclick="verifySmsCode()">인증 확인</button></td>
                    </tr>
                </table>

                <div id="result"></div>

                <table class="table">
                    <tr>
                        <td><input type="checkbox" id="privacyPolicy"> 개인정보 수집에 동의합니다</td>
                    </tr>
                </table>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="nextButton" onclick="getDocument()" disabled>다음</button>
            </div>
        </div>
    </div>
</div>


<script src="/js/loanSwitchStep4.js"></script>
</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>