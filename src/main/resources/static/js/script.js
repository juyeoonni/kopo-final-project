const headerNav = document.querySelector('.left');
const blank = document.querySelector('.blank');
headerNav.addEventListener('mouseover', () => {
  blank.classList.add('active');
});
headerNav.addEventListener('mouseleave', () => {
  blank.classList.remove('active');
});
