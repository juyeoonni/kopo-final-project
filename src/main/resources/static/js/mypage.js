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




document.addEventListener("DOMContentLoaded", function() { // 페이지가 로드된 후에 실행
    var acc = document.getElementsByClassName("accordion-button");
    for (var i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function() {
            this.classList.toggle("active"); // active 클래스를 토글
            var content = this.nextElementSibling; // 아코디언 내용을 찾습니다.
            if (content.style.display === "block") {
                content.style.display = "none"; // 내용을 숨깁니다.
            } else {
                content.style.display = "block"; // 내용을 표시합니다.
            }
        });
    }
});
document.addEventListener("DOMContentLoaded", function() {
    const calendarBtn = document.querySelector(".cal_btn");
    const calendarModal = document.getElementById("calendarModal");
    const closeModal = calendarModal.querySelector(".close");

    // 버튼 클릭 이벤트
    calendarBtn.addEventListener("click", function(e) {
        e.preventDefault(); // 기본 동작(페이지 이동)을 방지합니다.
        calendarModal.style.display = "block";
    });

    // 닫기 버튼 이벤트
    closeModal.addEventListener("click", function() {
        calendarModal.style.display = "none";
    });

    // 여기에 달력 코드를 추가합니다.
    const today = new Date();
    const calendar = document.getElementById("calendar");
    calendar.innerHTML = today.toDateString(); // 현재 날짜를 문자열로 변환하여 표시합니다.
});
