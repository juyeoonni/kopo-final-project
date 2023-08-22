<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/login.css"> <!-- 추가한 login.css 파일 연결 -->
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
                </form>
            </div>
        </div>
    </main>

    <footer>
        <jsp:include page="../../layout/footer.jsp" />
    </footer>
</div>
</body>
</html>
