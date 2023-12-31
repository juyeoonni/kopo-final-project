<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel = "stylesheet" href = "/css/loan/loan.css">
    <link rel="stylesheet" href="/css/styles.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

    <header class = "header">
        <jsp:include page="../../layout/header.jsp" />
    </header>
    <style>

    </style>
</head>
<body>
    <main class="mx-auto max-w-800">
        <section class="flex flex-col items-center justify-center mt-36">
            <div class="w-full px-20">
                <h1 class="font-extrabold whitespace-pre-line text-head-32">
                    대출 갈아타기,
                <br />
                    언제 필요할까요?
                </h1>
                <br />
                <p class="mt-16 font-bold text-gray-100 whitespace-pre-line text-body-18" style="color: #97a0af">
                    이자 금리 감소!, 상환 기간 연장!
                </p>
                <div class ="gift-box">
                    <img src="/img/Gift Box Explode.gif" alt="gift-box" style="max-width: 100%; height: auto;">
                </div>
            </div>
            <div class="w-375 h-274">
                <button onclick="location.href='/loanSwitch/loanswitch'" style="width: 300px; height: 60px; border-radius: 15px 15px 15px 15px; font-size: 18px">
                    대출 갈아타기
                </button>

            </div>
        </section>

        <section class="flex flex-col items-center justify-center mt-36">
            <div class="w-full px-20">
                <h1 class="font-extrabold whitespace-pre-line text-head-32">
                    대출 갈아타기로
                    <br />
                    이자, 낮춰보세요.
                </h1>
                <br />
                <p class="mt-16 font-bold text-gray-100 whitespace-pre-line text-body-18" style="color: #97a0af">
                    서류 제출부터 상환까지 하나360이 대환 해드려요.
                </p>
                <div class ="gift-box" style ="margin-top : 3%">
                    <img src="/img/pig.gif" alt="gift-box" style="max-width: 100%; height: auto; width: 300px; margin-left:7%">
                </div>

                <div class ="first-box">
                    <h3>1. 이자가 부담스러울 때</h3>
                    <br />
                    <p>기존의 대출보다 더 낮은 이자로</p>
                    <p>대환이 가능하면 이자 부담 감소!</p>
                </div>
                <hr>
                <div class ="second-box">
                    <h3>2. 대출 만기가 부담될 때</h3>
                    <br />
                    <p>대출을 상환하고 새로운 만기 조건으로</p>
                    <p>상환 기간이 길어지는 효과!</p>
                </div>
                <hr>
                <div class ="third-box">
                    <h3>3. 시중 금리가 내렸을 때</h3>
                    <br />
                    <p>시중 금리가 내렸을 경우거나</p>
                    <p>정책 금리가 바뀌면 확인하세요!</p>
                </div>
            </div>

        </section>


    </main>




<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
<script src="/js/bank.js"></script>
</body>
</html>

