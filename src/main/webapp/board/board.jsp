<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="board.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="board.Board" %>
<%@ page import="common.Common" %>

<!DOCTYPE html>
<html>
<jsp:include page="../common/head.jsp"/>
<body>
<jsp:include page="../common/navLogin.jsp"/>
<form id="searchForm" action="./board.jsp" method="get" onsubmit="return searchBoard();">
    <div class="container">
        <div class="row">
            <div class="col-md-2">
                <select name = "searchType" id = "searchType"  class="form-select form-select-lg mb-3" style="width:120px;height:120px;" >
                    <option id="total" name="total" value="total" selected>전체</option>
                    <option id="title" name="title" value="title">제목</option>
                    <option id="content" name="content" value="content">내용</option>
                    <option id="name" name="name" value="name">작성자</option>
                </select>
            </div>
            <div class="col-md-9">
                <input type="text" name = "searchKeyword" class="form-control" placeholder="키워드를 입력하세요." aria-label="Recipient's username" aria-describedby="button-addon2" maxlength='20'>
            </div>
            <div class="col-md-1"><button class="btn btn-outline-secondary" type="submit" id="button-addon2">검색</button>
            </div>
        </div>
    </div>
</form>
</br>
<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color:#eeeeee; text-align:center;">번호</th>
                <th style="background-color:#eeeeee; text-align:center;">제목</th>
                <th style="background-color:#eeeeee; text-align:center;">작성자</th>
                <th style="background-color:#eeeeee; text-align:center;">등록일시</th>
                <th style="background-color:#eeeeee; text-align:center;">수정일시</th>
            </tr>
            </thead>
            <tbody>
            <%
                BoardDAO boardDAO = new BoardDAO();
                Common common = new Common();
                ArrayList<Board> list = new ArrayList<Board>();

                if(request.getParameter("searchKeyword") != null ) {
                    String searchKeyword = "%" +  request.getParameter("searchKeyword") + "%";

                    list = boardDAO.search(request.getParameter("searchType"), searchKeyword);

                } if(request.getParameter("searchKeyword") == null) {
                    list = boardDAO.findAll();
                }



                for(int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%=list.get(i).getBoardNo() %></td>
                <td><a href="view.jsp?boardNo=<%=list.get(i).getBoardNo()%>"><%=common.xss(list.get(i).getTitle())%></a></td>
                <td><%=list.get(i).getName() %></td>
                <td><%=list.get(i).getCreatedTs() %></td>
                <td><%=list.get(i).getUpdatedTs()%></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
</body>
</html>
