<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Calendar</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/calculator/calculator.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>
<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<div class="container">
    <div class="left-section">
        <!-- Calendar Section -->

        <!-- Loan History Section -->
        <div class="section" id="loan-history">
            <h2>대출내역</h2>
            <!-- Loan History content goes here -->
        </div>

        <!-- Loan Assessment Result Section -->
        <div class="section" id="loan-assessment">
            <h2>대출 심사 결과</h2>
            <!-- Loan Assessment content goes here -->
        </div>

    </div>

    <div class="right-section">

        <!-- Interest Repayment Section -->
        <div class="section" id="interest-repayment">
            <h2>이자상환</h2>
            <div id="calendar">
                <div class="c-header">
                    <button id="prevMonth">⟨</button>
                    <span id="currentMonthYear"></span>
                    <button id="nextMonth">⟩</button>
                </div>
                <div class="days">
                    <!-- Days will be filled dynamically -->
                </div>
            </div>
            <!-- Interest Repayment content goes here -->
        </div>

        <!-- Retirement Simulation Section -->
        <div class="section" id="retirement-simulation">
            <h2>은퇴 시뮬레이션</h2>
            <!-- Retirement Simulation content goes here -->
        </div>

    </div>
</div>

<script src="/js/calender.js"></script>

</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>
</html>