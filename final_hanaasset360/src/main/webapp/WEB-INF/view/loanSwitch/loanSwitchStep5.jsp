<%@ page import="kr.ac.kopo.final_hanaasset360.user.vo.UserVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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


<body>
<div class="container mt-5">
    <ul class="list-unstyled d-flex justify-content-between">
        <li class="step">
            <div class="circle">1</div>
            <p>대출 상세</p>
        </li>
        <li class="step">
            <div class="circle">2</div>
            <p>약관동의</p>
        </li>
        <li class="step">
            <div class="circle">3</div>
            <p>서류제출</p>
        </li>
        <li class="step last active">
            <div class="circle">4</div>
            <p>대출 신청</p>
        </li>
    </ul>
</div>
<div class="container mt-5">
    <b style="font-size: 40px;" class="mb-5">대출 신청</b>

    <hr>

    <!-- 기존 대출 -->
    <div class="card mb-4">
        <div class="card-body">
            <b style="font-size: 20px;" class="card-title mb-4">기존 대출</b>
            <hr>
            <table class="table table-bordered">
                <tr>
                    <th><span class="text-danger">*</span> 대출종류</th>
                    <td colspan="4" id="loanName2"></td>
                    <th><span class="text-danger">*</span> 대출신청금액</th>
                    <td colspan="4" id="loanAmount2"></td>
                </tr>
                <tr>
                    <th><span class="text-danger">*</span> 대출이자</th>
                    <td colspan="4" id="interestRate2"></td>
                    <th><span class="text-danger">*</span> 중도상환수수료</th>
                    <td colspan="4" id="overdue2"></td>
                </tr>
            </table>
        </div>
    </div>

    <!-- 갈아탈 대출 -->
    <div class="card mb-4">
        <div class="card-body">
            <b style="font-size: 20px;" class="card-title mb-8">갈아탈 대출</b>
            <hr>
            <table class="table table-bordered">
                <tr>
                    <th><span class="text-danger">*</span> 대출종류</th>
                    <td colspan="1" id="loanName"></td>
                    <th><span class="text-danger">*</span> 대출금 상환은행</th>
                    <td colspan="2">
                        <select class="form-control custom-select-height" name="bankName" onchange="updateAccountOptions()">
                            <option value="하나은행">하나은행</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><span class="text-danger">*</span> 대출신청금액</th>
                    <td colspan="1" id="loanAmount"></td>
                    <th><span class="text-danger">*</span> 대출금 상환계좌</th>
                    <td colspan="2">
                        <select class="form-control custom-select-height" name="repaymentAccount" id="accountSelect">
                            <c:forEach var="account" items="${accounts}">
                                <option value="${account.accountId}">${account.accountId}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><span class="text-danger">*</span> 대출이자</th>
                    <td id="interestRate"></td>
                    <th><span class="text-danger">*</span> 이자납부일</th>
                    <td colspan="4">
                        <select class="form-control custom-select-height" name="interestPaydate">
                            <option value="1">매달 1일</option>
                            <option value="5">매달 5일</option>
                            <option value="10">매달 10일</option>
                            <option value="15">매달 15일</option>
                            <option value="20">매달 20일</option>
                            <option value="25">매달 25일</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><span class="text-danger">*</span> 상환방법</th>
                    <td>
                        <select class="form-control custom-select-height" name="loanPayType" id="loanPayTypeSelect">
                            <option value="원리금균등방식">원리금균등방식</option>
                            <option value="원금균등방식">원금균등방식</option>
                        </select>
                    </td>
                    <th><span class="text-danger">*</span> 희망대출기한</th>
                    <td>
                        <select class="form-control custom-select-height" name="loanTerm" id="loanTerm">
                            <option value="3">3년</option>
                            <option value="4">4년</option>
                            <option value="5">5년</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <!-- 대출약관동의 -->
    <div class="card mb-4">
        <div class="card-header">
            <h4>대출약관동의</h4>
        </div>
        <div class="card-body">
            <div class="form-check d-flex mb-2">
                <input class="form-check-input" type="checkbox" id="agree1">
                <label class="form-check-label" for="agree1">은행여신거래기본약관에 동의합니다.</label>
                <a href="#" class="ml-auto d-inline-block"><img src="/resources/img/pdf-file.png" alt=""> 은행여신거래기본약관</a>
            </div>
            <div class="form-check d-flex mb-2">
                <input class="form-check-input" type="checkbox" id="agree2">
                <label class="form-check-label" for="agree2">여신거래약정서에 동의합니다.</label>
                <a href="#" class="ml-auto d-inline-block"><img src="/resources/img/pdf-file.png" alt=""> 여신거래약정서</a>
            </div>
            <div class="form-check d-flex mb-2">
                <input class="form-check-input" type="checkbox" id="agree3">
                <label class="form-check-label" for="agree3">대출상품설명서를 읽고 이해했으며 동의합니다.</label>
                <a href="#" class="ml-auto d-inline-block"><img src="/resources/img/pdf-file.png" alt=""> 기업대출상품설명서</a>
            </div>
            <div class="form-check d-flex mb-2">
                <input class="form-check-input" type="checkbox" id="agree4">
                <label class="form-check-label" for="agree4">신용정보 및 제무상태 열람에 동의합니다.</label>
                <a href="#" class="ml-auto d-inline-block"><img src="/resources/img/pdf-file.png" alt=""> 열람동의서</a>
            </div>
            <div class="text-center mt-4">
                <button id="agreeAll" class="btn btn-primary">모두 동의하기</button>
            </div>
        </div>
    </div>

    <div class="text-center mb-5">
        <button id="submitButton2" class="btn btn-primary">확인</button>
    </div>
</div>


</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>