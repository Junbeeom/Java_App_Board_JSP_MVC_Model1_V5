<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("id") == null) {
        response.sendRedirect("../login/login.jsp");
    }
%>

<jsp:include page="../common/head.jsp"/>
<jsp:include page="../common/nav.jsp"/>

<jsp:include page="../common/footer.jsp"/>




