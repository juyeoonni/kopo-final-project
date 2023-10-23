// Highcharts 그래프 데이터 배열 설정


var chartData = [
  {
    name: '사용자', // "유동자산"을 "4기"로 변경
    data: [ repaymentScore, loanScore, creditRisk, creditPeriodScore],
    color: '#ea1828'
  },
  {
    name: '평균',
    data: [ 80, 80, 80, 80],
    color: '#0f26e8'
  }
];

// Highcharts 그래프 그리기
Highcharts.chart('container', {
  chart: {
    type: 'column',
  },
  title: {
    text: '신용점수 통계',
  },
  xAxis: {
    categories: [ '상환', '부채', '신용위험도', '신용거래기간'], // "4기"와 "2기"의 위치 변경
  },
  yAxis: {
    title: {
      text: '금액',
    },
  },
  series: chartData,
});
