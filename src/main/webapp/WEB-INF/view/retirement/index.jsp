<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>은퇴 시뮬레이션</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/retire-common.css">
    <link rel="stylesheet" href="/css/retire-main.css">
    <link rel="stylesheet" href="/css/retire-media.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<header class = "header">
    <jsp:include page="../../layout/header.jsp" />
</header>
<body>
<div class="plan_wrap">
    <div class="plan_top">
        <h4>
            <span class="txt_c_green">하나360 </span><span class="txt_c_pink">재무설계</span>
            <p>은퇴재무설계</p>
        </h4>
        <ul>
            <li class="active">재무 설계</li>
            <li>재무 설계 결과</li>
        </ul>
    </div>
    <p class="link_p txt_c_green"><a href="#">단독설계 하러가기</a></p>

    <section class="section_01">
        <h2><b>01.</b>고객님의 정보를 입력해주세요.</h2>
        <div class="plan_box">
            고객님은 <i class="txt_c_pink">1999년생</i>, 현재 나이는 <i class="txt_c_pink">24세</i>입니다.<br>
            고객님의 예상 은퇴 나이는 <input type="text" name="" value="60" disabled> 세 입니다.<br>
            고객님의 기대수명은 <input type="text" name="" value="80" disabled> 세 입니다.
        </div>
    </section>

    <section class="section_02">
        <div class="flex_c_end">
            <h2><b>02.</b>목표별 필요 자금 정보를 입력해주세요.</h2>
            <div>
                <button class="btn_pink">은퇴생활비 통계</button>
                <button class="btn_green">홈텍스랑 연동하기</button>
            </div>
        </div>
        <div class="flex_c_end section_02_info">
            <div class="list_box">
                <p class="sub_title">은퇴 후 생활비</p>
                <ul>
                    <li>예상되는 은퇴 후 월 생활비를 입력해주세요.</li>
                    <li>현 생활비의 70%가 은퇴 후 월 적정생활비입니다.</li>
                    <li>홈택스와 연동하기 버튼을 눌러보세요!<br>하나원큐레이터가 적정 은퇴 생활비를 추천해드립니다.</li>
                </ul>
            </div>
            <div class="plan_box">
                <p>고객님의 현재 월 소비금액은 <input type="text" name="">만원 입니다.</p>
                <p>고객님의 은퇴 후 예상 생활비는 <input type="text" name="">만원 입니다.</p>
            </div>
        </div>
    </section>

    <section class="section_03">
        <h2><b>03.</b>고객님의 자산 정보를 입력해주세요.</h2>

        <div class="min_section">
            <div class="flex_c_end">
                <p class="sub_title">금융 자산 정보</p>
                <button class="btn_green">내 금융 자산 불러오기</button>
            </div>
            <table>
                <tr class="thead">
                    <td rowspan="2">본인</td>
                    <td>하나금융</td>
                    <td>타행</td>
                    <td>기타</td>
                </tr>
                <tr>
                    <td><input type="text" name="" value="33,683,099">원</td>
                    <td><input type="text" name="" value="24,460,500">원</td>
                    <td><input type="text" name="" value="0">원</td>
                </tr>
            </table>
        </div>

        <div class="min_section">
            <div class="flex_c_end">
                <p class="sub_title">종합 소득 및 지출</p>
                <button class="btn_pink">홈택스랑 연동하기</button>
            </div>
            <table>
                <tr class="thead">
                    <td rowspan="2">본인</td>
                    <td>소득금액</td>
                    <td>지출금액</td>
                    <td>지출비율</td>
                </tr>
                <tr>
                    <td><input type="text" name="" value="33,683,099">원</td>
                    <td><input type="text" name="" value="24,460,500">원</td>
                    <td></td>
                </tr>
            </table>
        </div>

        <div class="min_section">
            <p class="sub_title">연금정보</p>
            <div class="table_box">
                <div class="table_fir">본인</div>
                <div class="table_sec">
                    <p>
                        예상하시는
                        <select>
                            <option>국민연금(직장)</option>
                            <option>국민연금(직장)1</option>
                            <option>국민연금(직장)2</option>
                            <option>국민연금(직장)3</option>
                        </select>
                        은 65세부터, 월 수령액은 <input type="text" name="" value="50" disabled>만원 입니다.
                    </p>
                    <button class="btn_green">국민연금수령액 예시 정보</button>
                </div>
            </div>
        </div>

    </section>

    <div class="plan_bot">
        <button class="btn_green">제출</button>
    </div>

</div>



<script src="/js/script.js"></script>
<script src="/js/loan.js"></script>
</body>
<footer>
    <jsp:include page="../../layout/footer.jsp" />
</footer>

</html>
