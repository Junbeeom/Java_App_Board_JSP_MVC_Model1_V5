<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
    <link rel="stylesheet" href="../css/bootstrap.css"> <!-- 참조  -->
    <title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
    // XSS 방지가 되어야 하는 기준
    // 1. 사용자한테 입력 받는 값
    // 2. 외부에 API 요청 된 데이터 (정확히 알 수 없는 데이터)

    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    if (session.getAttribute("id") != null) {
        userID = (String)session.getAttribute("id");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = '../login/login.jsp'");
        script.println("</script>");
    }

    int boardNo = 0;
    if (request.getParameter("boardNo") != null) {
        boardNo = Integer.parseInt(request.getParameter("boardNo"));
    }
    if (boardNo == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href = 'board.jsp'");
        script.println("</script>");
    }
    ResultSet resultSet =  null;
    BoardDAO boardDAO = new BoardDAO();
    resultSet = boardDAO.getBoard(boardNo);
    while (resultSet.next()) {
        if (!userID.equals(resultSet.getString("name"))) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('권한이 없습니다.')");
            script.println("location.href = 'board.jsp'");
            script.println("</script>");
        }
    }
    resultSet.beforeFirst();

%>
<nav class ="navbar navbar-default">
    <div class="navbar-header"> <!-- 홈페이지의 로고 -->
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
            <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
            <span class ="icon-bar"></span>
            <span class ="icon-bar"></span>
        </button>
        <a class ="navbar-brand" href="../login/main.jsp">JSP 게시판 웹 사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="../login/main.jsp">메인</a></li>
            <li class="active"><a href="board.jsp">게시판</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                   data-toggle="dropdown" role ="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="../login/logoutAction.jsp">로그아웃</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="row">
        <!-- POST : body -->
        <form method="post" action="updateAction.jsp?boardNo=<%= boardNo %>">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                <tr>
                    <th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글 수정 양식</th>
                </tr>
                </thead>
                <tbody>
                <%
                    while (resultSet.next()) {
                %>
                <tr>
                    <td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50" value="<%= resultSet.getString("title").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %>" ></td>
                </tr>
                <tr>
                    <td><textarea class="form-control" placeholder="글 내용"  name="content" maxlength="2048" style="height:350px" ><%= resultSet.getString("content").replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></textarea></td>
                </tr>
                <tr>
                    <td><input type="file" name="fileName"></td>
                </tr>
                </tbody>
                <%
                    }
                %>
            </table>
            <input type="submit"  class="btn btn-primary pull-right" value="게시글 작성하기">
        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
</body>
</html>
