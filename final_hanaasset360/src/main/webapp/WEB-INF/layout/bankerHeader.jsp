<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="header">
    <h1 class="header__logo">
        <a href="" class="header__logo-link"> <img src="/img/logo.png" width="180px"> </a>
    </h1>
    <p class="header__text">대출심사</p>
    <div class="header__user">
        <p class="header__welcome">
            <strong>${loggedInUser.name} 대리님</strong>
            <br />환영합니다
        </p>
        <div class="header__image">
            <img src="/img/bankerhome.png" alt="user" width="32px" height="32px"/>
        </div>
        <div class="header__icon">
            <a href="/logout" class="header__icon-link">
                <img src="/img/logout.png" width="32px" height="32px">
            </a>
        </div>
    </div>
</header>