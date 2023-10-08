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
    <link rel="stylesheet" href="/css/member.css" />
</head>
<body>
<div class="body-row">
    <!-- 사이드 바 부분 -->
    <div class="admin-sidebar">
        <div class="sidebar-routers">
            <div class="icon-box admin-logo-wrapper">
                <img src="../images/hanaLogo.png" />
                하나원큐레이터
            </div>
            <div class="current-router admin-router icon-box">
                <img src="../images/homeIcon.jpg" />
                메인 홈
            </div>
            <div class="admin-router icon-box">
                <img src="../images/folderIcon.jpg" />회원 관리
            </div>
            <div class="admin-router icon-box">
                <img src="../images/questionMarkIcon.jpg" />하나원큐레이터로 이동
            </div>
        </div>
        <!-- 사이드바 하단 부분 -->
        <div class="sidebar-bottom-wrapper">
            <div admin-router icon-box>
                <img src="../images/settingIcon.jpg" />Settings
            </div>
            <div admin-router icon-box>
                <img src="../images/downloadIcon.jpg" />Download
            </div>
        </div>
    </div>
    <!-- 사이드바를 제외한 부분을 감싸는 div -->
    <div class="member-body-wrapper">
        <!-- 상단바 부분 -->
        <div class="admin-navbar">
            <div class="admin-search-box">
                Search...
                <img src="../images/searchIcon.png" />
            </div>
            <div class="admin-nav-right">
                <div class="setting-icon">
                    <img src="../images/settingIcon.jpg" />
                </div>
                <div class="my-icon"><img src="../images/hanaLogo.png" />▼</div>
            </div>
        </div>
        <!-- 상단바를 제외한 부분입니다 -->
        <div class="member-body-inner">
            <div class="admin-title">회원 목록</div>
            <!-- 흰색 부분으로 되어있는 박스 부분입니다 -->
            <div class="admin-box member-box">
                <div class="member-button-wrapper">
                    <div class="button-style1">
                        전체 선택 <span class="gray-span">▼</span>
                    </div>
                    <div class="button-right">
                        <div class="button-style1">
                            아이디<span class="gray-span">▼</span>
                        </div>
                        <div class="button-style2">
                            <img src="../images/searchIcon.png" />
                        </div>
                    </div>
                </div>
                <!-- 테이블의 데이터를 나타내는 부분입니다 -->
                <!-- 임시로 값을 넣어뒀습니다 -->
                <div class="member-table-wrapper">
                    <div>
                        <div class="member-table-top member-single-row">
                            <div>언어</div>
                            <div>
                                ID
                                <img src="../images/upDownArrow.png" />
                            </div>
                            <div>이름<img src="../images/upDownArrow.png" /></div>
                            <div>이메일<img src="../images/upDownArrow.png" /></div>
                            <div>상태</div>
                            <div>가입일<img src="../images/upDownArrow.png" /></div>
                            <div>최종 로그인<img src="../images/upDownArrow.png" /></div>
                        </div>
                        <div class="member-single-row">
                            <div><img src="../images/korea.png" /></div>
                            <div>test1111</div>
                            <div>name</div>
                            <div>test1111@gmail.com</div>
                            <div>정상</div>
                            <div>2023.10.08</div>
                            <div>2023.10.08</div>
                            <button>sms전송</button>
                        </div>
                        <div class="member-single-row">
                            <div><img src="../images/korea.png" /></div>
                            <div>test1111</div>
                            <div>name</div>
                            <div>test1111@gmail.com</div>
                            <div>정상</div>
                            <div>2023.10.08</div>
                            <div>2023.10.08</div>
                            <button>sms전송</button>
                        </div>
                        <div class="member-single-row">
                            <div><img src="../images/korea.png" /></div>
                            <div>test1111</div>
                            <div>name</div>
                            <div>test1111@gmail.com</div>
                            <div>정상</div>
                            <div>2023.10.08</div>
                            <div>2023.10.08</div>
                            <button>sms전송</button>
                        </div>
                        <div class="member-single-row">
                            <div><img src="../images/korea.png" /></div>
                            <div>test1111</div>
                            <div>name</div>
                            <div>test1111@gmail.com</div>
                            <div>정상</div>
                            <div>2023.10.08</div>
                            <div>2023.10.08</div>
                            <button>sms전송</button>
                        </div>
                        <div class="member-single-row">
                            <div><img src="../images/korea.png" /></div>
                            <div>test1111</div>
                            <div>name</div>
                            <div>test1111@gmail.com</div>
                            <div>정상</div>
                            <div>2023.10.08</div>
                            <div>2023.10.08</div>
                            <button>sms전송</button>
                        </div>
                        <div class="member-single-row">
                            <div><img src="../images/korea.png" /></div>
                            <div>test1111</div>
                            <div>name</div>
                            <div>test1111@gmail.com</div>
                            <div>정상</div>
                            <div>2023.10.08</div>
                            <div>2023.10.08</div>
                            <button>sms전송</button>
                        </div>
                        <div class="member-single-row">
                            <div><img src="../images/korea.png" /></div>
                            <div>test1111</div>
                            <div>name</div>
                            <div>test1111@gmail.com</div>
                            <div>정상</div>
                            <div>2023.10.08</div>
                            <div>2023.10.08</div>
                            <button>sms전송</button>
                        </div>
                        <div class="member-single-row">
                            <div><img src="../images/korea.png" /></div>
                            <div>test1111</div>
                            <div>name</div>
                            <div>test1111@gmail.com</div>
                            <div>정상</div>
                            <div>2023.10.08</div>
                            <div>2023.10.08</div>
                            <button>sms전송</button>
                        </div>
                        <div class="member-single-row">
                            <div><img src="../images/korea.png" /></div>
                            <div>test1111</div>
                            <div>name</div>
                            <div>test1111@gmail.com</div>
                            <div>정상</div>
                            <div>2023.10.08</div>
                            <div>2023.10.08</div>
                            <button>sms전송</button>
                        </div>
                    </div>
                    <!-- 페이지네이션 관련 부분입니다. 기본적인 틀만 완성해뒀습니다 -->
                    <div class="member-table-bottom">
                        <ul class="pagination modal">
                            <li><a href="#" class="first">처음 페이지</a></li>
                            <li><a href="#" class="arrow left"><<</a></li>
                            <li><a href="#" class="active num">1</a></li>
                            <li><a href="#" class="num">2</a></li>
                            <li><a href="#" class="num">3</a></li>
                            <li><a href="#" class="num">4</a></li>
                            <li><a href="#" class="arrow right">>></a></li>
                            <li><a href="#" class="last">끝 페이지</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
