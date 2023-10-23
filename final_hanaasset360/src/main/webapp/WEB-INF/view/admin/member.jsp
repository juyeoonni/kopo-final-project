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
    <link rel="stylesheet" href="/css/admin/admin.css" />
    <link rel="stylesheet" href="/css/mypage/member.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>


    <script>
    </script>
</head>
<body>
<div class="body-row">
    <!-- 사이드 바 부분 -->
    <div class="admin-sidebar">
        <div class="sidebar-routers">
            <div class="icon-box admin-logo-wrapper" onclick="redirectToAdminIndex()">
                <img src="/img/hanaLogo.png" />
                하나360
            </div>
            <a href="/admin/index"> <!-- 원하는 URL로 변경하세요 -->
                <div class="admin-router icon-box">
                    <img width="20px" src="/img/homeIcon.png" />
                    메인 홈
                </div>
            </a>
            <a href="/admin/member"> <!-- 원하는 URL로 변경하세요 -->
                <div class="current-router admin-router icon-box">
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
    <div class="member-body-wrapper">
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
                            <img src="/img/searchIcon.png" />
                        </div>
                    </div>
                </div>
                <!-- 테이블의 데이터를 나타내는 부분입니다 -->
                <!-- 임시로 값을 넣어뒀습니다 -->
                <div class="member-table-wrapper">
                    <div>
                        <div class="member-table-top member-single-row">
                            <div>
                                ID
                            </div>
                            <div>이름<img src="/img/upDownArrow.png" /></div>
                            <div>이메일<img src="/img/upDownArrow.png" /></div>
                            <div>전화번호<img src="/img/upDownArrow.png" /></div>
                            <div>생년월일<img src="/img/upDownArrow.png" /></div>

                        </div>
                        <c:forEach items="${members.content}" var="user">
                            <div class="member-single-row">
                                <div>${user.userId}</div>
                                <div>${user.name}</div>
                                <div>${user.email}</div>
                                <div>${user.phone}</div>
                                <div>${fn:substring(user.birth, 0, 10)}</div>
                                <button onclick="openSMSModal('${user.email}')">MAIL 전송</button>
                            </div>
                        </c:forEach>

                        <!-- 페이지네이션 -->
                        <div class="member-table-bottom">
                            <ul class="pagination modal">
                                <!-- 처음 페이지 -->
                                <li><a href="?page=0" class="first">처음 페이지</a></li>

                                <!-- 이전 페이지 -->
                                <c:if test="${not members.first}">
                                    <li><a href="?page=${members.number - 1}" class="arrow left"><<</a></li>
                                </c:if>

                                <!-- 페이지 번호들 -->
                                <c:forEach begin="1" end="${members.totalPages}" var="pageNum">
                                    <c:choose>
                                        <c:when test="${members.number + 1 == pageNum}">
                                            <li><a href="#" class="active num">${pageNum}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="?page=${pageNum - 1}" class="num">${pageNum}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <!-- 다음 페이지 -->
                                <c:if test="${not members.last}">
                                    <li><a href="?page=${members.number + 1}" class="arrow right">>></a></li>
                                </c:if>

                                <!-- 끝 페이지 -->
                                <li><a href="?page=${members.totalPages - 1}" class="last">끝 페이지</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- mail 전송 모달 -->
<div id="smsModal" class="sms-modal">
    <div class="sms-modal-content">
        <div class="sms-modal-header">
            <h2>Mail 전송</h2>
            <span class="sms-modal-close">&times;</span>
        </div>
        <div class="sms-modal-body">
            <p>받는 사람: <span id="smsRecipientEmail"></span></p>
            <div class="form-group">

                <input type="text" id="smsSubject" placeholder="제목을 입력하세요.">
            </div>
            <textarea id="smsMessage" placeholder="메시지를 입력하세요."></textarea>
            <button onclick="sendSMS()">전송</button>
        </div>
    </div>
</div>
</body>
</html>
