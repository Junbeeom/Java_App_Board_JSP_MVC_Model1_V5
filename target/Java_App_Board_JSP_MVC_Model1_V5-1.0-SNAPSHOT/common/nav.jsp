<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<nav class ="navbar navbar-default">
    <div class="navbar-header"> <!-- 홈페이지의 로고 -->
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
            <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
            <span class ="icon-bar"></span>
            <span class ="icon-bar"></span>
        </button>
        <a class ="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="main.jsp">메인</a></li>
            <li><a href="../board/board.jsp">게시판</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                   data-toggle="dropdown" role ="button"
                   aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li class="active"><a href="../login/login.jsp">로그인</a></li>
                    <li><a href="../login/join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>