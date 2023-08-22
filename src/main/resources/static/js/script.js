const headerNav = document.querySelector('.left');

const blank = document.querySelector('.blank');
headerNav.addEventListener('mouseover', () => {
  blank.classList.add('active');
});
headerNav.addEventListener('mouseleave', () => {
  blank.classList.remove('active');
});

const banners = document.querySelector('.banners');
const iEls = document.querySelectorAll('i');

let i = 0;
let intervalId = setInterval(movingBanners, 2000); // 초기 interval 설정

function movingBanners() {
  i = (i + 1) % iEls.length;
  const distanceToMove = window.innerWidth; // 100vw
  banners.style.transform = `translateX(-${distanceToMove * i}px)`;
  updateActiveClass(i);
}

// 배너 아이템 클릭 이벤트 처리
iEls.forEach((item, index) => {
  item.addEventListener('click', () => {
    i = index;
    const distanceToMove = window.innerWidth; // 100vw
    banners.style.transform = `translateX(-${distanceToMove * i}px)`;
    clearInterval(intervalId); // 클릭 시 interval 중지
    updateActiveClass(i);
    intervalId = setInterval(movingBanners, 2000); // interval 재시작
  });
});

// 배너 아이템의 active 클래스 업데이트
function updateActiveClass(activeIndex) {
  iEls.forEach((item, index) => {
    if (index === activeIndex) {
      item.classList.add('active');
    } else {
      item.classList.remove('active');
    }
  });
}
