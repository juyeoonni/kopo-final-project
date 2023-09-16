<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>캘린더</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            position: relative;
        }

        section {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #EDF1F4;
        }

        .container {
            min-width: 400px;
            border-radius: 10px;
            box-shadow: 10px 10px 30px rgba(0, 0, 0, .1), -15px -15px 30px #FFF;
        }

        #dycalendar {
            width: 100%;
            padding: 30px 30px 0;
        }

        #dycalendar table {
            width: 100%;
            border-spacing: 15px;
            margin-top: 40px;
        }

        #dycalendar table tr:nth-child(1) td {
            background-color: #2598EB;
            color: #FFF;
            border-radius: 10px;
            font-weight: 700;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, .1), -5px -5px 10px #FFF;
            border: 2px solid #EDF1F4;
        }

        #dycalendar table tr:nth-child(1) td:nth-child(1) {
            background-color: #CC3333;
        }

        #dycalendar table td {
            color: #777;
            padding: 10px 15px;
            font-size: 1.25em;
            font-weight: 500;
            border-radius: 10px;
            cursor: pointer;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, .1), -5px -5px 10px rgba(255, 255, 255, 1);
        }

        #dycalendar table td:hover {
            box-shadow: inset 5px 5px 10px rgba(0, 0, 0, .1), inset -5px -5px 10px rgba(255, 255, 255, 1);
        }

        #dycalendar table td:first-child {
            color: #CC3333;
        }

        .dycalendar-month-container .dycalendar-target-date{
            background-color: #2598EB;
            color: #FFF !important;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, .1), -5px -5px 10px rgba(255, 255, 255, 1) !important;
            border: 2px solid #EDF1F4;
        }

        .dycalendar-month-container .dycalendar-header .dycalendar-prev-next-btn.prev-btn {
            width: 45px;
            height: 45px;
            font-size: 2em;
            left: 15px;
            color: #777;
            background-color: #EDF1F4;
            border-radius: 10px;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, .1), -5px -5px 10px rgba(255, 255, 255, 1);
        }

        .dycalendar-month-container .dycalendar-header .dycalendar-prev-next-btn.next-btn {
            width: 45px;
            height: 45px;
            font-size: 2em;
            right: 15px;
            color: #777;
            background-color: #EDF1F4;
            border-radius: 10px;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, .1), -5px -5px 10px rgba(255, 255, 255, 1);
        }

        .dycalendar-month-container .dycalendar-header .dycalendar-prev-next-btn.prev-btn:active,
        .dycalendar-month-container .dycalendar-header .dycalendar-prev-next-btn.next-btn:active {
            box-shadow: inset 5px 5px 10px rgba(0, 0, 0, .1), inset -5px -5px 10px rgba(255, 255, 255, 1);
        }

        .dycalendar-span-month-year {
            color: #2598EB;
            font-size: 2em;
            font-weight: 400;
        }

    </style>
    <script>
        dycalendar.draw({
            target: "#dycalendar",
            type: "month",
            highlighttargetdate: true,
            prevnextbutton: "show",
        });
    </script>
</head>

<body>
<section>
    <div class="box">
        <div class="container">
            <div id="dycalendar"></div>
        </div>
    </div>
</section>
<script src="dycalendar.js"></script>
</body>
</html>
