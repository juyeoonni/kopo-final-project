<%@ page import="com.google.gson.Gson" %>
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
<script>
    var creditScore = ${credit.creditScore};
    var repaymentScore = ${credit.repaymentScore};
    var loanScore = ${credit.loanScore};
    var creditRisk = ${credit.creditRisk};
    var creditPeriodScore = ${credit.creditPeriodScore};

    function sendApproval() {
        // 데이터 가져오기
        const button = event.target;
        const loanExistingId = button.getAttribute('data-loan-existing-id');
        const loanId = button.getAttribute('data-loan-id');
        const loanExistingFinance = button.getAttribute('data-loan-finance');
        const userId = button.getAttribute('data-user-id');

        // 데이터를 JSON 형태로 정의
        const data = {
            loanExistingId: loanExistingId,
            loanId: loanId,
            loanExistingFinance : loanExistingFinance,
            userId : userId
        };

        // fetch를 사용하여 백엔드에 데이터 전송
        fetch('/approve-loan-switch', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(response => response.json())
            .then(data => {
                console.log('Success:', data);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    }
</script>
<jsp:include page="../../layout/bankerHeader.jsp" />
<section class="details">
    <jsp:include page="../../layout/bankerSide.jsp" />
    <div class="detail__right">
        <h2 class="details____title">대출심사</h2>

        <div class="details__buttons">
            <button class="details__button">거절</button>
            <button class="details__button" data-loan-existing-id="${loanExisting.loanRecordId}" data-loan-id="${loan.id}" data-loan-finance="${loanExisting.finance}" data-user-id="${user.userId}" onclick="sendApproval()">승인</button>
        </div>
        <h3 class="details__subtitle">기존 대출</h3>
        <table class="table table--info">
            <tr>
                <td>신청자</td>
                <td>${user.name}</td>
                <td>은행</td>
                <td>${loanExisting.finance}</td>
            </tr>

            <tr>
                <td>대출종류</td>
                <td>${loanExisting.loanProductId}</td>
                <td>중도상환수수료</td>
                <td>${loanExisting.overdue}</td>
            </tr>

            <tr>
                <td>대출금액</td>
                <td>${loanExisting.loanAmount}</td>
                <td>대출 잔액</td>
                <td>${loanExisting.loanBalance}</td>
            </tr>

            <tr>
                <td>상환방법</td>
                <td>${loanExisting.loanRepayment}</td>
                <td>대출종료일</td>
                <td>${loanExisting.loanEndDate}</td>
            </tr>
            <tr>
                <td>대출이자</td>
                <td>${loanExisting.interestRate}</td>
                <td>대출금상환계좌</td>
                <td>${loanExisting.repaymentAccount}</td>
            </tr>
        </table>
        <h3 class="details__subtitle">신청사항</h3>
        <table class="table table--info">
            <tr>
                <td>신청자</td>
                <td>${user.name}</td>
                <td>신청일자</td>
                <td>${loan.applicationDate}</td>
            </tr>

            <tr>
                <td>대출명</td>
                <td>${loan.newLoanName}</td>
                <td>해당은행</td>
                <td>${loan.newLoanFinance}</td>
            </tr>

            <tr>
                <td>대출종류</td>
                <td>신용대출(갈아타기)</td>
                <td>담당자</td>
                <td>${loggedInUser.name}</td>
            </tr>

            <tr>
                <td>대출금액</td>
                <td>${loanExisting.loanBalance}</td>
                <td>담당자 이메일</td>
                <td>email@email.com</td>
            </tr>

            <tr>
                <td>상환방법</td>
                <td>${loan.newLoanInRepayment}</td>
                <td>대출기한(년)</td>
                <td>${loan.newLoanPeriod}</td>
            </tr>
            <tr>
                <td>대출이자</td>
                <td>${loan.newLoanInterest}</td>
                <td>대출금상환계좌</td>
                <td>${loan.newLoanAccount}</td>
            </tr>
        </table>

        <div class="details__tabs">
            <div class="blank"></div>
            <input id="evaluation" type="radio" name="tab_item" />
            <label class="tab_item" for="evaluation">신용평가</label>
            <input id="financial" type="radio" name="tab_item" />
            <label class="tab_item" for="financial">신용상태표(KCB)</label>
            <input id="recent" type="radio" name="tab_item" checked />
            <label class="tab_item" for="recent">재무상태표(홈택스)</label>

            <div class="tab_content" id="recent_content">
                <h4 class="tab__title">재무상태표(홈택스)</h4>
                <p class="tab__period">${loan.applicationDate} 까지</p>
                <p class="tab__unit">(단위: 원)</p>
                <table class="table table--recent">
                    <tr>
                        <td class="text--center text--bold td--bg" colspan="2">수입</td>
                        <td class="text--center text--bold td--bg" colspan="2">지출</td>
                    </tr>
                    <tr>
                        <td class="text--center text--bold td--bg">계정과목</td>
                        <td class="text--center text--bold td--bg">금액</td>
                        <td class="text--center text--bold td--bg">계정과목</td>
                        <td class="text--center text--bold td--bg">금액</td>
                    </tr>
                    <tr>
                        <td class="text--bold">수입</td>
                        <td></td>
                        <td class="text--bold">지출</td>
                        <td></td>
                    </tr>

                    <tr>
                        <td class="text--item">1. 연소득</td>
                        <td class="text--center">${credit.annualIncome}</td>
                        <td class="text--item">1. 신용카드 지출</td>
                        <td class="text--center" id="creditCardUsage">${credit.creditCardUsage}</td>
                    </tr>
                    <tr>
                        <td class="text--item"></td>
                        <td class="text--center"></td>
                        <td class="text--item">2. 직불카드 지출</td>
                        <td class="text--center" id="debitCardUsage">${credit.debitCardUsage}</td>
                    </tr>
                    <tr>
                        <td class="text--item"></td>
                        <td class="text--center"></td>
                        <td class="text--item">3. 현금영수증</td>
                        <td class="text--center"  id="cashReceipt">${credit.cashReceipt}</td>
                    </tr>

                    <tr>
                        <td class="text--bold">&raquo; 수입 합계</td>
                        <td class="text--center">${credit.annualIncome}</td>
                        <td class="text--bold">&raquo; 소비 합계</td>
                        <td class="text--center" id="totalConsumption"></td>
                    </tr>

                </table>
            </div>
            <div class="tab_content" id="financial_content">
                <figure class="highcharts-figure">
                    <div id="container"></div>
                    <h4 class="tab__title">요약제무표</h4>
                    <p class="tab__unit">(단위: 점)</p>

                    <table id="datatable" class="table table--financial">
                        <thead>
                        <tr>
                            <th class="td--bg">종류</th>
                            <th class="td--bg">점수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th style="padding-left: 8px">신용점수</th>
                            <td>${credit.creditScore}</td>

                        </tr>
                        <tr>
                            <th class="text--item">1. 상환</th>
                            <td>${credit.repaymentScore}</td>
                        </tr>
                        <tr>
                            <th class="text--item">2. 부채</th>
                            <td>${credit.loanScore}</td>

                        </tr>
                        <tr>
                            <th class="text--item">3. 신용위험도</th>
                            <td>${credit.creditRisk}</td>

                        </tr>
                        <tr>
                            <th class="text--item">4. 신용거래기간도</th>
                            <td>${credit.creditPeriodScore}</td>

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
<script>// 각각의 값들을 불러옵니다.
let creditCardUsage = parseInt(document.getElementById('creditCardUsage').innerText, 10);
let debitCardUsage = parseInt(document.getElementById('debitCardUsage').innerText, 10);
let cashReceipt = parseInt(document.getElementById('cashReceipt').innerText, 10);

// 합계를 계산합니다.
let total = creditCardUsage + debitCardUsage + cashReceipt;

// 결과를 표시합니다.
document.getElementById('totalConsumption').innerText = total;
</script>
</body>
</html>

