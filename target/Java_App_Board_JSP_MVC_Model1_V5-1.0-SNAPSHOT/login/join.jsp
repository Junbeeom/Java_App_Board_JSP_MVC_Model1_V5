<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
    <link rel="stylesheet" href="../css/bootstrap.css"> <!-- 참조  -->
    <title>JSP 게시판 웹 사이트</title>
    <script>
        const COMMON = {

            // 0은 허용하는 체크
            isNull : (value) => {
                if(value === 0 || value === '0') {
                    return false;
                } else if(value === true || value === false) {
                    return value;
                } else if(value != null && value != '' && (typeof value != 'undefined')) {
                    if ((typeof value.valueOf() == 'string' && value.length > 0) || (typeof value.valueOf() == 'number') || (typeof value.valueOf() == 'object') || (typeof value.valueOf() == 'function')) {
                        return false;
                    } else {
                        return true;
                    }
                } else {
                    return true;
                }
            },

            // 0도 허용하지 않는 체크
            isNull2 : (value) => {
                if(value === 0 || value === '0') {
                    return true;
                } else if(value === true || value === false) {
                    return value;
                } else if(value != null && value != '' && (typeof value != 'undefined')) {
                    if ((typeof value.valueOf() == 'string' && value.length > 0) || (typeof value.valueOf() == 'number') || (typeof value.valueOf() == 'object') || (typeof value.valueOf() == 'function')) {
                        return false;
                    } else {
                        return true;
                    }
                } else {
                    return true;
                }
            },


            setRemoveXss : (value) => {
                if(COMMON.isEmpty2(value)) {
                    // 비어있기 때문에 그대로 리턴
                    return value;
                } else if(typeof value == 'array') {
                    value.forEach((value, index) => {
                        // 재귀
                        value[index] = COMMON.setRemoveXss(value);
                    });
                } else if(typeof value == 'object') {
                    for(let key in Object.keys(value)) {
                        value[key] = COMMON.setRemoveXss(value[key]);
                    }
                } else {
                    value = COMMON.removeXss(value);
                }

                return value;
            },

            removeXss : (value) => {
                const str = [];
                const regExp = /[ <>&"']/g;
                if(regExp.test(value)) {
                    // 문자열 반복
                    value.split('').forEach((char) => {
                        if(char == ' ') {
                            str.push('&nbsp;');
                        } else if(char == '<') {
                            str.push('&lt;');
                        } else if(char == '>') {
                            str.push('&gt;');
                        } else if(char == '&') {
                            str.push('&amp;');
                        } else if(char == '"') {
                            str.push('&quot;');
                        } else {
                            str.push('&apos;');
                        }
                    });

                    // concat()이 더 효율성이 좋지만 이미 String의 길이만큼 반복하기에
                    // concat()을 사용하기에는 효율성이 애매해지므로 join() 사용
                    return str.join('');
                } else {
                    return false;
                }
            }
        };
    </script>
</head>
<body>
<nav class ="navbar navbar-default">
    <div class="navbar-header"> <!-- 홈페이지의 로고 -->
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
            <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
            <span class ="icon-bar"></span>
            <span class ="icon-bar"></span>
        </button>
        <a class ="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="main.jsp">메인</a></li>
            <li><a href="../board/board.jsp">게시판</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                   data-toggle="dropdown" role ="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="login.jsp">로그인</a></li>
                    <li class="active"><a href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="col-lg-4"></div>
    <div class="col-lg-4">
        <div class ="jumbotron" style="padding-top:20px;">
           <!-- <form method = "post" action="joinAction.jsp"> -->
            <form method="post" action="joinAction.jsp" onsubmit="return joinform_check();">
               <h3 style="text-align:center;">회원가입 화면</h3>
               <div class ="form-group">
                   <input type ="email" class="form-control is-valid" placeholder="@naver.com"  name ="id">
                   <button type ="button" class="id_overlap_button" id = "btn" onclick="id_overlap_check()">중복검사</button>
                   <span id="idchk"></span>
               </div>
               <div class ="form-group">
                   <input type ="password" class="form-control" placeholder="비밀번호" name ="pw" maxlength='30'>
               </div>
               <div class ="form-group">
                   <input type ="text" class="form-control" placeholder="이름" name ="name" maxlength='10'>
               </div>
               <div class ="form-group">
                   <input type ="text" class="form-control" placeholder="생년원일" name ="birthdate" maxlength='30'>
               </div>
               <div class ="form-group" style="text-align: center;">
                   <div class="btn-group" data-toggle="buttons">
                       <label class="btn btn-primary active">
                           <input type="radio" name="sex" autocomplete="off" value="남자" checked>남자
                       </label>
                       <label class="btn btn-primary">
                           <input type="radio" name="sex" autocomplete="off" value="여자" checked>여자
                       </label>
                   </div>
               </div>
               <div class ="form-group">
                   <input type ="text" class="form-control" placeholder="핸드폰" name ="phone" maxlength='15'>
               </div>
               <input type="submit" class="btn btn-primary form-control" value="회원가입">
               <button type="button" class="btn btn-primary form-control" onclick="history.back();">이전페이지로</button>
               <!--<button type="button" class="btn btn-primary form-control" onclick="joinform_check();">가입하기</button>-->
            </form>
        </div>
    </div>
    <div class="col-lg-4"></div>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script>

    function joinform_check() {

        let id = document.querySelector('[name="id"]');
        var pw = document.querySelector('[name="pw"]');
        var name = document.querySelector('[name="name"]')
        var birthdate = document.querySelector('[name="birthdate"]');
        var phone = document.querySelector('[name="phone"]');

        if(COMMON.isNull(id.value)) {
            alert("아이디를 입력하세요")
            return false;
        }

        var idCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
        if (!idCheck.test(id.value)) {
            alert("이메일 형식으로 입력하세요. ex)test@naver.com");
            return false;
        }

        if (COMMON.isNull(pw.value)) {
            alert("비밀번호를 입력하세요.");
            return false;
        }

        //비밀번호 영문자+숫자+특수조합(8~25자리 입력) 정규식
        var pwCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;

        if (!pwCheck.test(pw.value)) {
            alert("비밀번호는 영문자+숫자+특수문자 조합으로 8~25자리 사용해야 합니다.");
            pw.focus();
            return false;
        }

        if (COMMON.isNull(name.value)) {
            alert("이름을 입력하세요")
            return false;
        }

        //이름 정규식
        var nameCheck = /^[ㄱ-ㅎ가-힣]+$/;

        if (!nameCheck.test(name.value)) {
            alert("이름 작성은 한글로만 가능합니다")
            return false;
        }

        if (COMMON.isNull(birthdate.value)) {
            alert("생년월일을 입력하세요")
            return false;
        }

        //생년월일 정규식
        var birthdateCheck = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/

        if (!birthdateCheck.test(birthdate.value)) {
            alert("ex) 1995-05-31")
            return false;
        }

        if (COMMON.isNull(phone.value)) {
            alert("핸드폰 번호를 입력하세요")
            return false;
        }

        //핸드폰 번호 정규식
        var phoneCheck = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;

        if(!phoneCheck.test(phone.value)) {
            alert("ex) 01011112234")
            return false;
        }
    }

    $('#btn').click(function () {
        let id = $("#id").val();
        window.alert("click");
        // 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기

        $.ajax({
            type: "GET",
            url: 'overlapCheck.jsp?id=' + id,

            success: function (res) {
                console.log($.trim(res));
                let a = $.trim(res);

                if(a === 'YES') {
                    alert("사용 가능한 아이디입니다.")
                    $('#idchk').html('<b style="font-size:18px;color:blue">사용가능.</b>');
                } else {
                    alert("중복된 아이디입니다.")
                    $('#idchk').html('<b style="font-size:18px;color:red">사용불가.</b>');
                }
            },
            error: function (error) {
                console.log(JSON.stringify(error));
            }
        });
    });


</script>
</body>
</html>