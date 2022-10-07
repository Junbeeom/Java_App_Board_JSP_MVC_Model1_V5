<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="../common/head.jsp"/>

<jsp:include page="../common/nav.jsp"/>
    <div class="container">
        <div class="col-lg-4">
            <div class ="jumbotron" style="padding-top:20px;">
                <form id="SignIn" method="post" action="loginAction.jsp">
                    <h3 style="text-align:center;">로그인 화면</h3>
                    <div class ="form-group">
                        <input type ="text" class="form-control" placeholder="아이디" name="id" maxlength='20'>
                    </div>
                    <div class ="form-group">
                        <input type ="password" class="form-control" placeholder="비밀번호" name="pw" maxlength='20'>
                    </div>
                    <input type="submit" class="btn btn-primary form-control" id="btnSignIn" value="로그인">
                </form>
            </div>
        </div>
    </div>
    <script src="../js/login/in.js"></script>
<jsp:include page="../common/footer.jsp"/>
