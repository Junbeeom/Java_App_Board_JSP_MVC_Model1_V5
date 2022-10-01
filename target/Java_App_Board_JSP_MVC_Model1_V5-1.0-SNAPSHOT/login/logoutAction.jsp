<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<jsp:include page="../common/head.jsp"/>
<body>
<%
    session.invalidate(); /* 이 페이지에 접속하면 session을 빼앗김 */
%>
<script>
    location.href = 'main.jsp';
</script>
</body>
</html>