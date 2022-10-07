<%@ page language="java" contentType="text/HTML; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>

<%
    PrintWriter writer = response.getWriter();
    UserDAO userDAO = new UserDAO();
    System.out.println("duplicate.jsp 진입");
    String id = request.getParameter("id");

    if(userDAO.duplicate(id)) {
        writer.println("approve");
    } else {
        writer.println("duplicate");
    }
%>