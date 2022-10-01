<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>

<!DOCTYPE html>
<html>
<jsp:include page="../common/head.jsp"/>
<body>
<jsp:include page="../common/navLogin.jsp"/>
<%
    String userID = null;
    if(session.getAttribute("id") != null) {
        userID = (String)session.getAttribute("id");
    }
    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = '../login/login.jsp'");
        script.println("</script>");
    }

    int boardNo = 0;
    if(request.getParameter("boardNo") != null) {
        boardNo = Integer.parseInt(request.getParameter("boardNo"));
    }
    if(boardNo == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href = 'board.jsp'");
        script.println("</script>");
    }
    BoardDAO boardDAO = new BoardDAO();
    Board byNo = boardDAO.findByNo(boardNo);
    if(!userID.equals(byNo.getName())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href = 'board.jsp'");
        script.println("</script>");
    }
%>
<div class="container">
    <div class="row">
        <form id="updateForm" name="updateForm" method="post" action="updateAction.jsp?boardNo=<%= boardNo %>">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                <tr>
                    <th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글 수정 양식</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><input type="text" class="form-control" placeholder="글 제목" id="title" name="title" maxlength="50" value="<%=byNo.getTitle()%>" ></td>
                </tr>
                <tr>
                    <td><textarea class="form-control" placeholder="글 내용" id="content" name="content" maxlength="2048" style="height:350px" ><%=byNo.getContent()%></textarea></td>
                </tr>
                </tbody>
            </table>
            <input type="submit"  class="btn btn-primary pull-right" value="수정하기">
        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
</body>
</html>
