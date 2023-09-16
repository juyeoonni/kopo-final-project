const currentMonthYear = document.getElementById('currentMonthYear');
const daysContainer = document.querySelector('.days');
const prevMonthBtn = document.getElementById('prevMonth');
const nextMonthBtn = document.getElementById('nextMonth');
const weekdays = ["일", "월", "화", "수", "목", "금", "토"];
let currentDate = new Date();

function addWeekdays() {
    weekdays.forEach((day) => {
        const dayElement = document.createElement("div");
        dayElement.classList.add("weekday");
        dayElement.innerText = day;
        daysContainer.append(dayElement);
    });
}

function loadCalendar(month, year) {
    // 요일명 이외의 모든 요소를 제거합니다.
    const existingDays = daysContainer.querySelectorAll(':not(.weekday)');
    existingDays.forEach(day => day.remove());

    currentMonthYear.textContent = `${month + 1}월 ${year}년`;

    let firstDay = new Date(year, month).getDay();
    let daysInMonth = 32 - new Date(year, month, 32).getDate();
    let today = new Date().getDate();

    for (let i = 1; i <= firstDay + daysInMonth; i++) {
        const dayElem = document.createElement('div');
        if (i > firstDay) {
            dayElem.textContent = i - firstDay;

            if ((i - firstDay) === today && currentDate.getMonth() === new Date().getMonth() && currentDate.getFullYear() === new Date().getFullYear()) {
                dayElem.classList.add('today');
            }
        }
        daysContainer.appendChild(dayElem);
    }
}

prevMonthBtn.addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() - 1);
    loadCalendar(currentDate.getMonth(), currentDate.getFullYear());
});

nextMonthBtn.addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() + 1);
    loadCalendar(currentDate.getMonth(), currentDate.getFullYear());
});

// 요일명 추가
addWeekdays();

// 초기 캘린더 로드
loadCalendar(currentDate.getMonth(), currentDate.getFullYear());
