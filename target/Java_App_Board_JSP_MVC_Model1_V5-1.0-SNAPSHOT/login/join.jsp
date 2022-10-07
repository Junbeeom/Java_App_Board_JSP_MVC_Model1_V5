<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="../common/head.jsp"/>

<jsp:include page="../common/nav.jsp"/>
    <div class="container">
        <div class="col-lg-4">
            <div class ="jumbotron" style="padding-top:20px;">
                <form id="frmJoin" method="post" action="joinAction.jsp">
                   <h3 style="text-align:center;">회원가입 화면</h3>
                   <div class ="form-group">
                       <input type="email" class="form-control is-valid" placeholder="@naver.com" id="id" name ="id" maxlength="30">
                       <button type="button" id="duplicate">중복검사</button>
                       <input type="hidden" name="hidDuplicate" value="">
                       <span id="duplicateResult"></span>
                   </div>
                   <div class ="form-group">
                       <input type="password" class="form-control" placeholder="비밀번호" name="pw" maxlength='25'>
                   </div>
                   <div class ="form-group">
                       <input type="text" class="form-control" placeholder="이름" name="name" maxlength='10'>
                   </div>
                   <div class ="form-group">
                       <input type="text" class="form-control" placeholder="생년원일" name="birthdate" maxlength='30'>
                   </div>
                   <div class ="form-group" style="text-align: center;">
                       <div class="btn-group" data-toggle="buttons" id="sex">
                           <label class="btn btn-primary">
                               <input type="radio" name="sex" autocomplete="off" value="male">남자
                           </label>
                           <label class="btn btn-primary">
                               <input type="radio" name="sex" autocomplete="off" value="female">여자
                           </label>
                       </div>
                   </div>
                   <div class="form-group">
                       <input type="text" class="form-control" placeholder="핸드폰" name="phone" maxlength='15'>
                   </div>
                   <button type="submit" class="btn btn-primary form-control" id="signUp">회원가입</button>
                   <button type="button" class="btn btn-primary form-control" id="prev">이전페이지로</button>
                </form>
            </div>
        </div>
    </div>
    <script src="../js/login/join.js"></script>
<jsp:include page="../common/footer.jsp"/>