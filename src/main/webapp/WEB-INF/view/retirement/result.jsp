<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>은퇴 시뮬레이션</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/retire-style.css" />
    <link rel="stylesheet" href="/css/retire-reset.css" />
    <link rel="stylesheet" href="/css/retire-modal.css" />
    <link rel="stylesheet" href="/css/retire-main.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="http://code.highcharts.com/highcharts.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.3.0/chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
    <link
            rel="stylesheet"
            href="https://naver.github.io/billboard.js/release/latest/dist/theme/datalab.min.css"
    />
    <script>

        $(document).ready(function() {
            $.ajax({
                type: 'GET',
                url: '/api/products',
                dataType: 'json',  // <-- 추가된 부분
                success: function(data) {
                    console.log(data);
                    const innerContainer = $('.inner');

                    data.forEach(function(product, index) {
                        let slide =
                            '<div class="slide slide_' + (index+1) + '">' +
                            '<div class="slide-content">' +
                            '<img src="/img/tempImg.jpg" />' +
                            '<div class="slide-inner-content">' +
                            '<div class="slide-content-title">' + product.description + '</div>' +
                            '<div class="insurance-title">' +
                            '<div>' + product.name + '</div>' +
                            '<div>' +
                            '<span class="smaller-text">금리</span> ' + product.annualExpectedReturn + '<span class="smaller-text">%</span>' +
                            '</div>' +
                            '</div>' +
                            '<div class="insurance-button-wrapper">' +
                            '<button class="show-item-button insurance-button">상품정보</button>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';

                        innerContainer.append(slide);
                    });

                },
                error: function(error) {
                    console.error("Error fetching data: ", error);
                }
            });
        });
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
        <ul>
            <li>재무 설계</li>
            <li class="active">재무 설계 결과</li>
        </ul>
    </div>
    <p class="link_p txt_c_green"><a href="#">마이페이지</a></p>
</div>


<div class="whole-wrapper">
    <!-- 전체를 감싸고 있는 흰색 부분 -->
    <div class="wrapper">
        <div class="title">
            <div class="title-icon">■</div>
            <div>보유 자산 및 여유 자금 분석</div>
        </div>
        <!-- 자산정보와 여유자금을 감싸고 있는 부분 -->
        <div class="row-wrapper">
            <div class="twin-wrapper">
                <div class="subTitle">자산 정보</div>
                <div class="twin-inner-wrapper">
                    <!-- 그래프 -->
                    <div id="donutChart"></div>
                    <!-- 테이블 -->
                    <table class="small-table-blue">
                        <thead>
                        <tr>
                            <th>구분</th>
                            <th>금액</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>계좌 · 현금성 자산</td>
                            <td><fmt:formatNumber type="currency" value="${retireData.totalAssets}" currencySymbol=""/>원</td>
                        </tr>
                        <tr>
                            <td>기타 자산</td>
                            <td>0원</td>
                        </tr>
                        <tr>
                            <td>부채</td>
                            <td><fmt:formatNumber type="currency" value="${retireData.totalDebt}" currencySymbol="" />원</td>
                        </tr>
                        <tr>
                            <td>순자산</td>
                            <td><fmt:formatNumber type="currency" value="${retireData.totalAssets - retireData.totalDebt}" currencySymbol="" />원</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="twin-wrapper">
                <div class="subTitle">월 여유자금</div>
                <div class="twin-inner-wrapper">
                    <!-- 그래프 -->
                    <div class="bar-chart-container">
                        <canvas id="barChart1" height="350px"></canvas>
                    </div>
                    <!-- 테이블 -->
                    <table class="small-table-blue">
                        <thead>
                        <tr>
                            <th>${userName}</th>
                            <th>금액</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>수입</td>
                            <td>${fn:substringBefore((retireData.annualIncome div 12) div 10000, ".")}만원</td>
                        </tr>
                        <tr>
                            <td>지출</td>
                            <td>${fn:substringBefore((retireData.totalUsage div 12) div 10000, ".")}만원</td>
                        </tr>
                        <tr>
                            <td>여유자금</td>
                            <td>${fn:substringBefore(((retireData.annualIncome - retireData.totalUsage) div 12) div 10000, ".")}만원</td>
                        </tr>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
        <!-- 재무 목표별 분석을 감싸고있는 부분 -->
        <div class="bottom-wrapper">
            <div class="title">
                <div class="title-icon">■</div>
                <div>은퇴시뮬레이션 분석</div>
            </div>
            <div class="goal-wrapper">
                <div class="goal-title">은퇴 설계 분석</div>
                <!-- 재무 목표별 분석 내에 네모박스 부분 -->
                <div class="goal-total">
                    <div>
                        ${userName}님의 은퇴 예상 나이는
                        <span class="blue-span">${retireData.retirementAge}세</span>이며, 고객님의 은퇴자금 준비
                        기간은 <span class="blue-span">${retireData.retirementAge - retireData.age}년</span>입니다.
                    </div>
                    <div>
                        ${userName}님의 기대 수명은 <span class="blue-span">${retireData.lifeExpectancy}세</span>, 은퇴
                        준비 부족 자금은
                            <span class="pink-span"><fmt:formatNumber value="${simulationResults[0].financialGap}" type="number" pattern="#,###"/>원</span>
                            입니다.
                    </div>
                </div>
                <!-- 표 -->
                <div class="long-table">
                    <div>
                        <div>구분</div>
                        <div>은퇴 준비 자금</div>
                        <div>공적 연금</div>
                        <div>합계</div>
                    </div>
                    <div>
                        <div>준비 자금 금액</div>
                        <div><fmt:formatNumber value="${simulationResults[0].totalSavingsUntilRetirement}" type="number" pattern="#,###"/>원</div>
                        <div><fmt:formatNumber value="${simulationResults[0].totalRetirementNeeds - simulationResults[0].totalSavingsUntilRetirement - simulationResults[0].financialGap}" type="number" pattern="#,###"/>원</div>
                        <div><fmt:formatNumber value="${simulationResults[0].totalSavingsUntilRetirement + simulationResults[0].totalRetirementNeeds - simulationResults[0].totalSavingsUntilRetirement - simulationResults[0].financialGap}" type="number" pattern="#,###"/>원</div>
                    </div>
                    <div>
                        <div>필요 자금</div>
                        <div class="bigger-cell"><fmt:formatNumber value="${simulationResults[0].totalRetirementNeeds}" type="number" pattern="#,###"/>원</div>
                        <div><span class="pink-span"><fmt:formatNumber value="${simulationResults[0].totalRetirementNeeds}" type="number" pattern="#,###"/>원</span></div>
                    </div>
                    <div>
                        <div>부족 자금</div>
                        <div class="bigger-cell"><fmt:formatNumber value="${simulationResults[0].financialGap}" type="number" pattern="#,###"/>원</div>
                        <div><span class="blue-span"><fmt:formatNumber value="${simulationResults[0].financialGap}" type="number" pattern="#,###"/>원</span></div>
                    </div>
                </div>
                <!-- 하단의 누르면 모달이 열리는 부분입니다 -->
                <div id="openModal">
                    <div class="bottom-text-wrapper">
                        <div class="bottom-dark-blue-span">
                            노후 설계 준비 자금 만들기
                        </div>
                        <div>
                            ${userName}의
                            <span class="blue-span"
                            >과부족 금액을 위한</span
                            >
                            최적의 금융 상품을 추천해드려요!
                        </div>
                    </div>
                    <span class="arrow-next"></span>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-background">
        <div class="modal-wrapper">
            <div class="modal-title">
                ${userName}님의 안정한 노후를 위해,
                <span class="big-pink-span">적금 상품</span>을 추천합니다.
            </div>
            <div class="sort-option">금리(연율) 높은순</div>
            <div id="slider">
                <input type="radio" name="slider" id="slide1" checked />
                <input type="radio" name="slider" id="slide2" />
                <input type="radio" name="slider" id="slide3" />
                <input type="radio" name="slider" id="slide4" />
                <div class="arrow-wrapper">
                    <span class="prev"></span>
                    <span class="next"></span>
                </div>
                <div id="slides">
                    <div id="overflow">
                        <div class="inner">
                            <!-- 여기에 슬라이드 데이터를 동적으로 추가합니다 -->
                        </div>
                    </div>
                </div>

                <div id="controls">
                    <label for="slide1"></label>
                    <label for="slide2"></label>
                    <label for="slide3"></label>
                </div>
                <div id="bullets">
                    <label for="label1"></label>
                    <label for="label2"></label>
                    <label for="label3"></label>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- chart 관련 import 부분입니다-->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<script src="https://naver.github.io/billboard.js/release/latest/dist/billboard.pkgd.min.js"></script>
<script>
    let name = "${userName}";

    let monthlyIncome = parseInt("${fn:substringBefore((retireData.annualIncome div 12) div 10000, '.')}"); // 수입
    let monthlyExpense = parseInt("${fn:substringBefore((retireData.totalUsage div 12) div 10000, '.')}"); // 지출

    let totalDept = "${retireData.totalDebt}";
    let totalAssets = "${retireData.totalAssets}";

    const OPENMODAL = document.getElementById('openModal');
    const MODALBACK = document.querySelector('.modal-background');
    const MODALWRAPPER = document.querySelector('.modal-wrapper');

    //클릭 시 모달을 여는 설정입니다
    OPENMODAL.addEventListener('click', () => {
        MODALBACK.style.height = '100%';
        MODALWRAPPER.style.display = 'flex';
    });

    //모달 배경을 눌렀을 때 창이 닫히게 하는 설정입니다
    MODALBACK.addEventListener('click', (e) => {
        if (e.target !== MODALWRAPPER && e.target == MODALBACK) {
            MODALBACK.style.height = '0';
            MODALWRAPPER.style.display = 'none';
        }
    });

    //바 차트 관련 js 입니다
    //chart.js를 활용했습니다
    const barCtx1 = document.getElementById('barChart1');
    new Chart(barCtx1, {
        type: 'bar',
        data: {
            labels: ['월 소득', '월 소비'],
            datasets: [
                {
                    label: name,
                    data: [monthlyIncome, monthlyExpense],
                    borderWidth: 1,
                    backgroundColor: '#567BFF',
                },
            ],
        },
        plugins: [ChartDataLabels],
        options: {
            scales: {
                x: {
                    display: true,
                },
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'bottom',
                    labels: {
                        padding: 30,
                        usePointStyle: true,
                    },
                },
                datalabels: {
                    anchor: 'center',
                    font: {
                        weight: 'bold',
                    },
                    color: 'white', // 수치 레이블의 글자색 설정
                },
            },
        },
    });

    //도넛 차트 관련 js 입니다
    //billboard.js를 활용했습니다
    let chart = bb.generate({
        data: {
            columns: [
                ['계좌 · 현금성 자산', totalDept],
                ['대출', totalAssets],
            ],
            type: 'donut',
            onclick: function (d, i) {},
            onover: function (d, i) {},
            onout: function (d, i) {},
        },
        bindto: '#donutChart',
    });
</script>
<script src="/js/script.js"></script>

</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>
</html>
