<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="/css/bankClerk.css" />
    <link rel="stylesheet" href="/css/styles.css" />
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/data.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
</head>
<body>
<jsp:include page="../../layout/bankerHeader.jsp" />
<section class="details">
    <jsp:include page="../../layout/bankerSide.jsp" />
    <div class="detail__right">
        <h2 class="details____title">대출심사</h2>

        <div class="details__buttons">
            <button class="details__button">거절</button>
            <button class="details__button">승인</button>
        </div>
        <h3 class="details__subtitle">신청사항</h3>
        <table class="table table--info">
            <tr>
                <td>신청자</td>
                <td>김대출</td>
                <td>신청일자</td>
                <td>2023-08-30 22:17:47</td>
            </tr>

            <tr>
                <td>대출종류</td>
                <td>신용대출(갈아타기)</td>
                <td>담당자</td>
                <td>김관중</td>
            </tr>

            <tr>
                <td>대출금액</td>
                <td>100000000</td>
                <td>담당자 이메일</td>
                <td>email@email.com</td>
            </tr>

            <tr>
                <td>상환방법</td>
                <td>원리금균등상환</td>
                <td>대출기한(개월)</td>
                <td>12</td>
            </tr>
            <tr>
                <td>대출이자</td>
                <td>5.8</td>
                <td>대출금입금계좌</td>
                <td>000-000000-00000</td>
            </tr>
        </table>

        <div class="details__tabs">
            <div class="blank"></div>
            <input id="evaluation" type="radio" name="tab_item" />
            <label class="tab_item" for="evaluation">신용평가</label>
            <input id="financial" type="radio" name="tab_item" />
            <label class="tab_item" for="financial">부채상태표</label>
            <input id="recent" type="radio" name="tab_item" checked />
            <label class="tab_item" for="recent">자산상태표</label>

            <div class="tab_content" id="recent_content">
                <h4 class="tab__title">재무상태표</h4>
                <p class="tab__period">2022년 1월 1일 부터 2022년 12월 31일 까지</p>
                <p class="tab__unit">(단위: 원)</p>
                <table class="table table--recent">
                    <tr>
                        <td class="text--center text--bold td--bg" colspan="2">자산</td>
                        <td class="text--center text--bold td--bg" colspan="2">부채</td>
                    </tr>
                    <tr>
                        <td class="text--center text--bold td--bg">계정과목</td>
                        <td class="text--center text--bold td--bg">금액</td>
                        <td class="text--center text--bold td--bg">계정과목</td>
                        <td class="text--center text--bold td--bg">금액</td>
                    </tr>
                    <tr>
                        <td class="text--bold">자산</td>
                        <td></td>
                        <td class="text--bold">부채</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="text--bold">1. 유동자산</td>
                        <td></td>
                        <td class="text--bold">1. 유동부채</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="text--item">1. 현금및현금성자산</td>
                        <td class="text--center">156,395,000</td>
                        <td class="text--item">1. 매입채무및기타채무</td>
                        <td class="text--center">23,089,000</td>
                    </tr>
                    <tr>
                        <td class="text--item">2. 매출채권및기타채권</td>
                        <td class="text--center">82,111,000</td>
                        <td class="text--item">2. 단기차입금</td>
                        <td class="text--center">5,850,000</td>
                    </tr>
                    <tr>
                        <td class="text--item">3. 재고자산</td>
                        <td class="text--center">1,668,000</td>
                        <td class="text--item">3. 미지급비용</td>
                        <td class="text--center">4,500,000</td>
                    </tr>
                    <tr>
                        <td class="text--item">4. 단기금융상품</td>
                        <td class="text--center">9,000,000</td>
                        <td class="text--item">4. 미지급법인세</td>
                        <td class="text--center">3,133,000</td>
                    </tr>
                    <tr>
                        <td class="text--bold">&raquo; 유동자산 합계</td>
                        <td class="text--center">249,174,000</td>
                        <td class="text--bold">&raquo; 유동부채 합계</td>
                        <td class="text--center">36,572,000</td>
                    </tr>
                    <tr>
                        <td class="text--bold">2. 비유동자산</td>
                        <td></td>
                        <td class="text--bold">2. 비유동부채</td>
                    </tr>
                </table>
            </div>
            <div class="tab_content" id="financial_content">
                <figure class="highcharts-figure">
                    <div id="container"></div>
                    <h4 class="tab__title">요약제무표</h4>
                    <p class="tab__unit">(단위: 원)</p>

                    <table id="datatable" class="table table--financial">
                        <thead>
                        <tr>
                            <th class="td--bg"></th>
                            <th class="td--bg">4기</th>
                            <th class="td--bg">3기</th>
                            <th class="td--bg">2기</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th style="padding-left: 8px">자산</th>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <th class="text--item">1. 유동자산</th>
                            <td>50504</td>
                            <td>40504</td>
                            <td>28504</td>
                        </tr>
                        <tr>
                            <th class="text--item">2. 비유동자산</th>
                            <td>50504</td>
                            <td>40504</td>
                            <td>28504</td>
                        </tr>
                        <tr>
                            <th class="text--item">3. 유동부채</th>
                            <td>50504</td>
                            <td>40504</td>
                            <td>28504</td>
                        </tr>
                        <tr>
                            <th class="text--item">4. 비유동부채</th>
                            <td>50504</td>
                            <td>40504</td>
                            <td>28504</td>
                        </tr>
                        </tbody>
                    </table>
                </figure>
            </div>
            <div class="tab_content" id="evaluation_content">
                <div class="evaluation">
                    <div class="evaluation__inner">
                        <div class="evaluation__text">
                            <strong>김관중</strong>님의 DSR은<br />
                            <span>60%</span> 로 추정됩니다
                        </div>
                        <div class="evaluation__image"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
<script src="/js/bank.js"></script>
</body>
</html>

