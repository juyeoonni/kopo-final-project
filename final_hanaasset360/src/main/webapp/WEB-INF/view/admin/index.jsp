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
    <meta
            name="keyword"
            content=""
            style="user-select: auto"
    />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>원하시는 제목 입력해주세요</title>
    <!-- css import 부분-->
    <link rel="stylesheet" href="/css/reset.css" />
    <link rel="stylesheet" href="/css/admin/admin.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- chart import 부분-->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        function redirectToAdminIndex() {
            window.location.href = '/admin/index'; // 원하는 URL로 리다이렉션
        }
    </script>
</head>
<body>
<!-- 이미지는 피그마에 있는 이미지 부분을 잘라 활용했습니다. 변경하고 싶으시면 다른 이미지를 추가 후 src 값만 변경해주면 됩니다 -->
<div class="body-row">
    <!-- 사이드 바 부분 -->
    <div class="admin-sidebar">
        <div class="sidebar-routers">
            <div class="icon-box admin-logo-wrapper" onclick="redirectToAdminIndex()">
                <img src="/img/hanaLogo.png" />
                하나360
            </div>
            <a href="/admin/index"> <!-- 원하는 URL로 변경하세요 -->
                <div class="current-router admin-router icon-box">
                    <img width="20px" src="/img/homeIcon.png" />
                    메인 홈
                </div>
            </a>
            <a href="/admin/member"> <!-- 원하는 URL로 변경하세요 -->
                <div class="admin-router icon-box">
                    <img width="20px" src="/img/folderIcon.png" />회원 관리
                </div>
            </a>
            <a href="/"> <!-- 원하는 URL로 변경하세요 -->
                <div class="admin-router icon-box">
                    <img width="20px" src="/img/questionMarkIcon.png" />하나360 이동
                </div>
            </a>
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
                    <div>최근 접속자 수</div>
                    <div>${recentLogins}</div> <!-- 최근 접속자 수를 출력합니다. -->
                    <div>↑ ${today}</div> <!-- 오늘 날짜를 출력합니다. -->
                </div>
                <div class="admin-countbox admin-box">
                    <div>최근 가입자 수</div>
                    <div>${recentRegistrations}</div> <!-- 최근 가입자 수를 출력합니다. -->
                    <div>NEW</div>
                </div>
                <div class="admin-countbox admin-box">
                    <div>총 회원자 수</div>
                    <div>${totalMembers}</div>
                    <div>TOTAL</div>
                </div>

            </div>
            <!-- 하단 부분 -->
            <div class="admin-bottom-wrapper">
                <div class="manage-box-wrapper">
                    <div class="manage-box admin-box">
                        <div>회원 관리</div>
                        <div>하나360 회원 분석과 회원 관리</div>
                        <button class="manage-box-button">조회하기</button>
                        <img src="/img/members.png" alt="Members" class="member-icon">
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
</body>
</html>
