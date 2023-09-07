// Highcharts 그래프 데이터 배열 설정
var chartData = [
  {
    name: '유동자산', // "유동자산"을 "4기"로 변경
    data: [1000, 40504, 50504],
    color: '#999999'
  },
  {
    name: '비유동자산',
    data: [28504, 40504, 50504],
    color: '#dddddd'
  },
  {
    name: '유동부채',
    data: [28504, 40504, 50504],
    color: '#444444'
  },
  {
    name: '비유동부채',
    data: [28504, 40504, 50504],
    color: '#eeeeee'
  },
];

// Highcharts 그래프 그리기
Highcharts.chart('container', {
  chart: {
    type: 'column',
  },
  title: {
    text: '재무제표 통계',
  },
  xAxis: {
    categories: ['4기', '3기', '2기'], // "4기"와 "2기"의 위치 변경
  },
  yAxis: {
    title: {
      text: '금액',
    },
  },
  series: chartData,
});
