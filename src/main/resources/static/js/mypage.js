// 현재 날짜 가져오기
const today = new Date();
const dayNames = ["일", "월", "화", "수", "목", "금", "토"];

// 현재 요일 구하기 (0: 일요일, 1: 월요일, ... 6: 토요일)
const dayOfWeek = today.getDay();
const startDate = new Date(today);
startDate.setDate(today.getDate() - dayOfWeek);

const dateListElement = document.getElementById('dateList');

for (let i = 0; i < 7; i++) {
    const listItem = document.createElement('li');
    if (startDate.getDate() === today.getDate()) {
        listItem.classList.add('active');
    }

    const dayElement = document.createElement('span');
    dayElement.textContent = dayNames[startDate.getDay()];

    const dateElement = document.createElement('span');
    dateElement.textContent = startDate.getDate();

    listItem.appendChild(dayElement);
    listItem.appendChild(dateElement);

    dateListElement.appendChild(listItem);

    // 다음 날짜로 업데이트
    startDate.setDate(startDate.getDate() + 1);
}

window.onload = function() {
    setCurrentDateTime();
};

function setCurrentDateTime() {
    console.log("Function executed!");  // 이 부분 추가

    const now = new Date();
    const year = now.getFullYear();
    const month = (now.getMonth() + 1).toString().padStart(2, '0');
    const day = now.getDate().toString().padStart(2, '0');
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');

    const formattedDateTime = `${year}-${month}-${day} ${hours}:${minutes} 기준`;

    console.log(formattedDateTime);
    document.getElementById('currentDateTime').textContent = formattedDateTime;
}

document.addEventListener('DOMContentLoaded', function() {
    var btn = document.querySelector('.detail_btn a');
    var modal = document.getElementById('modal');
    var closeBtn = document.querySelector('.close');

    if(!btn || !modal || !closeBtn) {
        console.error("Some elements are missing!"); // 요소 중 누락된 것이 있는지 확인용
        return;
    }

    btn.onclick = function(event) {
        event.preventDefault();
        modal.style.display = "block";
    }

    closeBtn.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});






