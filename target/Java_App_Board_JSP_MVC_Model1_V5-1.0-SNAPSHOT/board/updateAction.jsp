<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>

<% request.setCharacterEncoding("UTF-8"); %>
<%
    String userID = null;
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
    } else {
        if(request.getParameter("title") == null || request.getParameter("content") == null
            || request.getParameter("title").equals("") || request.getParameter("content").equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            int result = boardDAO.update(boardNo, request.getParameter("title"), request.getParameter("content"));
            if(result == -1) {
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
