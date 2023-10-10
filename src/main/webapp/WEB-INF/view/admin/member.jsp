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
    <style>
        a {
            text-decoration: none; /* 밑줄 제거 */
            color: inherit; /* 상위 요소의 텍스트 색상을 상속 */
        }
        .sms-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.7);
            z-index: 1000; /* 모달이 다른 요소 위에 올라오도록 z-index를 높게 설정 */
        }

        .sms-modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: #fff;
            width: 40%; /* 너비 조절 */
            border-radius: 8px; /* 모서리 둥글게 */
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        }

        .sms-modal-close {
            float: right;
            cursor: pointer;
            background-color: red;
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            text-align: center;
            line-height: 20px;
        }

        .sms-modal h2 {
            margin-top: 0;
            color: #333;
            font-size: 24px;
            margin-bottom: 10px;
        }

        .sms-modal p {
            color: #666;
            font-size: 16px;
            margin-bottom: 20px;
        }
        .sms-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .sms-modal-header h2 {
            margin: 0;
            flex-grow: 1;
            font-size: 22px;
            color: #333;
            padding-right: 20px; /* close 버튼과의 간격 */
        }
        #smsMessage {
            width: 90%;
            height: 300px; /* 텍스트 박스 높이 */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            resize: vertical; /* 세로로만 크기 조절 가능하게 */
        }
        .sms-modal-body {
            padding-top: 20px;
        }

        .form-group {
            margin-bottom: 10px; /* 입력란과 다음 요소 간격 조절 */
        }

        #smsSubject {
            width: 90%; /* 입력란 전체 너비로 확장 */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .sms-modal button {
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .sms-modal button:hover {
            background-color: #0056b3;
        }

    </style>
    <script>
        function openSMSModal(email) {
            document.getElementById('smsModal').style.display = 'block';
            document.getElementById('smsRecipientEmail').innerText = email;
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            // 여기에 스크립트 내용을 넣습니다.
            function closeSMSModal() {
                var modal = document.getElementById('smsModal');
                modal.style.display = 'none';
            }

            document.querySelector('.sms-modal-close').onclick = closeSMSModal;
        });
        function sendSMS() {
            var email = document.getElementById('smsRecipientEmail').innerText;
            var subject = document.getElementById('smsSubject').value;
            var message = document.getElementById('smsMessage').value;
            // 여기서 SMS 전송 로직을 추가합니다.

            // SMS 전송을 위한 데이터를 준비합니다.
            var smsData = {
                email: email,
                subject: subject,
                message: message
            };


            fetch('/sendEmail/member', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(smsData)
            })
                .then(response => {
                    if (response.text()) {
                        // 성공적으로 전송된 경우 처리할 내용을 추가하세요.
                        alert('SMS가 성공적으로 전송되었습니다.');
                        window.location.reload();
                    } else {
                        // 오류 처리
                        alert('SMS 전송 중 오류가 발생했습니다.');
                    }
                })
                .catch(error => {
                    console.error('SMS 전송 오류:', error);
                    alert('SMS 전송 중 오류가 발생했습니다.');
                });
        }

        function redirectToAdminIndex() {
            window.location.href = '/admin/index'; // 원하는 URL로 리다이렉션
        }
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
                            <div>분류</div>
                            <div>생년월일<img src="/img/upDownArrow.png" /></div>

                        </div>
                        <c:forEach items="${members.content}" var="user">
                            <div class="member-single-row">
                                <div>${user.userId}</div>
                                <div>${user.name}</div>
                                <div>${user.email}</div>
                                <div>${user.userType}</div>
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
