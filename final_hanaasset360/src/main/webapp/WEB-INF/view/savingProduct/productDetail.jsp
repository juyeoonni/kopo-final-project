<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/loanSwitchStep2.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function sendData() {
            var productId = $('.green-btn').data('id');

            $.ajax({
                url: '/join-saving-product',
                type: 'POST',
                data: { productId: productId },
                success: function(response) {
                    window.location.href = "/savingProduct/join?productId=" + productId;
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    Swal.fire({
                        title: '오류!',
                        text: '데이터 전송 중 오류가 발생했습니다. 다시 시도하세요.',
                        icon: 'error',
                        confirmButtonText: '확인'
                    });

                }
            });
        }
    </script>
</head>
<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>

<div class="title-container" style="margin-top: 4%">
    <h1>적금 상세</h1>

</div>
<div class="loan-description">
    <h2>${product.name}</h2>
    <br />
    <p>${product.description}</p>
</div>

<main>

    <div class="highlight-info">
        <div class="highlight-container">
            <div class="highlight-circle">
                <!-- 월 최대 적립 금액 포맷팅 -->
                <span class="circle-value"><fmt:formatNumber value="${product.maxDepositAmount}" pattern="#,##0"/>원</span>
            </div>
            <span class="circle-label">월 최대 적립 금액</span>
        </div>
        <div class="highlight-container">
            <div class="highlight-circle">
                <strong class="circle-value"><fmt:formatNumber value="${product.maxSavings}" pattern="#,##0"/>원</strong>
            </div>
            <span class="circle-label">최대 가입 금액</span>
        </div>
        <div class="highlight-container">
            <div class="highlight-circle">
                <!-- 금리는 기존대로 출력 -->
                <strong class="circle-value">${product.annualExpectedReturn}%</strong>
            </div>
            <span class="circle-label">금리</span>
        </div>
        <div class="highlight-container">
            <div class="highlight-circle">
                <!-- 대출 기간 포맷팅 (소수점 제거) -->
                <strong class="circle-value"><fmt:formatNumber value="${product.subscriptionPeriod}" pattern="#,##0"/>개월</strong>
            </div>
            <span class="circle-label">대출 기간</span>
        </div>
    </div>

    <br />


    <button type="submit" class="green-btn" onclick="sendData()" data-id="${product.id}">가입하기</button>


    <br />
    <div class="loan--explain">

        <h2>상품 특징</h2>
        <p>${product.description}</p>

        <h2>가입 대상</h2>
        <ul>
            <li>만기 이자(전부 또는 일부)를 대전하나시티즌 후원 계좌로 이체 동의한 실명의 개인 및 개인사업자 (1인 1계좌)</li>
        </ul>

        <h2>가입 기간 및 금액</h2>
        <ul>
            <li>가입 기간: <fmt:formatNumber value="${product.subscriptionPeriod}" pattern="#,##0"/>개월</li>
            <li>가입 금액: <fmt:formatNumber value="${product.minSaving}" pattern="#,##0"/> 이상 ~ <fmt:formatNumber value="${product.maxSavings}" pattern="#,##0"/> 이하 (원 단위)</li>
            <li>적립 한도: 매월 <fmt:formatNumber value="${product.minDepositAmount}" pattern="#,##0"/>이상 ~ <fmt:formatNumber value="${product.maxDepositAmount}" pattern="#,##0"/> 이하 (원 단위)</li>
        </ul>

        <h2>이자 지급 방식</h2>
        <p>만기일시지급식: 만기(후) 해지 시 이자를 지급합니다.</p>
        <p>적립 방식: 자유적립식</p>

        <h2>만기 해지</h2>
        <p>이 예금은 만기 해지 시 세후 이자에 전액은 사전에 등록된 예금주 계좌에 입금합니다.</p>
        <ul>
            <li>이자 전액</li>
            <li>이자의 50%에 해당하는 금액</li>
            <li>이자의 10%에 해당하는 금액</li>
        </ul>

        <h2>금리</h2>
        <p>기준일자: 2023-10-04</p>
        <p>${prduct.name}</p>
        <table>
            <thead>
            <tr>
                <th>기간</th>
                <th>금리(연율, 세전)</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1년</td>
                <td>${product.annualExpectedReturn}%</td>
            </tr>
            </tbody>
        </table>

        <h2>우대 금리</h2>
        <p>최대 연 2.00% (2023.07.20 기준, 세전)</p>
        <ul>
            <li>하나카드 결제실적 연 1.00%</li>
            <li>마케팅 동의 연 0.50%</li>
            <li>하나원큐 Push 푸시알림 동의 연 0.50%</li>
        </ul>

        <h2>일부 해지</h2>
        <p>만기일 이전 2회까지 분할해지 가능하며, 일부해지 금액에 대해서는 가입일에 고시한 중도해지 금리를 적용합니다. (일부해지 후 예금잔액은 1만원 이상 유지)</p>

        <h2>세제 혜택</h2>
        <p>비과세종합저축 가입 가능합니다. (전 금융기관 통합한도 범위 내) 단, 만기 후 이자는 소득세 부과됩니다.</p>

        <h2>유의사항</h2>
        <ul>
            <li>적금 만기 시 이자의 전부 또는 일부를 대전하나시티즌 후원계좌(예금주 : 재단법인 하나금융축구단)로 자동 입금되는 상품으로 중도해지 시에는 후원되지 않습니다.</li>
            <li>후원 방법은 만기 전일까지 변경 가능합니다.</li>
        </ul>

        <h2>원금 및 이자 지급 제한</h2>
        <p>계좌에 압류, 가압류, 질권설정 등이 등록될 경우 원금 및 이자지급 제한 (일부해지 포함)</p>

        <h2>예금 잔액 증명서 발급 관련</h2>
        <p>예금잔액증명서 발급 당일에는 잔액 변동 불가</p>

        <h2>위법 계약 해지 권</h2>
        <p>금융소비자 보호에 관한 법률 제47조에 따른 위법계약해지 사유가 발생한 경우, 계약체결일로부터 5년 이내 범위에서 위반사실을 안 날로부터 1년 이내에 서면 등으로 해당 계약의 해지를 요구할 수 있습니다.</p>

    </div>

    <br />


</main>

</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

</html>