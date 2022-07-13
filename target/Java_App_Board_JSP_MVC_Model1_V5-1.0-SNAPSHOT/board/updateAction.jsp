<!-- 회원가입 처리 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;  charset=UTF-8">
    <title>JSP게시판 웹사이트</title>
</head>
<body>
<%
    String userID = null;
    // 로그인 된 사람은 회원가입페이지에 들어갈수 없다
    if(session.getAttribute("id") != null ) {
        userID = (String) session.getAttribute("id");
    }
    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = '../login/main.jsp'");
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
    Board board = new BoardDAO().getBoard(boardNo);
    if (!userID.equals(board.getName())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href = 'board.jsp'");
        script.println("</script>");
    } else {
        if (request.getParameter("title") == null || request.getParameter("content") == null
                || request.getParameter("title").equals("") || request.getParameter("content").equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            BoardDAO boardDAO = new BoardDAO();
            int result = boardDAO.update(boardNo, request.getParameter("title"), request.getParameter("content"));
            if (result == -1) {
                PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣을 수 있도록.
                script.println("<script>");
                script.println("alert('글 수정에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href= 'board.jsp'");
                script.println("</script>");
            }

        }
    }
%>
</body>
</html>
