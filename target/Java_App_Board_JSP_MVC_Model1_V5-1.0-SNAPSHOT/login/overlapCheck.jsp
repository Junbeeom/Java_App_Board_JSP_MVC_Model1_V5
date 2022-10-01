<%@ page language="java" contentType="text/HTML; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>

<%
    String id = request.getParameter("id");
    PrintWriter out2 = response.getWriter();

    int flag = 1;

    String str = "";

    if(id == null) {
        id = "";
    }

    System.out.println("여기는 overlap입니다" + id);
    BoardDAO boardDAO = new BoardDAO();

    flag = boardDAO.idCheck(id);
    System.out.println("이 값은 flag 입니다 " + flag);
    if(flag == 0) {
        str = "YES";
    } else {
        str = "NO";
    }

    out2.print(str);
%>
