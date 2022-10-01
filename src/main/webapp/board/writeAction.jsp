<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<% request.setCharacterEncoding("UTF-8"); %>

<%
    String userID = null;
    // 로그인 된 사람은 회원가입페이지에 들어갈수 없다.
    if(session.getAttribute("id") != null ) {
        userID = (String) session.getAttribute("id");
    }

    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href = '../login/main.jsp'");
        script.println("</script>");
    } else {
        if (request.getParameter("title") == null || request.getParameter("content")== null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            BoardDAO boardDAO = new BoardDAO();
            int result = boardDAO.write(request.getParameter("title"),request.getParameter("content"), userID);
            if(result == -1) {
                //하나의 스크립트 문장을 넣을 수 있도록.
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글쓰기에 실패했습니다.')");
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
