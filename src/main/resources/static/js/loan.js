<!-- 대출 정보를 불러오는 함수 -->
window.onload = function() {
    document.getElementById('section1').style.display = 'block';

}
let currentPosition = 1; // 초기값 설정
let total = 0;  // 여기에 선언
function loadLoanData() {
    const query = new URLSearchParams({
        banks: selectedBanks.join(',') // 선택한 은행 정보를 콤마로 구분된 문자열로 변환
    }).toString();
    console.log(query);
    closePopup(); // 은행 선택 팝업을 닫음

    document.getElementById('loadingIndicator').style.display = 'block';
    fetch(`/api/loan-data?${query}`, {
        method: "GET",
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => response.json())
        .then(data => {
            // 로딩 인케이터 숨김
            document.getElementById('loadingIndicator').style.display = 'none';
            // 서버로부터 받은 대출 데이터를 사용하여 loan-card 생성
            const loanList = document.getElementById('loanList');
            loanList.innerHTML = '';
            total = data.length;  // 값을 할당

            data.forEach((loan, index) => {
                const currentIndex = index + 1;


                console.log(loan);
                const loanCard = document.createElement('div');
                loanCard.className = "loan-card";
                loanCard.onclick = () => {
                    selectLoan(loanCard, loan.loanRecordID, loan.loanProductID || '대출명 : ', +loan.interestRate, loan.finance, loan.loanAmount, loan.loanBalance, loan.loanEndDate, loan.overdue, loan.repayment, loan.loanStartDate, loan.repaymentDate);
                    currentPosition = index + 1; // 현재 카드의 위치 업데이트
                    updatePositionIndicator();   // 위치 지시자의 텍스트 업데이트
                }
                const loanBankLogo = document.createElement('img');
                loanBankLogo.src = getBankImageUrl(loan.finance);
                loanBankLogo.alt = loan.finance + ' 로고';
                loanBankLogo.style.width = '80px';
                loanCard.appendChild(loanBankLogo);

                const contentWrapper = document.createElement('div');
                contentWrapper.style.flexGrow = '1'; // contentWrapper가 가능한 모든 여유 공간을 차지하도록 함
                loanCard.appendChild(contentWrapper);

                const loanTitle = document.createElement('div');
                loanTitle.className = "loan-card-title";
                loanTitle.textContent = loan.loanProductID;
                contentWrapper.appendChild(loanTitle);

                const detailsWrapper = document.createElement('div');
                detailsWrapper.className = "loan-details";
                detailsWrapper.style.display = "flex";          // flexbox를 활용
                detailsWrapper.style.flexDirection = "column";     // 수평 방향으로 나열
                contentWrapper.appendChild(detailsWrapper);

                detailsWrapper.appendChild(createDetailItem('대출 잔액 : ', Number(loan.loanBalance).toLocaleString() + '원'));
                detailsWrapper.appendChild(createDetailItem('금리 : ', loan.interestRate + '%'));

                const overdueText = document.createElement('p');
                overdueText.className = 'overdue';
                overdueText.textContent = '중도상환수수료 : ' + loan.overdue;
                contentWrapper.appendChild(overdueText);



                loanList.appendChild(loanCard);
            });

            const positionIndicator = document.createElement('div');
            positionIndicator.className = "position-indicator badge badge-primary";
            positionIndicator.textContent = `${1} / ${total}`;
            positionIndicator.style.display = "flex"; // flex로 설정
            positionIndicator.style.justifyContent = "center"; // 수평 가운데 정렬
            positionIndicator.style.alignItems = "center"; // 수직 가운데 정렬
            positionIndicator.style.margin = "3px auto 0 auto"; // 상단 20px, 수평 가운데 정렬
            positionIndicator.style.width = "36px"; // 원하는 너비 설정

            const section2 = document.getElementById('section2');
            const btnContainer = document.querySelector('.btn-container');
            section2.insertBefore(positionIndicator, btnContainer.nextSibling);

        })
        .catch(error => {
            // 에러시 로딩 인케이터 숨김
            document.getElementById('loadingIndicator').style.display = 'none';
            console.error('Error fetching loan data:', error);
            alert("연동 오류! 다시시도 하세요!");
        });
}

function updatePositionIndicator() {
    const positionIndicator = document.querySelector(".position-indicator");
    positionIndicator.textContent = `${currentPosition} / ${total}`;
}

function createDetailItem(label, value) {
    const detailItem = document.createElement('div');
    detailItem.style.padding = "3px 0"; // 상하 패딩 추가

    const combinedText = document.createElement('div');  // 라벨과 값을 결합한 전체 텍스트
    combinedText.textContent = `${label} ${value}`;
    detailItem.appendChild(combinedText);

    return detailItem;
}
let selectedLoanData = {};

function selectLoan(loanElement, loanRecordID, title, interest, bank, amount, balance, endDate, overdue, repayment, startDate, repaymentDate) {
    console.log(selectedLoanData); // 선택한 대출 정보 출력

    // 모든 대출 카드의 선택 효과를 제거
    const loanCards = document.querySelectorAll('.loan-card');
    loanCards.forEach(card => card.classList.remove('loan-card-selected'));

    // 클릭한 대출 카드에 선택 효과를 부여
    loanElement.classList.add('loan-card-selected');

    // 선택한 대출 카드의 정보 저장
    selectedLoanData = {
        id : loanRecordID,
        title: title,
        interest: interest,
        bank: bank,
        amount: amount,
        balance: balance,
        endDate: endDate,
        overdue: overdue,
        repayment: repayment,
        startDate: startDate,
        repaymentDate : repaymentDate
    };
}

function getBankImageUrl(bankName) {
    switch (bankName) {
        case '하나은행':
            return '/img/HANA.png';
        case '우리은행':
            return '/img/WOORI.png';
        // 추가 은행은 여기에...
        default:
            return ''; // 기본 이미지 URL 또는 빈 문자열
    }
}


function showNextSection(sectionId) {
    // 선택한 섹션만 보이게 합니다.
    document.getElementById(sectionId).style.display = 'block';

    if (sectionId === 'section2') {
        openPopup(); // 팝업을 엽니다.
        return; // 아래 로직을 실행하지 않습니다.
    }
    // section3에 대출 정보를 전달
    if (sectionId === 'section3') {
        if (!selectedLoanData.title) {
            alert("대출 정보를 선택하세요!"); // 사용자에게 알려줍니다.
            return; // 함수를 종료하고 더 이상 진행되지 않도록 합니다.
        }
        findMatchingLoans();

    }

}
// 새로운 함수로 은행 선택 UI를 보여줌
// 선택된 은행을 저장하는 배열
let selectedBanks = [];
// 팝업을 열고 닫는 함수
function openPopup() {
    $('#bankPopup').modal('show');
}
function closePopup() {
    $('#bankPopup').modal('hide');
}


function selectBank(bankName) {
    const index = selectedBanks.indexOf(bankName);

    if (index === -1) {
        // 눌렸을 때: bankName을 selectedBanks 배열에 추가하고 스타일 변경
        selectedBanks.push(bankName);
        document.querySelector(`button[onclick="selectBank('${bankName}')"]`).classList.add("bank-btn-selected");
    } else {
        // 다시 눌렸을 때: bankName을 selectedBanks 배열에서 제거하고 스타일 원복
        selectedBanks.splice(index, 1);
        document.querySelector(`button[onclick="selectBank('${bankName}')"]`).classList.remove("bank-btn-selected");
    }

    console.log(selectedBanks); // 선택된 은행 목록을 콘솔에 출력 (디버깅 목적)
}


function scrollLoanList(direction) {
    const loanContainer = document.getElementById('loanList');

    // 현재 스크롤 위치와 컨테이너의 너비를 이용하여 새로운 스크롤 위치 계산
    const currentScroll = loanContainer.scrollLeft;
    const containerWidth = loanContainer.clientWidth;


    // 왼쪽 또는 오른쪽으로 스크롤
    const newScroll = currentScroll + (containerWidth * 1 * direction);  // 0.8은 스크롤 비율입니다. 원하는대로 조정 가능
    loanContainer.scrollLeft = newScroll;
}

document.getElementById('scrollLeftBtn').addEventListener('click', function() {
    scrollLoanList(-1); // 왼쪽으로 스크롤
    if (currentPosition > 1) {
        currentPosition--;
        updatePositionIndicator();
    }
});

document.getElementById('scrollRightBtn').addEventListener('click', function() {
    scrollLoanList(1); // 오른쪽으로 스크롤
    if (currentPosition < total) {
        currentPosition++;
        updatePositionIndicator();
    }
});

$(document).ready(function() {
    $('#showPopupBtn').on('click', function() {
        $('#myModal').modal('show');
    });
});




// KCB 신용정보 기관에서 가져온 데이터
let creditData = null;
// KCB 신용정보 기관에 신용등급 호출 API 요청
document.addEventListener("click", function(event) {

    if (event.target.id === "loginBtn") {
        console.log("loginBtn is clicked");

        // 아이디와 비밀번호 값을 가져옵니다.
        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;
        console.log(username);
        console.log(password);
        // 여기에서 AWS EC2 서버로 API 호출을 하면 됩니다.
        fetch("/api/credit-data", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                username: username,
                password: password
            })
        })
            .then(response => response.json())
            .then(data => {
                alert("로그인 성공!");

                // 로그인이 성공적으로 완료되었을 경우의 로직
                creditData = data;
                console.log(data);
                // 주어진 점수들을 바인딩
                document.getElementById("creditScoreText").textContent = data.creditList[0].creditScore;
                document.getElementById("repaymentScoreText").textContent = data.creditList[0].repaymentScore;
                document.getElementById("loanScoreText").textContent = data.creditList[0].loanScore;
                document.getElementById("creditRiskText").textContent = data.creditList[0].creditRisk;
                document.getElementById("creditPeriodScoreText").textContent = data.creditList[0].creditPeriodScore;


                // 팝업 닫기
                $('#myModal').modal('hide'); // Bootstrap 모달 닫기 추가

                $('#dataModal').modal('show'); // data 모달

                showNextSection('section3');

            })
            .catch(error => {
                // 에러 발생 시 처리 로직
                console.log(error);

                alert("로그인 실패! 다시 시도하세요!");
            });
    }
});

function showPopup() {
    // 팝업을 보이게 함
    document.getElementById("bankPopup").style.display = "block";
    // 오버레이를 보이게 함
    document.getElementById("overlay").style.display = "block";
}

function closePopup2() {
    // 팝업을 숨김
    document.getElementById("bankPopup").style.display = "none";
    // 오버레이를 숨김
    document.getElementById("overlay").style.display = "none";
}





let selectedLoanProduct = null;
let loanProducts = []; // 전역 변수로 선언

function getLoanPeriod(startDateStr, endDateStr) {
    // 날짜와 시간을 분리
    startDateStr = startDateStr.split(" ")[0];
    endDateStr = endDateStr.split(" ")[0];

    console.log("Parsed Start Date String:", startDateStr); // 로깅
    console.log("Parsed End Date String:", endDateStr);    // 로깅

    const startDate = new Date(startDateStr);
    const endDate = new Date(endDateStr);

    // 두 날짜 간의 차이를 밀리초로 계산
    const diffTime = endDate - startDate;

    // 밀리초를 달 수로 변환. 1000 * 60 * 60 * 24 = 하루의 밀리초 수, 30 = 대략 한 달의 일수
    const diffMonths = Math.round(diffTime / (1000 * 60 * 60 * 24 * 30));

    return diffMonths;
}


function selectLoanProducts(index) {
    // 선택한 대출 상품 정보를 변수에 저장
    selectedLoanProduct = loanProducts[index];
    console.log(parseFloat(selectedLoanData.balance));
    console.log(parseFloat(selectedLoanData.interest));
    console.log(selectedLoanData.repayment);
    console.log(selectedLoanData.startDate);
    console.log(selectedLoanData.endDate);

    console.log(selectedLoanProduct.selectedCreditGrade);
    const period = getLoanPeriod(selectedLoanData.startDate, selectedLoanData.endDate);
    console.log(period);
    // 기존 대출 정보
    const oldLoan = {
        amount: parseFloat(selectedLoanData.balance),
        interestRate: parseFloat(selectedLoanData.interest) / 100,
        period: period,  // 예시로 10년 기준. 실제로는 대출 기간 데이터를 사용하세요.
        method: selectedLoanData.repayment  // 기존 대출의 상환방식. 실제 데이터로 변경 필요.
    };

    // 새로 선택한 대출 정보
    const newLoan = {
        amount: parseFloat(selectedLoanData.balance),
        interestRate: parseFloat(selectedLoanProduct.selectedCreditGrade) / 100,
        period: period,
        method: selectedLoanData.repayment // 선택한 대출 상품의 상환방식
    };

    const comparison = compareLoans(oldLoan, newLoan, parseFloat(selectedLoanData.overdue) / 100);

    document.getElementById("monthlySavings").innerText = "월 상환 절약액: " + Math.round(comparison.monthlySavings).toLocaleString() + "원";
    document.getElementById("totalSavings").innerText = "총 상환 절약액: " + Math.round(comparison.totalSavings).toLocaleString() + "원";


    openModal();


}

var selectedProductDiv = null; // 선택된 대출 상품을 추적할 전역 변수
function findMatchingLoans() {
    var interest = selectedLoanData.interest;
    var balance = selectedLoanData.balance;
    var creditScore = creditData.creditList[0].creditScore;
    console.log(interest);
    console.log(balance);
    console.log(creditScore);

    fetch('/findLoans', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            interest: interest,
            balance: balance,
            creditScore: creditScore
        }),
    })
        .then(response => response.json())  // parse the response into JSON
        .then(data => {
            console.log('Success:', data);
            loanProducts = data.loanProducts;

            var container = document.getElementById('section3');
            container.style.paddingBottom = '50px'; // 이 줄을 추가
            container.innerHTML = '';  // Clear previous data

            if (loanProducts && loanProducts.length > 0) {
                var header = document.createElement('b');
                header.textContent = "3. 최적의 대출 상품";
                container.appendChild(header);

                var hr = document.createElement('hr');
                container.appendChild(hr);
                loanProducts.forEach((product, index) => {
                    var productDiv = document.createElement('div');
                    productDiv.className = 'loanProduct';

                    var loanHeader = document.createElement('div');
                    loanHeader.className = 'loanHeader';
                    loanHeader.innerHTML = `
        <b>${product.loanPdctNm}</b>
        <p>이자율: ${product.selectedCreditGrade}%</p>
        <p>금융사: ${product.fnstDvVal}</p>
        <span class="toggleButton"><i class="fas fa-angle-down"></i></span>
    `;
                    productDiv.appendChild(loanHeader);

                    var loanBody = document.createElement('div');
                    loanBody.className = 'loanBody';
                    loanBody.style.display = 'none';
                    loanBody.innerHTML = `
        <p>대출한도: ${Number(product.loanLimAmt).toLocaleString()}원</p>
        <p>중도상환수수료: ${product.earlyRepayFee}%</p>
    `;
                    productDiv.appendChild(loanBody);

                    var selectLink = document.createElement('a');
                    selectLink.href = "javascript:void(0);";
                    selectLink.textContent = "선택하기";
                    selectLink.setAttribute('data-index', index);
                    selectLink.style.color = "#60ca91";
                    selectLink.onclick = function() {
                        selectLoanProducts(this.getAttribute('data-index'));
                    };
                    productDiv.appendChild(selectLink);

                    selectLink.onclick = function() {
                        selectLoanProducts(this.getAttribute('data-index'));

                        // 이전에 선택된 상품의 테두리 스타일을 원래대로 되돌립니다.
                        if (selectedProductDiv) {
                            selectedProductDiv.style.border = "";
                        }

                        // 현재 클릭된 상품의 테두리 스타일을 변경합니다.
                        productDiv.style.border = "2px solid #60ca91";
                        selectedProductDiv = productDiv;
                    };
                    loanHeader.addEventListener('click', function() {
                        if (loanBody.style.display === "none") {
                            loanBody.style.display = "block";
                            // ▲ 아이콘으로 변경
                            loanHeader.querySelector('.toggleButton').innerHTML = '<i class="fas fa-angle-up"></i>';
                        } else {
                            loanBody.style.display = "none";
                            // ▼ 아이콘으로 변경
                            loanHeader.querySelector('.toggleButton').innerHTML = '<i class="fas fa-angle-down"></i>';
                        }
                    });


                    container.appendChild(productDiv);
                });


                var switchButton = document.createElement('button');
                switchButton.textContent = "갈아타기";
                switchButton.style.position = 'absolute';
                switchButton.style.right = '10px';
                switchButton.style.bottom = '10px';
                switchButton.addEventListener('click', function() {
                    if (selectedLoanProduct) {
                        // 선택된 대출 상품이 있으면 서버로 해당 데이터를 전송
                        fetch('/loanSwitch/loanSwitchStep', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({
                                selectedLoanProduct: selectedLoanProduct,
                                creditData: creditData,
                                selectedLoanData: selectedLoanData
                            }),
                        })
                            .then(response => {
                                if (response.status === 200) {
                                    window.location.href = "/loanSwitch/loanSwitchStep2"; // 페이지 이동
                                } else {
                                    console.error('Error switching loan product:', response.status);
                                    alert("대출 상품을 갈아타는 데 실패했습니다.");
                                }
                            })
                            .catch((error) => {
                                console.error('Error switching loan product:', error);
                                alert("대출 상품을 갈아타는 데 실패했습니다.");
                            });
                    } else {
                        alert("먼저 대출 상품을 선택해주세요.");
                    }
                });
                container.appendChild(switchButton);
            } else {
                alert("매칭되는 대출 상품이 없습니다.");
            }
        })
        .catch((error) => {
            console.error('Error fetching loan products:', error);
            alert("대출 상품을 불러오는 데 실패했습니다.");
        });
}



// 월 상환액 계산
function calculateMonthlyPayment(principal, rate, term) {
    let monthlyRate = rate / 1200;
    return principal * monthlyRate / (1 - Math.pow(1 + monthlyRate, -term));
}




function openModal() {
    $('#savingsModal').modal('show');

    // Bootstrap 모달이 기본적으로 닫기 버튼 및 백그라운드 클릭을 처리하기 때문에
    // 추가적인 이벤트 핸들러가 필요 없습니다.
}

function closeModal() {
    $('#savingsModal').modal('hide');
}
function calculateRepayment(loan) {
    let monthlyInterestRate = loan.interestRate / 12;
    let monthlyRepayment, totalRepayment;
    let monthlyPrincipal = loan.amount / loan.period;
    let interestForFirstMonth = loan.amount * monthlyInterestRate;
    switch(loan.method) {
        case '원리금균등방식' || '원리금균등상환':
            monthlyRepayment = loan.amount * monthlyInterestRate / (1 - Math.pow(1 + monthlyInterestRate, -loan.period));
            totalRepayment = monthlyRepayment * loan.period;
            break;
        case '원금균등방식' || '원금균등상환':

            monthlyRepayment = monthlyPrincipal + interestForFirstMonth;
            totalRepayment = 0;
            for(let i = 0; i < loan.period; i++) {
                totalRepayment += monthlyPrincipal + (loan.amount - monthlyPrincipal * i) * monthlyInterestRate;
            }
            break;

    }

    return {
        monthlyRepayment,
        totalRepayment
    };
}

function compareLoans(oldLoan, newLoan, earlyRepaymentFee) {
    let oldRepayment = calculateRepayment(oldLoan);
    let newRepayment = calculateRepayment(newLoan);

    let monthlySavings = oldRepayment.monthlyRepayment - newRepayment.monthlyRepayment;
    let totalSavings = (oldRepayment.totalRepayment - newRepayment.totalRepayment) - oldLoan.amount * earlyRepaymentFee;

    return {
        monthlySavings,
        totalSavings
    };
}


document.getElementById('confirmButton').addEventListener('click', closeModal);
document.querySelector('.close').addEventListener('click', closeModal);

function closeModal() {
    document.getElementById('savingsModal').style.display = 'none';
}