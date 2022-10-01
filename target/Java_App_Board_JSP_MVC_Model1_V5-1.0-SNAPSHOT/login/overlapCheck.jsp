<%@ page language="java" contentType="text/HTML; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>

<%
    String id = request.getParameter("id");
    PrintWriter outPrint = response.getWriter();

    int flag = 1;

    String str = "";

    if(id == null) {
        id = "";
    }

    BoardDAO boardDAO = new BoardDAO();

    flag = boardDAO.idCheck(id);
    if(flag == 0) {
        str = "YES";
    } else {
        str = "NO";
    }

    outPrint.print(str);
%>
