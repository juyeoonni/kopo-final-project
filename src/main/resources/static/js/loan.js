<!-- 대출 정보를 불러오는 함수 -->
window.onload = function() {
    document.getElementById('section1').style.display = 'block';

}

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
            data.forEach(loan => {
                console.log(loan);
                console.log(loan.loanRecordID);
                console.log(loan.interestRate);
                const loanCard = document.createElement('div');
                loanCard.className = "loan-card";
                loanCard.onclick = () => selectLoan(loanCard, loan.loanRecordID,loan.loanProductID || '대출명 : ', + loan.interestRate, loan.finance, loan.loanAmount, loan.loanBalance, loan.loanEndDate, loan.overdue);


                loanCard.style.padding = '20px';
                loanCard.style.margin = '10px';
                loanCard.style.boxShadow = '0 4px 8px 0 rgba(0,0,0,0.2)';

                const loanTitle = document.createElement('div');
                loanTitle.className = "loan-card-title";
                loanTitle.textContent = loan.loanProductID;
                loanCard.appendChild(loanTitle);

                const loanRecordId = document.createElement('p');
                loanRecordId.textContent = `대출내역 번호 ` + loan.loanRecordID;
                loanCard.appendChild(loanRecordId);

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
                overdue.textContent = '중도상환수수료:' +  loan.overdue;
                loanCard.appendChild(overdue);

                loanList.appendChild(loanCard);
            });
        })
        .catch(error => {
            // 에러시 로딩 인케이터 숨김
            document.getElementById('loadingIndicator').style.display = 'none';
            console.error('Error fetching loan data:', error);
            alert("연동 오류! 다시시도 하세요!");
        });
}
let selectedLoanData = {};

function selectLoan(loanElement, loanRecordID, title, interest, bank, amount, balance, endDate, overdue) {
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
        overdue: overdue
    };
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




// KCB 데이터 팝업창

document.addEventListener("DOMContentLoaded", function() {
    const showPopupBtn = document.getElementById("showPopupBtn");
    const closePopupBtn = document.getElementById("closePopupBtn");
    const popup = document.getElementById("popup");

    showPopupBtn.addEventListener("click", function() {
        popup.classList.remove("hidden");
    });

    closePopupBtn.addEventListener("click", function() {
        popup.classList.add("hidden");
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


                // 팝업 닫기
                const popup = document.getElementById("popup");
                popup.classList.add("hidden");

                showNextSection('section3');

            })
            .catch(error => {
                // 에러 발생 시 처리 로직
                console.log(error);

                alert("로그인 실패! 다시 시도하세요!");
            });
    }
});







let selectedLoanProduct = null;
let loanProducts = []; // 전역 변수로 선언
function selectLoanProducts(index) {
    // 선택한 대출 상품 정보를 변수에 저장
    selectedLoanProduct = loanProducts[index];
    alert("대출 상품이 선택되었습니다.");
}
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
            container.innerHTML = '';  // Clear previous data

            if (loanProducts && loanProducts.length > 0) {
                var header = document.createElement('h3');
                header.textContent = "3. 최적의 대출 상품";
                container.appendChild(header);

                var hr = document.createElement('hr');
                container.appendChild(hr);
                loanProducts.forEach((product, index) => {
                    var productDiv = document.createElement('div');
                    productDiv.className = 'loanProduct';

                    var selectLink = document.createElement('a');
                    selectLink.href = "javascript:void(0);";
                    selectLink.textContent = "선택하기";
                    selectLink.setAttribute('data-index', index); // 인덱스 저장
                    selectLink.onclick = function() {
                        selectLoanProducts(this.getAttribute('data-index')); // 저장된 인덱스 사용
                    };

                    productDiv.innerHTML = `
                    <h3>${product.loanPdctNm}</h3>
                    <p>이자율: ${product.selectedCreditGrade}</p>
                    <p>금융코드: ${product.fnstDvVal}</p>
                    <p>대출한도: ${product.loanLimAmt}</p>
                    <p>중도상환수수료: ${product.earlyRepayFee}</p>
                    <p>번호 : ${product.id}</p>
                `;
                    productDiv.appendChild(selectLink);
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