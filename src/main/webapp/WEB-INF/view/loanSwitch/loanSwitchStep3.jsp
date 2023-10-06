<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>HanaAsset360</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Bootstrap JS library -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>



        .container mt-5 {
            z-index : -1;
        }

        .step.active .circle {
            background-color: #007bff;
            color: white;
        }
        .step {
            text-align: center;
            width: 25%;
            position: relative;
            z-index: -1; /* 기본적으로 모든 단계의 z-index를 1로 설정 */
        }

        .circle {
            width: 30px;
            height: 30px;
            background-color: #e9ecef;
            border-radius: 50%;
            color: black;
            line-height: 30px;
            margin: 0 auto;
            z-index: 1; /* 원에도 z-index 1을 설정하여 원이 연결선 위에 올라오도록 함 */
            position: relative;
        }

        .step p {
            margin-top: 10px;
        }

        .step::before {
            content: "";
            position: absolute;
            top: 15px;
            left: 50%;
            right: -50%;
            height: 2px;
            background-color: #e9ecef;
        }

        .step:last-child::before,
        .step.last::before {
            /* 마지막 단계에서 연결선을 숨김 */
            display: none;
        }

        .step.active .circle {
            background-color: #007bff;
            color: white;
        }
    </style>
    <script>

        window.onload = function () {
            const checkAll = document.getElementById('chkAll');
            const chks = document.querySelectorAll('input[name="chk"]');
            const chkBoxLength = chks.length;

            checkAll.addEventListener('click', function(event) {
                chks.forEach(function(value){
                    value.checked = event.target.checked;
                });
            });

            chks.forEach(function(chk) {
                chk.addEventListener('click', function() {
                    if (Array.from(chks).every(c => c.checked)) {
                        checkAll.checked = true;
                    } else {
                        checkAll.checked = false;
                    }
                });
            });
        }

        function sendData() {
            const data = {
                selectedLoanProduct: "${selectedLoanProduct}",
                selectedLoanData: "${selectedLoanData}",
                creditData: "${creditData}"
            };

            fetch('/loanSwitch/loanSwitchStep4', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
                .then(response => response.json())
                .then(data => {
                    window.location.href = "/loanSwitch/loanSwitchStep4";
                });
        }
        document.getElementById('step2').classList.add('active');
    </script>
    <header class = "header">
        <jsp:include page="../../layout/header.jsp" />
    </header>
</head>


<body>
<div class="container mt-5">
    <ul class="list-unstyled d-flex justify-content-between">
        <li class="step">
            <div class="circle">1</div>
            <p>대출 상세</p>
        </li>
        <li class="step active">
            <div class="circle">2</div>
            <p>약관동의</p>
        </li>
        <li class="step">
            <div class="circle">3</div>
            <p>서류제출</p>
        </li>
        <li class="step last">
            <div class="circle">4</div>
            <p>대출 신청</p>
        </li>
    </ul>
</div>


<div class="container mt-4">
    <form>
        <h2 class="mb-3">약관 동의</h2>
        <div class="form-group">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="check1">
                <label class="form-check-label" for="check1">개인정보 수집 및 이용에 대한 안내</label>
                <textarea class="form-control mt-2" rows="10" readonly>이 약관은 전자거래서비스의 제공자인 하나360(이하 "회사"라 한다.)와 서비스를 이용하고자 신청하는 고객(“이용자” 라 한다.)간의 서비스 이용에 관한 제반 사항을 정함을 목적으로 한다.

제2조(용어의 정의)
이 약관에서 사용하는 용어의 정의는 다음 각호와 같다.

1. 전자금융거래 : 회사가 이용자의 편의를 위해 전자적 장치를 통하여 금융상품 및 서비스를 제공하고 이용자가 회사와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 서비스로서, 서비스의 종류와 내용은 약관에 명시하기로 한다.
2. 무ID 서비스 : 이용자 번호(ID), 이용자 비밀번호(ID비밀번호)를 사용하지 않고당사 온라인 매체를 이용할 수 있는 서비스
3. 이용자 번호(ID) : 이용자를 식별하기 위한 문자 혹은 숫자(무ID 서비스 신청 고객의 경우 제공하지 않습니다.)
4. 이용자 비밀번호(ID 비밀번호) : 전자금융거래서비스 이용시 이용자의 개인정보 또는 거래정보 등을 보호하기 위하여 설정한 문자나 숫자(무ID 서비스 신청 고객의 경우 제공하지 않습니다.)
5. 전자금융거래서비스 신청계좌 : 전자금융거래서비스를 이용할 수 있도록 회사에 등록한 고객계좌
6. 이체비밀번호 : 고객이 전자금융거래서비스를 이용시 안전성 및 보안성을 확보하기 위하여 고객이 설정하는 문자 혹은 숫자
7. 계좌비밀번호 : 고객이 전자금융거래서비스를 이용한 매매주문 및 자금이체 처리시 안전성 및 보안성을 확보하기 위하여 고객이 설정하는 문자 혹은 숫자
8. 현금카드 : 금융기관의 현금자동지급기(CD) 및 현금자동입출금기(ATM) (이하 양자를 합하여 'CD'라 한다.)를 이용할 수 있는 카드를 말한다.
9. 체크카드 : CD기를 통한 전자자금이체, 직불전자지급이 가능한 카드를 말한다.
10. 고객 : 회사에 계좌를 개설한 자
11. 일회용 비밀번호 : 전자자금이체 등에서 적용하는 일회용비밀번호(보안카드상에 표시되어 있는 비밀번호를 포함한다.
12. 인증서 : 인증기관이 발급하는 인증서 (구 공인인증서 등)
13. 전자서명비밀번호 : 인증서 발급 시 고객이 직접 지정하는 비밀번호
14. 비대면 실명확인 : 성명과 주민등록번호(이하 “주민번호”라 한다)의 확인뿐만 아니라 실명확인증표에 첨부된 사진 등에 의하여 거래자 본인 여부를 온라인 채널(모바일, 홈페이지) 등으로 실명확인하는 방식
15. 간편인증 PIN번호 : 전자금융거래서비스 이용 시 전자서명 비밀번호를 대신하여 입력하는 암호화된 6자 이상의 숫자
16. 생체정보 : 지문, 안면, 홍채, 정맥, 필적, 음성 등 개인을 식별할 수 있는 신체적 특징에 관한 정보로서 그로부터 가공되거나 생성된 정보
17. 간편 인증 : 전자적 장치에서 본인확인 후, 고객이 지정한 본인 명의의 보유 스마트 기기를 통해 간편인증 PIN번호나 지문 등의 생체정보로 인증하여 전자금융거래서비스를 이용하는 수단
18. 스크래핑 : 회사가 이용자의 동의를 얻어 관련기관이 제공하는 정보를 조회하는 서비스
19. ARS업무비밀번호 : ARS를 통해 매매주문, 자금이체 등 처리 시 안전성 및 보안성을 확보하기 위하여 고객이 설정하는 숫자
제3조(서비스의 종류 및 내용)
① 회사가 전자금융거래서비스를 통하여 고객에게 제공하는 서비스의 종류는 다음 각 호와 같다.
1. 투자정보 및 투자상품 조회
2. 실시간 매매주문 및 예약주문
3. 청약
4. 계좌정보조회 및 매매거래,입출금 내역 등의 조회
5. 현금 또는 증권 등의 이체 및 예약이체출금신청
6. 신용공여
7. 투자상담
8. 잔고증명서 등 각종 증명서 신청
9. 증권정보자동전달[고객의 신청에 의해 고객정보 변동사항(매매체결, 권리사항 등)이나 관심정보(시세, 시황 등)를 고객이 보유하고 있는 정보전달매체를 통하여 자동으로 통지하는 서비스]
10. 연결계좌개설[실명확인된 근거계좌(대표계좌)를 보유한 고객이 근거계좌에 연결된 신규계좌를 개설할 수 있는 서비스]
11. CMS 자동이체입금
12. 금융결제원 계좌이체 PG 서비스
13. 스크래핑(비대면 계좌개설 등 업무시)
14. 기타 고객의 편의를 증대시키기 위해 제공하는 서비스
② 회사는 전자적 장치의 매체특성에 따라 서비스 내용을 다르게 제공 할 수 있다.
제4조(본인확인 방법)
① 회사는 다음 각 호의 본인확인 방법의 전부 또는 일부가 사전에 회사에 등록된 자료와 일치할 경우에 이용자 본인으로 인정하고 전자금융거래서비스를 제공한다.
1. 이용자 번호(ID)와 이용자 비밀번호(ID 비밀번호)
2. 인증서와 전자서명비밀번호
3. 고객의 실명번호
4. 고객의 계좌번호 및 계좌비밀번호
5. 보안카드 번호
6. OTP 번호
7. 이체 비밀번호
8. 고객이 지정한 스마트 기기에서의 간편 인증 PIN번호
9. 고객이 지정한 스마트 기기에서의 간편 인증 생체정보
10. 휴대폰 본인인증 서비스 등 타 기관 본인확인 서비스의 활용
11. 다수의 개인정보 검증
12. 그 외 이에 준하는 방법
② 이용자는 제 1항에 따라 등록한 본인인증수단을 회사가 별도로 정하는 절차에 따라 변경 또는 갱신할 수 있다.
③ 이용자가 간편 인증을 위한 PIN번호, 생체정보를 본인인증수단으로 등록하려면 휴대폰 본인확인 및 고객 연락처 확인 등으로 스마트 기기 점유 확인 및 본인확인을 완료해야 한다.
제2장 이용계약
제5조(계약의 성립)
① 이용계약은 이용자가 다음 각호의 어느 하나에 따른 소정의 신청절차를 밟은 후 회사가 이를 승낙함으로써 성립한다.
1. 고객 : 회사 소정양식의 서면신청서를 작성하여 회사의 영업점에 제출하여야 한다. 다만, 은행을 통한 계좌개설과 사업주의 실명확인에 의한 일괄 계좌개설, 비대면 실명확인에 의한 계좌개설은 전자적 장치를 통하여 직접 신청할 수 있다. (퇴직연금 계약자를 포함한다.) 또한 전자금융거래서비스 신청 고객은 전자적 장치를 이용하여 ARS서비스를 신청할 수 있다.
② 회사는 다음 각호에 해당하는 경우 전자금융거래서비스 이용계약의 승낙을 유보할 수 있다.
1. 설비에 여유가 없는 경우
2. 통신장애 등 기술상에 지장이 있는 경우
③ 회사는 다음 각호에 해당하는 경우에는 이용자의 이용계약신청에 대하여 승낙을 하지 아니하거나 승낙을 취소할 수 있다.
1. 다른 사람의 명의를 사용하여 신청하는 경우
2. 필요사항의 기재를 누락하거나 서류를 허위로 작성하여 제출하는 경우
3. 기타 회사의 이용 신청 요건을 충족하지 못하여 회사가 사전에 고객에게 통지한 경우
제6조(이용자의 자격)
① 전자금융거래서비스를 이용할 수 있는 자격은 회사에 계속 사용할 수 있는 활용계좌를 보유한 고객 중 전자금융거래서비스 신청을 한 고객으로 제한할 수 있다.
② 회사는 제3조에 의거 이용자별 분류에 따라 전자금융거래서비스 제공에 등급을 정할 수 있다.
제3장 실시간 매매주문 및 예약주문 서비스
제7조(실시간매매주문)
① 전자금융거래서비스를 통한 실시간 매매주문서비스는 ‘전자금융거래 이용에 관한 기본약관’ 에서 정한 시간 내에서 제공된다. 단, 회사는 매매주문체결시스템의 장애 등 부득이한 경우 시간을 변경할 수 있다.
② 전산 및 회선장애 등으로 인하여 매매주문 처리결과 보고가 지연될 수 있으므로 주문입력 후 처리완료까지의 결과확인은 고객이 직접 해야 하며, 확인 소홀로 인하여 발생한 이중주문 등의 고객의 불이익에 대해서는 회사의 귀책사유가 없는 한 회사가 책임지지 아니한다.
③ 고객이 주문의 정정 또는 취소를 원할 경우에는 거래가 체결되기 전까지 직접 전자적 장치를 통하여 정정 또는 취소를 신청하거나 영업점 등에 요청한다.
제8조(예약주문)
① 전자금융거래서비스를 통한 예약주문 입력은 주문처리 당일 장개시 90분 전까지 가능하다. 단, 회사 및 시장 사정에 따라 예약주문 가능시간이 변경될 수 있다.
② 전자금융거래서비스를 통한 예약주문은 시가결정에 참여하는 호가로 처리함을 원칙으로 한다. 다만, 주문의 폭주, 기타 부득이한 사정으로 인하여 시가결정에 참여하는 호가로 처리하지 못한 예약주문은 주문접수 순서에 따라 정규시장에서 처리한다.
③ 예약주문이 다음 각호의 1에 해당하는 경우에는 처리되지 않는다.
1. 주문가격이 가격제한폭을 초과하는 경우
2. 위탁증거금이 부족한 경우
3. 기타 예약주문종목의 매매거래정지 등으로 주문처리가 불가능한 경우
제4장 기타
제9조(거래내용의 서면 제공)
거래내용의 서면 제공과 관련한 요청방법, 절차 등은 다음 각 호에서 정한 바에 따른다.

1. 고객은 영업점을 방문하거나 ‘금융거래정보제공동의서‘를 동봉한 우편을 통하여 거래내용의 서면교부를 요청할 수 있다.
2. 회사는 거래내용을 서면으로 고객에게 교부하는 경우 <별첨>에서 정하는 수수료를 징수할 수 있다.
제10조(전자금융거래 장애시 서비스 이용방법)
① 이용자는 전자금융거래서비스의 장애시 회사의 고객센터(1588-6800) 또는 영업점을 통해 매매주문 등을 이용할 수 있으며 일부 전자적 장치의 장애시에는 이용 가능한 다른 전자적 장치를 통하여 서비스를 이용할 수 있다.
② 제1항의 규정에 의하여 고객이 대체주문방법을 이용하는 경우 회사는 각종 수수료를 전자금융거래서비스를 이용할 때와 동일하게 적용한다.
제11조(계약사항의 변경)
전자금융거래 서비스 이용자는 영업점이나 회사 인터넷 홈페이지 등을 통해 이용자 등록정보를 현재 사실과 일치하는 최신의 정보로 변경유지하여야 한다.

제12조(회사제공 컨텐츠)
① 이용자는 회사가 제공하는 전자금융거래서비스를 통해 제공되는 컨텐츠를 영업상의 목적으로 다른 이에게 전송하여서는 아니되며, 이를 위반하여 발생하는 책임은 이용자에게 있다.
② 회사가 제공하는 컨텐츠는 투자 판단의 참고 사항이며, 투자판단의 최종 책임은 컨텐츠를 열람하는 이용자에게 있다.
③ 이용자는 회사가 제공하는 전자금융거래서비스 등을 통해 의견을 제시하거나 컨텐츠 등을 게시할 수 있다. 다만 그 내용이 반사회적, 부도덕적인 경우 또는 회사의 이익에 반하거나 근거없이 회사를 비방하는 경우에 회사는 임의로 게시물을 삭제하는 등의 조치를 취할 수 있다.
④ 회사는 컨텐츠의 정확성, 완전성 또는 품질에 대하여 노력하되, 이를 보장하지는 아니한다.
제13조(전자금융거래 서비스 제공의 중지)
① 회사는 다음 각호의 경우에 이용자에게 사전통보 없이 전자금융거래서비스의 전체 또는 일부 서비스 제공을 중지할 수 있다.
1. 전자금융거래서비스 신청계좌가 고객의 폐쇄요청 또는 자동폐쇄 요건에 의해 폐쇄된 경우 전체 서비스 제공을 중지할 수 있다.
2. 고객의 전자금융거래서비스 신청계좌가 통합계좌 편입요건에 해당되어 회사 통합계좌로 편입된 경우 전체 서비스 제공을 중지할 수 있다.
3. 압류등록, 질권설정, 전기통신금융사기 관련 지급정지 등록 등의 경우 일부 서비스 제공을 중지할 수 있다.
② 회사는 다음 각호의 경우에 이용자에게 사전통보조치에 의하여 전자금융거래서비스의 제공을 중지할 수 있다.
1. 연속하여 미리 정한 일정횟수 이상의 비밀번호 입력오류가 발생한 경우 즉시 해당 비밀번호를 이용하는 전자금융거래의 중지
2. 인증서의 유효기간이 만료되었거나 인증서가 취소된 경우 즉시 해당 인증서를 이용하는 전자금융거래의 제한
3. 고객이 접근매체를 타인에게 누설하였음을 회사가 안 경우
4. 접근매체가 도용, 위조 또는 변조된 사실을 회사가 안 경우
5. 이용자가 관계법령 또는 이 약관의 규정을 위반하였을 때
6. 이용자가 고의로 정보통신망을 침해하거나 이용을 방해하는 행위를 하였을 때
7. 기타 회사의 업무수행에 이용자가 지장을 초래하거나 초래할 위험이 있다고 인정될 때
8. 이용자가 등록한 간편 인증이 등록한지 3년이 경과하였거나, 등록한 스마트 기기 정보 또는 생체정보가 변경되었을 때
③ 제2항 제1호에 의하여 중지된 전자금융거래를 재개하고자 하는 경우 고객은 회사의 고객 본인확인 절차를 거친 후 비밀번호를 재부여받아야 한다.
제14조(전자금융거래 서비스의 해지)
이용자가 전자금융거래서비스의 이용계약을 해지하고자 하는 경우에는 가까운 영업점(방문 또는 유선), 고객센터(유선), 해지신청접수가 가능한 전자적 장치를 통하여 해지를 신청할 수 있다.

제15조(일회용 비밀번호)
① 고객이 제3조 제1항에 정한 서비스를 이용하는 경우 회사는 고객에게 일회용 비밀번호 입력을 요구하여 전자금융거래의 보안을 강화할 수 있다.
② 회사는 제1항 이외에도 전자금융거래의 안전성 및 보안성을 확보하기 위하여 고객에게 일회용 비밀번호 입력을 요구할 수 있다.
제16조(이용자 준수 사항)
이용자는 계좌비밀번호, 이용자번호(ID), 이용자비밀번호(ID 비밀번호), 인증서, 전자서명비밀번호, 이체비밀번호, 일회용 비밀번호, PIN 번호 등의 접근매체를 타인에게 누설하여서는 안되며 접근매체가 누설되었을 경우에는 지체없이 고객센터(1588-6800) 또는 영업점에 통보해야 한다.

제17조 (약관의 변경등)
① 회사는 약관을 변경하고자 하는 경우 시행일 1개월 전에 변경되는 약관을 전자금융거래를 수행하는 전자적 장치(해당 전자적 장치에 게시하기 어려운 경우에는 고객이 접근하기 용이한 전자적 장치로서 회사가 지정하는 대체장치를 포함한다. 이하 이 조항에서 정한 내용과 같다.)에 게시하고 고객에게 전자문서 등 고객과 사전에 합의된 방법으로 통지하여야 한다. 다만, 고객이 이의를 제기할 경우 회사는 고객에게 적절한 방법으로 약관 변경내용을 통지하였음을 확인해 주어야 한다.
② 제1항에 불구하고 회사가 법령의 개정으로 인하여 긴급하게 약관을 변경하는 때에는 변경된 약관을 전자적 장치에 1개월 이상 게시하고 제1항에서 정한 방법으로 고객에게 통지하여야 한다.
③ 고객은 제1항 및 제2항에 따라 약관의 변경내용이 게시되거나 통지된 후부터 변경되는 약관의 시행일 전의 영업일까지 전자금융거래계약을 해지할 수 있다.
④ 회사는 제3항에 따른 기간동안 고객이 약관의 변경내용에 대하여 이의를 제기하지 아니하는 경우에는 약관의 변경을 승인한 것으로 본다.
⑤ 회사는 고객이 약관의 교부를 요청하는 경우 이에 응하여야 하며, 전자금융거래를 수행하는 전자적 장치에 게시하여 고객이 약관을 조회하고 다운로드(화면출력을 포함한다)받을 수 있도록 한다.
제18조 (약관적용의 우선순위)
전자금융거래에 관해서는 전자금융거래이용에 관한 기본약관을 우선 적용하며, 이 약관에서 정하지 않은 사항은 전자금융거래법 등 관련법령 및 전자금융거래관련약관이 정하는 바에 따른다.

부 칙 <1999. 4. 6.>
(약관의 적용)
종전의 Dial-van이용약관, 이체약정서, 대체거래약정서, 현금카드이용거래약관, 능동적 정보전달시스템이용약관은 폐지하고 이 약관을 적용한다.

부 칙 <2004. 4. 6.>
제1조(시행일)
2004년 4월 6 일부터 시행한다.

제2조(경과조치)
기존의 이체비밀번호 등을 사용하는 고객에 대하여는 이체비밀번호 입력 오류 등 회사가 정하는 사유가 발생한 경우에 이체비밀번호 등 을 대체하여 보안카드 등을 발급하는 것으로 한다.</textarea>
                </textarea>
            </div>
        </div>

        <div class="form-group">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="check2">
                <label class="form-check-label" for="check2">스크래핑 이용약관 동의</label>
                <textarea class="form-control mt-2"  rows="10" readonly>1. 수집•이용목적 □ 대출심사에 필요한 서류 제출의 편의성 제공
□ 고객정보(본인진위여부, 소득, 직업 등) 판단을 위한 자료로 활용
2. 수집•이용할 항목 □ 신분증(주민등록증, 운전면허) 관련 정보, 사업자번호(자영업자의 경우)
□ 건강보험공단: 건강보험납부확인서, 건강보험자격득실확인서
□ 국세청: 소득금액증명, 부가가치세과세표준증명, 근로소득 지급명세서
□ 정부24 : 주민등록원초본, 자동차등록원부
3. 제공받는 자 □ 하나360
□ 스크래핑 공급계약업체: ㈜. 하나360
4. 보유•이용기간
□ (금융)거래 종료일*로부터 5년까지 보유·이용
□ (금융)거래 종료일 후에는 금융사고 조사, 분쟁 해결, 민원처리, 법령상 의무이행 및 당 사의 리스크관리 업무만을 위하여만 보유·이용
 * (금융)거래 종료일이란 당행과 거래중인 모든 계약(여·수신, 내·외국환, 카드 및 제3자 담보제공 등)해지
 및 서비스(대여금고, 보호예수, 외국환거래지정, 인터넷뱅킹 포함 전자금융거래 등)가 종료한 날을 뜻함
5. 동의를 거부할 권리 및 동의를 거부 할 경우의 불이익
□ 서비스 이용을 위하여 필수적인 사항 (단, 거부할 경우 대출심사자를 통한 대출서류 직접 제출 필요)
□ 본인은 개인정보의 제공 및 활용에 대해 인지하고 동의합니다.</textarea>
            </div>
        </div>

        <div class="form-group">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="check3">
                <label class="form-check-label" for="check3">이벤트 등 프로모션 알림 메일 수신</label>
            </div>
        </div>

        <div class="form-group">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="allAgree">
                <label class="form-check-label" for="allAgree">전체 동의</label>
            </div>
        </div>

        <div class="d-flex justify-content-end mt-4"> <!-- 'justify-content-end'로 오른쪽 정렬 -->
            <button type="submit" class="btn btn-primary" onclick="sendData()">동의</button>
        </div>
    </form>
</div>



<script>
    $(document).ready(function() {
        $("#allAgree").change(function() {
            var isChecked = $(this).prop("checked"); // '전체 동의' 체크박스의 상태를 가져옴
            $(".form-check-input").prop("checked", isChecked); // 모든 체크박스의 상태를 '전체 동의' 체크박스와 동일하게 설정
        });

        // '전체 동의' 이외의 체크박스가 변경될 때
        $(".form-check-input:not(#allAgree)").change(function() {
            if ($(".form-check-input:not(#allAgree):checked").length === $(".form-check-input:not(#allAgree)").length) {
                // 모든 체크박스가 체크되면 '전체 동의' 체크박스도 체크
                $("#allAgree").prop("checked", true);
            } else {
                // 하나라도 체크가 안 되어 있으면 '전체 동의' 체크박스는 체크 해제
                $("#allAgree").prop("checked", false);
            }
        });
    });
</script>
</body>
<footer class="footer">
    <jsp:include page="../../layout/footer.jsp" />

</footer>
</html>