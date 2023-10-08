<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- 하단 content 부분에 원하시는 키워드 검색어 입력해주시면 됩니다 -->
    <meta
            name="keyword"
            content="보험, 견적확인, 자문"
            style="user-select: auto"
    />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>원하시는 제목 입력해주세요</title>
    <!-- css import 부분-->
    <link rel="stylesheet" href="/css/reset.css" />
    <link rel="stylesheet" href="/css/admin.css" />
    <!-- chart import 부분-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.3.0/chart.min.js"></script>
</head>
<body>
<!-- 이미지는 피그마에 있는 이미지 부분을 잘라 활용했습니다. 변경하고 싶으시면 다른 이미지를 추가 후 src 값만 변경해주면 됩니다 -->
<div class="body-row">
    <!-- 사이드 바 부분 -->
    <div class="admin-sidebar">
        <div class="sidebar-routers">
            <div class="icon-box admin-logo-wrapper">
                <img src="/img/hanaLogo.png" />
                하나360
            </div>
            <div class="current-router admin-router icon-box">
                <img src="/img/homeIcon.jpg" />
                메인 홈
            </div>
            <div class="admin-router icon-box">
                <img src="/img/folderIcon.jpg" />회원 관리
            </div>
            <div class="admin-router icon-box">
                <img src="/img/questionMarkIcon.jpg" />하나360로 이동
            </div>
        </div>

        <div class="sidebar-bottom-wrapper">
            <div admin-router icon-box>
                <img src="/img/settingIcon.jpg" />Settings
            </div>
            <div admin-router icon-box>
                <img src="/img/downloadIcon.jpg" />Download
            </div>
        </div>
    </div>
    <!-- 사이드바를 제외한 부분을 감싸는 div -->
    <div class="admin-body-wrapper">
        <!-- 상단바 부분 -->
        <div class="admin-navbar">
            <div class="admin-search-box">
                Search...
                <img src="/img/searchIcon.png" />
            </div>
            <div class="admin-nav-right">
                <div class="setting-icon">
                    <img src="/img/settingIcon.jpg" />
                </div>
                <div class="my-icon"><img src="/img/hanaLogo.png" />▼</div>
            </div>
        </div>
        <!-- admin-body-wrapper의 상단바를 제외한 부분 -->
        <div class="admin-body-inner">
            <!-- 상단 부분 -->
            <div class="admin-title">하나360</div>
            <div class="goto-admin admin-box">
                <div class="goto-admin-text">
                    <div>관리자 페이지</div>
                    <div>안녕하세요 관리자님!</div>
                    <div>오늘 하루도 화이팅 하세요.</div>
                </div>
                <div class="goto-right-wrapper">
                    <img src="../images/tempImg.jpg" width="80%" />
                    <!-- 닫기 버튼 -->
                    <div class="sect01">
                        <div class="line-box">
                            <span class="line-01"></span>
                            <span class="line-02"></span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 중간의 3개 있는 부분 -->
            <div class="admin-countbox-wrapper">
                <div class="admin-countbox admin-box">
                    <div>회원 접속자 수</div>
                    <div>8</div>
                    <div>↑ 2022-10-15</div>
                </div>
                <div class="admin-countbox admin-box">
                    <div>총 회원자 수</div>
                    <div>23</div>
                    <div>TOTAL</div>
                </div>
                <div class="admin-countbox admin-box">
                    <div>신규 가입자 수</div>
                    <div>6</div>
                    <div>NEW</div>
                </div>
            </div>
            <!-- 하단 부분 -->
            <div class="admin-bottom-wrapper">
                <div class="manage-box-wrapper">
                    <div class="manage-box admin-box">
                        <div>회원 관리</div>
                        <div>하나원큐레이터의 회원 분석과 회원 관리</div>
                        <button class="manage-box-button">조회하기</button>
                    </div>
                    <div class="manage-box admin-box">
                        <div>상품 관리</div>
                        <div>하나원큐레이터의 상품 관리</div>
                        <button class="manage-box-button">조회하기</button>
                    </div>
                </div>
                <div class="member-chart-wrapper admin-box">
                    <canvas id="memberChart1"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- chart 관련 import 부분입니다-->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<script>
    let currentWith = window.innerWidth;

    const lineCtx1 = document.getElementById('memberChart1');
    lineCtx1.width = '1000px';
    lineCtx1.height = '600px';

    new Chart(lineCtx1, {
        type: 'line',
        data: {
            labels: ['5-8', '5-9', '5-10', '5-11', '5-12', '5-13', '5-14'],
            datasets: [
                {
                    label: '페이지뷰',
                    data: [25, 25, 80, 99, 72, 110, 20],
                    borderColor: '#feafb2',
                    backgroundColor: 'rgb(255,245,245,0.4)',
                    fill: true,
                    borderWidth: 2.5,
                    radius: 4,
                },
                {
                    label: '방문자',
                    data: [20, 5, 23, 26, 22, 28, 18],
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
                            color: 'red', // 포인트 스타일 아이템의 색상 설정
                        },
                    },
                },
                title: {
                    display: true,
                    align: 'start',
                    text: '방문자 현황',
                    font: { weight: 'bold', size: 17 },
                },
            },
        },
    });
</script>
</body>
</html>
