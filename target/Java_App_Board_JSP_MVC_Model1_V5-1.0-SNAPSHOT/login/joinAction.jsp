<!-- 회원가입 처리 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="id" />
<jsp:setProperty name="user" property="pw" />
<jsp:setProperty name="user" property="name" />
<jsp:setProperty name="user" property="birthdate" />
<jsp:setProperty name="user" property="sex" />
<jsp:setProperty name="user" property="phone" />
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP게시판 웹사이트</title>
</head>
<body>
<%
    String userID = null;
    // 로그인 된 사람은 회원가입페이지에 들어갈수 없다
    if(session.getAttribute("id") != null )
    {
        userID = (String) session.getAttribute("id");
    }
    if(userID != null)
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어있습니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }
    if(user.getId() == null || user.getPw() == null || user.getName() == null || user.getSex() == null || user.getPhone() == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안된 사항이 있습니다.')");
        script.println("history.back()");
        script.println("</script>");
    } else {
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(user);
        if(result == -1){
            PrintWriter script = response.getWriter(); //하나의 스크립트 문장을 넣을 수 있도록.
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디 입니다..')");
            script.println("history.back()");
            script.println("</script>");
        }
        else {
            session.setAttribute("id", user.getId());
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href= 'main.jsp'");
            script.println("</script>");
        }
    }
%>
</body>
</html>
