<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/login.css"> <!-- 추가한 login.css 파일 연결 -->
    <script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>

</head>
<body>
<div id="container">
    <header class = "header">
        <jsp:include page="../../layout/header.jsp" />
    </header>
    <div class="blank"></div>
    <script src="/js/script.js"></script>
    <!-- Main Content -->
    <main id="main-content">
        <div id="login-form-container">
            <div id="login-form">
                <h2>로그인</h2>
                <form action="/login-process" method="post">
                    <div class="input-group">
                        <label for="username">아이디:</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="input-group">
                        <label for="password">비밀번호:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <button type="submit" class="login-button">로그인</button>
                    <input type="button" onClick="sendLinkCustom();" value="Custom"/>
                </form>
            </div>
        </div>
    </main>

    <script type="text/javascript">
        function sendLinkCustom() {
            Kakao.init("58667b2854c0e6112d3b6e0d9caef534");
            Kakao.Link.sendCustom({
                templateId: 99157
            });
        }
    </script>
    <script>
        try {
            function sendLinkDefault() {
                Kakao.init('58667b2854c0e6112d3b6e0d9caef534')
                Kakao.Link.sendDefault({
                    objectType: 'feed',
                    content: {
                        title: '딸기 치즈 케익',
                        description: '#케익 #딸기 #삼평동 #카페 #분위기 #소개팅',
                        imageUrl:
                            'http://k.kakaocdn.net/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png',
                        link: {
                            mobileWebUrl: 'https://developers.kakao.com',
                            webUrl: 'https://developers.kakao.com',
                        },
                    },
                    social: {
                        likeCount: 286,
                        commentCount: 45,
                        sharedCount: 845,
                    },
                    buttons: [
                        {
                            title: '웹으로 보기',
                            link: {
                                mobileWebUrl: 'https://developers.kakao.com',
                                webUrl: 'https://developers.kakao.com',
                            },
                        },
                        {
                            title: '앱으로 보기',
                            link: {
                                mobileWebUrl: 'https://developers.kakao.com',
                                webUrl: 'https://developers.kakao.com',
                            },
                        },
                    ],
                })
            }
            ; window.kakaoDemoCallback && window.kakaoDemoCallback() }
        catch(e) { window.kakaoDemoException && window.kakaoDemoException(e) }
    </script>
    <footer>
        <jsp:include page="../../layout/footer.jsp" />
    </footer>
</div>
</body>
</html>
