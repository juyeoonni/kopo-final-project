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
    var calendarEl = document.getElementById('calendar');

    var today = new Date();
    today.setHours(0, 0, 0, 0); // 시간, 분, 초, 밀리초를 0으로 설정

    var events = [];

    // 모든 달에 대해 이벤트 추가
    for (var month = 0; month < 12; month++) {
        repaymentDates.forEach(function(day) {
            var eventDate = new Date(today.getFullYear(), month, day);
            var color;

            // 현재 날짜보다 이전일 경우 파란색, 그렇지 않으면 빨간색
            if (eventDate < today) {
                color = 'blue';
            } else {
                color = 'red';
            }

            events.push({
                title: '상환일',
                start: eventDate,
                color: color,
                allDay: true
            });
        });
    }
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        events: events,
        headerToolbar: {
            start: 'prev,next today',
            center: 'title',
            end: 'dayGridMonth,dayGridWeek,dayGridDay'
        },
        titleFormat: {
            year: 'numeric',
            month: 'long'
        },
        droppable: true,
        editable: true,
        nowIndicator: true,
        locale: 'ko'
    });

    calendar.render();
});
$('#ShowCalendar').on('shown.bs.modal', function() {
    calendar.updateSize();
});
