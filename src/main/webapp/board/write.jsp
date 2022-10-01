<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<jsp:include page="../common/head.jsp"/>
<body>
<jsp:include page="../common/navLogin.jsp"/>
    <div class="container">
        <div class="row">
            <form method="post" action="writeAction.jsp">
                <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                    <thead>
                        <tr>
                            <th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글쓰기 양식</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="text" class="form-control" placeholder="글 제목"  name="title" maxlength="50" ></td>
                        </tr>
                        <tr>
                            <td><textarea class="form-control" placeholder="글 내용"  name="content" maxlength="2048" style="height:350px" ></textarea></td>
                        </tr>
                        <tr>
                            <td><input type="file" name="fileName"></td>
                        </tr>
                    </tbody>
                </table>
                <input type="submit"  class="btn btn-primary pull-right" value="게시글 작성하기">
            </form>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
</html>
