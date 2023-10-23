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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
    <style>
        /*body {*/
        /*    display: flex;*/
        /*    justify-content: center;*/
        /*    align-items: center;*/
        /*    height: 100vh;*/
        /*    background-color: #f8f8f8;*/
        /*}*/
        .container {
            display: flex;
            flex-wrap: wrap;
            max-width: 1200px;  /* or adjust as needed */
            margin: 0 auto;
        }

        .left-section,
        .right-section {
            flex: 1;  /* occupies 50% width each */
            padding: 15px;
            box-sizing: border-box;
        }

        .section {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ccc;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
        }
        #calendar {
            width: 350px;
            border: 1px solid #ccc;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .c-header {
            display: flex;
            justify-content: space-between;
            background-color: #2c3e50;
            color: #ffffff;
            padding: 10px;
            width: 100%; // 전체 너비로 확장

        }

        .days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
        }

        .days div {
            padding: 15px;
            border: 1px solid #ddd;
            text-align: center;
            transition: background-color 0.3s ease;
        }

        .days div:hover {
            background-color: #f1f1f1;
        }

        .days div.today {
            background-color: #e74c3c;
            color: #be0618;
        }

        .days div:nth-child(7n+1),
        .days div:nth-child(7n) {
            background-color: #ecf0f1;
        }
        .weekday {
            font-weight: bold;
            text-align: center;
            background-color: #e0e0e0;
            padding: 5px;
        }
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        #currentMonthYear {
            flex-grow: 1;
            text-align: center;
        }
    </style>
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