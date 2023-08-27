<!-- 대출 정보를 불러오는 함수 -->
window.onload = function() {
    document.getElementById('section1').style.display = 'block';
    loadLoanData(); // 페이지 로딩 후 대출 데이터 로딩 함수 호출
}

function loadLoanData() {
    const query = new URLSearchParams({
        banks: selectedBanks.join(',') // 선택한 은행 정보를 콤마로 구분된 문자열로 변환
    }).toString();
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
            data.forEach(loan => {
                console.log(loan);
                console.log(loan.interestRate);
                const loanCard = document.createElement('div');
                loanCard.className = "loan-card";
                loanCard.onclick = () => selectLoan(loanCard, loan.ProductName || 'Product ID: ', + loan.interestRate, loan.finance, loan.loanAmount, loan.loanBalance, loan.loanEndDate, loan.overDue);


                loanCard.style.padding = '20px';
                loanCard.style.margin = '10px';
                loanCard.style.boxShadow = '0 4px 8px 0 rgba(0,0,0,0.2)';

                const loanTitle = document.createElement('div');
                loanTitle.className = "loan-card-title";
                loanTitle.textContent = loan.ProductName || 'Product ID: ' + loan.ProductID;
                loanCard.appendChild(loanTitle);

                const loanBank = document.createElement('p');
                loanBank.textContent = `은행: ` + loan.finance;
                loanCard.appendChild(loanBank);

                const loanInterest = document.createElement('p');
                loanInterest.textContent = `금리: ` + loan.interestRate + '%';
                loanCard.appendChild(loanInterest);

                const loanAmount = document.createElement('p');
                loanAmount.textContent = '대출 금액:' +  loan.loanAmount + '원';
                loanCard.appendChild(loanAmount);

                const loanBalance = document.createElement('p');
                loanBalance.textContent = '대출 잔액:' +  loan.loanBalance + '원';
                loanCard.appendChild(loanBalance);

                const loanEndDate = document.createElement('p');
                loanEndDate.textContent = '대출만기일:' +  loan.loanEndDate;
                loanCard.appendChild(loanEndDate);

                const overdue = document.createElement('p');
                overdue.textContent = '중도상환수수료:' +  loan.overDue;
                loanCard.appendChild(overdue);

                loanList.appendChild(loanCard);
            });
        })
        .catch(error => {
            // 에러시 로딩 인케이터 숨김
            document.getElementById('loadingIndicator').style.display = 'none';
            console.error('Error fetching loan data:', error);
        });
}
let selectedLoanData = {};

function selectLoan(loanElement, title, interest, bank, amount, balance, endDate, overdue) {
    console.log(selectedLoanData); // 선택한 대출 정보 출력

    // 모든 대출 카드의 선택 효과를 제거
    const loanCards = document.querySelectorAll('.loan-card');
    loanCards.forEach(card => card.classList.remove('loan-card-selected'));

    // 클릭한 대출 카드에 선택 효과를 부여
    loanElement.classList.add('loan-card-selected');

    // 선택한 대출 카드의 정보 저장
    selectedLoanData = {
        title: title,
        interest: interest,
        bank: bank,
        amount: amount,
        balance: balance,
        endDate: endDate,
        overdue: overdue
    };
}


function showNextSection(sectionId) {
    console.log("showNextSection() 호출됨");
    console.log(selectedLoanData);
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
        const bestLoanDiv = document.getElementById('bestLoan');
        bestLoanDiv.textContent = '대출 이름 : ' +  selectedLoanData.title;
        bestLoanDiv.textContent += ', 대출 금리 : ' +  selectedLoanData.interest;
        bestLoanDiv.textContent += ', 대출 은행 : ' +  selectedLoanData.bank;
        bestLoanDiv.textContent += ', 대출 금액 : ' +  selectedLoanData.amount;
        bestLoanDiv.textContent += ', 대출 잔액 : ' +  selectedLoanData.balance;
        bestLoanDiv.textContent += ', 대출 만기일 : ' +  selectedLoanData.endDate;
        bestLoanDiv.textContent += ', 중도상환수수료 : ' +  selectedLoanData.overdue;


    }
}
// 새로운 함수로 은행 선택 UI를 보여줌
// 선택된 은행을 저장하는 배열
let selectedBanks = [];
// 팝업을 열고 닫는 함수
function openPopup() {
    document.getElementById('bankPopup').style.display = 'block';
}

function closePopup() {
    document.getElementById('bankPopup').style.display = 'none';
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


// 대출 리스트 스크롤 함수
function scrollLoanList(direction) {
    const loanSliderContainer = document.getElementById('loanSliderContainer');
    const loanList = document.getElementById('loanList');

    // 현재 스크롤 위치와 컨테이너의 너비를 이용하여 새로운 스크롤 위치 계산
    const currentScroll = loanSliderContainer.scrollLeft;
    const containerWidth = loanSliderContainer.clientWidth;

    // 왼쪽 또는 오른쪽으로 스크롤
    const newScroll = currentScroll + (containerWidth * 0.8 * direction);  // 0.8은 스크롤 비율입니다. 원하는대로 조정 가능
    loanSliderContainer.scrollLeft = newScroll;
}