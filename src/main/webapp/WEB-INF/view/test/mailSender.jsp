<%@ page import="kr.ac.kopo.final_hanaasset360.vo.UserVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>HanaAsset360</title>
    <link rel="stylesheet" href="/css/styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>

<form action="sendEmail" method="post">
    To: <input type="text" name="to"><br>
    Subject: <input type="text" name="subject"><br>
    Text: <textarea name="text"></textarea><br>
    <input type="submit" value="Send Email">
</form>

</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>