<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="id" />
<jsp:setProperty name="user" property="pw" />

<%
    String userID = null;
    if(session.getAttribute("id") != null ) {
        userID = (String) session.getAttribute("pw");
    }
    if(userID != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어있습니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }
    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(user.getId(), user.getPw());
    if(result == 1){
        session.setAttribute("id", user.getId());

        response.sendRedirect("./main.jsp");
    }
    else if(result == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 아이디입니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result == -2){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('DB 오류가 발생했습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
