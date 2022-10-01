<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="board.Board" %>
<%@ page import="common.Common" %>

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
    ResultSet resultSet =  null;
    Board board = new Board();
    BoardDAO boardDAO = new BoardDAO();
    Common common = new Common();

    board = boardDAO.findByNo(boardNo);
//    resultSet = boardDAO.getBoard(boardNo);
%>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
            <thead>
            <tr>
                <th colspan="3" style="background-color:#eeeeee; text-align:center;">게시판 글 보기</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="width:20%;">글 제목</td>
                <!-- XSS 방지 -->
                <td colspan="2"><%=common.xss(board.getTitle())%></td>
            </tr>
            <tr>
                <td>작성자</td>
                <td colspan="2"><%=common.xss(board.getName())%></td>
            </tr>
            <tr>
                <td>작성일자</td>
                <td colspan="2"><%= board.getCreatedTs()%></td>
            </tr>
            <tr>
                <td>내용</td>
                <td colspan="2" style="min-height:200px; text-align:left;"><%=common.xss(board.getContent())%></td>
            </tr>
            </tbody>
        </table>
        <a href="board.jsp" class="btn btn-primary">목록</a>
        <%
            if(userID != null && userID.equals(board.getName())) {
        %>
        <a href="update.jsp?boardNo=<%=boardNo %>" class="btn btn-primary">수정</a>
        <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?boardNo=<%=boardNo %>" class="btn btn-primary">삭제</a>
        <%
            }
        %>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
</body>
</html>
