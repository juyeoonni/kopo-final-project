<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>대출 상환 계산기</title>
    <link rel="stylesheet" href="/css/styles.css">
    <style>


        .step {
            display: none;
        }

        .step.active {
            display: block;
        }

        button {
            padding: 10px 15px;
            background-color: #60ca91;
            border: none;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
            margin-top: 10px;
        }

        button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        #loanList {
            margin-top: 20px;
        }

        .loan-card {
            border: 1px solid #e0e0e0;
            padding: 10px 20px;
            margin-bottom: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            background-color: #fff;
        }

        .loan-card:hover {
            border-color: #60ca91;
        }

        .loan-card-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .loan-card-selected {
            background-color: #f0f0f0;
            border-color: #60ca91;
        }

        /* 큰 네모칸에 대한 스타일 */
        .loan-container {
            display: flex;            /* flexbox 사용 */
            flex-wrap: wrap;          /* 요소가 컨테이너의 너비를 초과하면 다음 행으로 이동 */
            height: 250px;
            width : 500px;
            border: 2px solid #e0e0e0;
            padding: 10px;
            border-radius: 10px;
        }

        .loan-card {
            /* ... 기존 스타일 ... */
            flex: 1;                  /* 모든 카드가 동일한 공간을 차지하도록 설정 */
            margin: 10px;              /* 카드 사이의 간격 */
            min-width: 200px;         /* 카드의 최소 너비 설정 */
        }

        /* 기존에 있던 스타일 하단에 추가 */
        section {
            width: 60%; /* 가로 길이를 60%로 설정 */
            margin: 0 auto; /* 상하는 원래대로, 좌우 마진을 auto로 설정하여 화면 가운데로 위치시킴 */
            padding: 20px 0; /* 필요에 따라 패딩을 추가하여 안쪽 여백을 조절할 수 있습니다. */
        }

        h2 {
            width: 60%; /* 가로 길이를 60%로 설정 */
            margin: 0 auto; /* 상하는 원래대로, 좌우 마진을 auto로 설정하여 화면 가운데로 위치시킴 */
            padding: 20px 0; /* 필요에 따라 패딩을 추가하여 안쪽 여백을 조절할 수 있습니다. */
        }
        section > h3{
            margin: 3% important;
        }
        .section-container {
            width: 50%;
            margin: 0 auto;  /* 상하로 20px 마진 추가 */
            padding: 20px;  /* 패딩 20px로 설정 */
            border: 1px solid #ffffff;  /* 테두리 설정 */
            border-radius: 5px;  /* 테두리 둥글게 */
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);  /* 그림자 효과 */
            background-color: #ffffff;  /* 배경색 설정 */
        }




    </style>
</head>

<body>
<div id="container">
    <header class="header">
        <jsp:include page="../../layout/header.jsp" />
    </header>
    <div class="blank"></div>
    <main>
        <h2>대출 갈아타기</h2>
        <div class="section-container">  <!-- 추가된 부분 -->
            <!-- Section 1: 금융사에서 나의 대출 가져오기 -->
            <section class="step" id="section1">
                <h3>1. 금융사 대출 정보 가져오기</h3>
                <hr>
                <button onclick="showNextSection('section2')">마이데이터 연동하기</button>
            </section>
        </div>
        <br />
        <!-- Section 2: 대출 선택하기 -->
        <div class="section-container">
            <section class="step" id="section2">
                <h3>2. 받은 대출 정보 확인 및 선택</h3>
                <hr>
                <div class="loan-container" id="loanList">
                    <div class="loan-card" onclick="selectLoan(this, '대출 1', '5%', '1,000,000원')">
                        <div class="loan-card-title">KB 매직카 대출</div>
                        <p>은행: 국민은행</p>
                        <p>금리: 5%</p>
                        <p>대출금액: 1,000,000원</p>
                    </div>
                    <div class="loan-card" onclick="selectLoan(this, '대출 2', '6%', '2,000,000원')">
                        <div class="loan-card-title">우리 주거래은행 대출 </div>
                        <p>은행: 우리은행</p>
                        <p>금리: 6%</p>
                        <p>대출금액: 2,000,000원</p>
                    </div>
                    <!-- 기타 다른 대출 카드들... -->
                </div>
                <button onclick="showNextSection('section3')">홈텍스 연동해서, 최적의 대출 찾기</button>
            </section>
        </div>
        <br />
        <!-- Section 3: 금리 비교 및 대출 변경 -->
        <div class="section-container">
            <section class="step" id="section3">
                <h3>3. 최적의 대출로 변경하기</h3>
                <hr>
                <div id="bestLoan">최적의 대출 정보가 여기에 표시됩니다.</div>
                <br />
                <h3>최적의 대출</h3>
                <hr>
                <br />
                <div class="loan-container" id="loanList2">
                    <div class="loan-card" onclick="selectLoan(this, '대출 1', '5%', '1,000,000원')">
                        <div class="loan-card-title">KB 매직카 대출</div>
                        <p>은행: 국민은행</p>
                        <p>금리: 5%</p>
                        <p>대출금액: 1,000,000원</p>
                    </div>
                    <div class="loan-card" onclick="selectLoan(this, '대출 2', '6%', '2,000,000원')">
                        <div class="loan-card-title">우리 주거래은행 대출 </div>
                        <p>은행: 우리은행</p>
                        <p>금리: 6%</p>
                        <p>대출금액: 2,000,000원</p>
                    </div>
                    <!-- 기타 다른 대출 카드들... -->
                </div>

                <button>갈아타기 확인</button>
            </section>
        </div>
    </main>

    <footer class="footer">
        <jsp:include page="../../layout/footer.jsp" />
    </footer>
</div>

<script src="/js/script.js"></script>
<script>


    // 페이지 로딩 시 첫 번째 섹션만 보이게 설정합니다.
    window.onload = function() {
        document.getElementById('section1').style.display = 'block';
    }

    let selectedLoanData = {};

    function selectLoan(loanElement, title, interest, amount) {
        console.log(loanElement, title, interest, amount);
        //console.log(selectedLoanData); // 선택한 대출 정보 출력
        // 모든 대출 카드의 선택 효과를 제거
        const loanCards = document.querySelectorAll('.loan-card');
        loanCards.forEach(card => card.classList.remove('loan-card-selected'));

        // 클릭한 대출 카드에 선택 효과를 부여
        loanElement.classList.add('loan-card-selected');

        // 선택한 대출 카드의 정보 저장
        selectedLoanData = {
            title: loanElement.querySelector('.loan-card-title').textContent,
            interest: loanElement.querySelectorAll('p')[1].textContent.split(": ")[1],
            amount: loanElement.querySelectorAll('p')[2].textContent.split(": ")[1]
        };
    }

    function showNextSection(sectionId) {
        console.log("showNextSection() 호출됨");
        // 선택한 섹션만 보이게 합니다.
        document.getElementById(sectionId).style.display = 'block';

        // section3에 대출 정보를 전달
        if (sectionId === 'section3') {
            if (!selectedLoanData.title) {
                alert("대출 정보를 선택하세요!"); // 사용자에게 알려줍니다.
                return; // 함수를 종료하고 더 이상 진행되지 않도록 합니다.
            }
            const bestLoanDiv = document.getElementById('bestLoan');
            bestLoanDiv.innerHTML = `
            <p>선택한 대출: ${selectedLoanData.title}</p>
            <p>금리: ${selectedLoanData.interest}</p>
            <p>대출금액: ${selectedLoanData.amount}</p>
            <!-- 최적의 대출 정보 추가하기 -->
        `;
        }
    }
</script>
</body>


</html>
