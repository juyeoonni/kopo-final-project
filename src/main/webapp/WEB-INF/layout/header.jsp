<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <div class="header__logo">
        <a href="/" class="logo__image">
            <img src="/img/logo2.png" alt="로고" width="200px" height="70px" style="margin-left: 200px">
        </a>
    </div>
    <!-- <nav class="header__nav"> -->
    <ul class="nav__list">
        <div class="left">
            <li class="nav__item">
                <a href="#" class="nav__link">대출</a>
                <ul class="item__list">
                    <div class="list__left">
                        <div class="list__title">
                            대출 갈아타기로 <br/>
                            이자 부담,<br/>
                            확 낮춰보세요
                        </div>
                        <div class="list__image">
                            <img
                                    class="list__percent"
                                    src="/img/percent.jpg"
                                    alt=""
                            />
                        </div>

                        <a class="list__button" href="">대출 갈아타기</a>
                    </div>
                    <div class="list__right">
                        <ul class="list__list">
                            <div class="list__title__sub">대출</div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/loanSwitch/loanswitch">
                                    <strong>💳 대출 가입</strong>
                                </a>
                            </div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/loanProduct/loanProduct">
                                    <strong>🔍 대출 상품 조회</strong>
                                </a>
                            </div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/loanSwitch/loanswitch">
                                    <strong>💵 이자 상환</strong>
                                </a>
                            </div>
                            <br />
                        </ul>
                    </div>
                    <div class="list__right">
                        <ul class="list__list">
                            <div class="list__title__sub">대출 갈아타기</div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/loanSwitch/loanSwitchIndex">
                                    <strong>🔄 대출 바로 갈아타기</strong>
                                </a>
                            </div>
                        </ul>
                    </div>
                </ul>
            </li>


            <li class="nav__item">
                <a href="/calculator" class="nav__link">계산기</a>
                <ul class="item__list">
                    <div class="list__left">
                        <div class="list__title">
                            금융 계산, <br />
                            이제 손끝에서!<br />
                            순식간에 확인하세요!
                        </div>

                        <div class="list__image">
                            <img class="list__percent" src="/img/card.jpg" alt="" />
                        </div>
                        <a class="list__button" href="">대출 이자 확인하기</a>
                    </div>
                    <div class="list__right">
                        <ul class="list__list">
                            <div class="list__title__sub">연말정산 계산기</div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/calculator/incomededuction">
                                    🥇 카드/현금 연말정산 계산기
                                </a>
                            </div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="">
                                    🥈 주택 연말정산 계산기
                                </a>
                            </div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="">
                                    🥉 연금/펀드 연말정산 계산기
                                </a>
                            </div>
                        </ul>
                    </div>
                    <div class="list__right">
                        <ul class="list__list">
                            <div class="list__title__sub">금융 계산기</div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/calculator/loanCalculator">
                                    🥇 대출 이자 계산기
                                </a>
                            </div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/calculator/savings">
                                    🥈 적금 계산기
                                </a>
                            </div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/calculator/deposit">
                                    🥉 예금 계산기
                                </a>
                            </div>
                        </ul>
                    </div>
                    <div class="list__right">
                        <ul class="list__list">
                            <div class="list__title__sub">대출 갈아타기 계산기</div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="">
                                    🥇 대출 갈아타기 계산기
                                </a>
                            </div>
                        </ul>
                    </div>
                </ul>
            </li>
            <li class="nav__item">
                <a href="/sms/verifyPage" class="nav__link">서비스</a>
                <ul class="item__list">
                    <div class="list__left">
                        <div class="list__title">
                            은퇴 시뮬레이션으로 <br/>
                            <span>투자, 적금</span>을 <br/>
                            추천받으세요
                        </div>

                        <div class="list__image">
                            <img class="list__percent" src="/img/card.jpg" alt="" />
                        </div>
                        <a class="list__button" href="">내 최저금리 조회하기</a>
                    </div>
                    <div class="list__right">
                        <ul class="list__list">
                            <div class="list__title__sub">돈이 된다! 머니피드</div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/retirement/index">
                                    <strong>🥇 은퇴 시뮬레이션</strong>
                                </a>
                            </div>
                            <br />
                            <div class="list__title__sub__sub">
                                <a href="/mypage/loanManagement">
                                    <strong>🥈 대출 관리</strong>
                                </a>
                            </div>

                        </ul>
                    </div>
                </ul>
            </li>
        </div>
        <li class="nav__item">
            <a href="#" class="nav__link">고객센터</a>
        </li>
    </ul>
    <!-- </nav> -->

<%
    Object loggedInUser = session.getAttribute("loggedInUser");
    if (loggedInUser != null) {
%>
<!-- 로그인 상태일 때의 UI -->
<ul class="user">
    <li class="user__item"><a href="/login" class="user__link">로그아웃</a></li>
    <li class="user__item"><a href="/mypage/index" class="user__link">마이페이지</a></li>
    <input class="user__item" type="image" width="40px" src="/img/kakaoHeader.png" alt="Submit" onClick="sendLinkCustom();" style="border-radius: 50%; overflow: hidden; object-fit: cover;">

</ul>

<%
} else {
%>
<!-- 로그아웃 상태일 때의 UI -->
<ul class="user">
    <li class="user__item"><a href="/login" class="user__link">로그인</a></li>
    <li class="user__item"><a href="" class="user__link">회원가입</a></li>
</ul>
<%
    }
%>

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

