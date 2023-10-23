let currentWith = window.innerWidth;

const lineCtx1 = document.getElementById('memberChart1');
lineCtx1.width = '1000px';
lineCtx1.height = '600px';

$(document).ready(function() {
    $.get("/api/recent-registrations", function(data) {
        data.sort((a, b) => new Date(a.date) - new Date(b.date));

        const formattedLabels = data.map(item => {
            let datePart = item.date.split('T')[0]; // 날짜 부분만 추출 ('2023-10-08' 형태)
            let [year, month, day] = datePart.split('-'); // 연, 월, 일로 분할
            return month + "/" + day;
        });


        const combinedData = formattedLabels.map((label, index) => {
            return {
                date: label,
                count: data[index].count
            };
        });
        console.log("Combined Data:", combinedData);

        let groupedData = {};
        combinedData.forEach(item => {
            if (groupedData[item.date]) {
                groupedData[item.date] += item.count;
            } else {
                groupedData[item.date] = item.count;
            }
        });

        console.log("Grouped Data:", groupedData);
        const finalLabels = Object.keys(groupedData);
        const finalCounts = Object.values(groupedData);

        new Chart(lineCtx1, {
            type: 'line',
            data: {
                labels: finalLabels,
                datasets: [
                    {
                        label: '가입자',
                        data: finalCounts,
                        borderColor: '#fb5f63',
                        backgroundColor: 'rgb(254,230,230,0.5)',
                        fill: true,
                        borderWidth: 2.5,
                        radius: 4,
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                layout: {
                    padding: 20,
                },
                scales: {
                    y: {
                        ticks: {
                            callback: function(value) {
                                if (value % 1 === 0) {
                                    return value;
                                }
                            },
                            beginAtZero: true
                        }
                    }
                },
                plugins: {
                    legend: {
                        position: 'top',
                        align: 'end',
                        labels: {
                            usePointStyle: true,
                            pointStyle: 'circle',
                            itemStyle: {
                                width: 10,
                                height: 10,
                                color: 'red',
                            },
                        },
                    },
                    title: {
                        display: true,
                        align: 'start',
                        text: '가입자 현황',
                        font: { weight: 'bold', size: 17 },
                    },
                },
            },
        });
    });
});