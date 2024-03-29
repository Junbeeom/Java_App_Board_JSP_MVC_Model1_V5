# Java_App_Board_JSP_MVC_Model1_V5

# 1.프로젝트 개요
### 1.1 프로젝트 목적
- MVC1 pattern으로 JSP를 사용한 게시판 Application 개발

### 1.2 목표 및 의의
#### 1.2.1 Java_App_Board_JSP_MVC_Model1_V5
- MVC1 pattern의 이해 및 적용
- 모듈화를 통한 html 구조 이해
- Session에 대한 이해 및 적용
- 회원가입시 input값 유효성 검사
- 비동기 JavaScript ajax를 사용한 id 중복 check 구현
- 단방향 암호화인 SHA-512 알고리즘을 이용한 PassWord 암호화



# 2. 개발 환경
- IntelliJ IDEA(Ultimate Edition), GitHub


# 3. 사용기술
- Java 11, JavaScript, JSP, HTML 5


# 4.프로젝트 설계

### 4.1 로그인 (Login page) 
<img width="1105" alt="스크린샷 2022-10-01 오후 2 17 26" src="https://user-images.githubusercontent.com/103010985/193393815-cdd7b9c7-8e28-4c4d-9560-825448cf3730.png">

### 4.2 회원가입 (id 중복 확인)
<img width="1091" alt="스크린샷 2022-10-01 오후 2 38 47" src="https://user-images.githubusercontent.com/103010985/193394439-5743c283-91e8-4fb3-ade1-737113b86814.png">
<img width="1086" alt="스크린샷 2022-10-01 오후 2 39 04" src="https://user-images.githubusercontent.com/103010985/193394449-dc8d1b15-bd32-477a-aaea-37e3d397ecfd.png">


### 4.2 게시판 (board page) 
<img width="1099" alt="스크린샷 2022-10-01 오후 2 21 47" src="https://user-images.githubusercontent.com/103010985/193393947-92d5eb51-a4e1-4904-9c9f-40e80a7be1d5.png">

### 4.2 게시글 작성하기
<img width="1092" alt="스크린샷 2022-10-01 오후 2 23 57" src="https://user-images.githubusercontent.com/103010985/193394009-2fd1b4b4-cedd-46f7-87c5-2cf524ce9c24.png">

### 4.2.1 게시글 작성하기 (Session id 없을 시 게시글 작성 안됨, alert login message) 
<img width="542" alt="스크린샷 2022-10-01 오후 2 30 43" src="https://user-images.githubusercontent.com/103010985/193394182-8439483b-f640-48c6-b4af-136fcd537ca2.png">

### 4.3 게시글 상세 보기 (Session 확인해서 id 일치 하지 않을 시, 수정 및 삭제 buttom이 안뜸)
<img width="1094" alt="스크린샷 2022-10-01 오후 2 29 32" src="https://user-images.githubusercontent.com/103010985/193394151-1540539b-01fd-4583-965c-3bb9aecb7ffd.png">


### 4.3.1 게시글 상세 보기 (Session 확인해서 id 일치할 경우)
<img width="1091" alt="스크린샷 2022-10-01 오후 2 27 36" src="https://user-images.githubusercontent.com/103010985/193394092-83f37533-a8aa-421a-8a7d-b02fcb93d064.png">


### 4.4 검색하기
<img width="1097" alt="스크린샷 2022-10-01 오후 2 32 31" src="https://user-images.githubusercontent.com/103010985/193394253-8ac5b603-8f0b-4ac5-9f71-210b2574f8bd.png">

### 4.5 수정하기
<img width="1095" alt="스크린샷 2022-10-01 오후 2 37 12" src="https://user-images.githubusercontent.com/103010985/193394399-b37edeef-bede-4e00-a532-7c954c49bb8b.png">


### 4.5 board Package
<img width="461" alt="스크린샷 2022-10-07 오후 3 06 31" src="https://user-images.githubusercontent.com/103010985/194479085-6d3566b1-bf7b-4e4b-bf9c-85a2ea5bcf9d.png">


### 4.6 Common Package
<img width="234" alt="스크린샷 2022-10-07 오후 3 08 38" src="https://user-images.githubusercontent.com/103010985/194479356-432e77a6-c97b-42d2-a100-01e6f502a35a.png">


# 5.기본 기능
- 등록 registered 
- 조회 listed
- 검색 searched
- 수정 modified
- 삭제 deleted

### 5.1 기능 
- 로그인
- 회원가입


# 6.핵심 기능

### 6.1 로그인시 null 체크 : onclick 속성으로 이벤트를  event
<img width="1059" alt="스크린샷 2022-10-07 오후 3 18 22" src="https://user-images.githubusercontent.com/103010985/194480650-4edb8738-1b73-4f58-81fd-41873d4167d4.png">

```JavaScript     
document.addEventListener('DOMContentLoaded', () => {
    SIGN_IN.init();
});

const SIGN_IN = {
    init: () => {
        document.getElementById('btnSignIn').addEventListener('click', (event) => {
            event.preventDefault();

            SIGN_IN.validation();
        });
    },

    validation: () => {
        let id = document.querySelector('input[name="id"]').value;
        let pw = document.querySelector('input[name="pw"]').value;

        if(COMMON.isEmpty(id.trim())) {
            alert('ID EMPTY!');
            return false;
        }

        if(COMMON.isEmpty(pw.trim())) {
            alert('PW EMPTY!');
            return false;
        }

        document.querySelector('input[name="id"]').value = hex_sha512(id);

        document.getElementById('SignIn').submit();
    }
};
        
```

### 6.2 회원가입시 유효성 체크
```JavaScript
document.addEventListener('DOMContentLoaded', () => {
    SIGN_UP.init();
});

const SIGN_UP = {
    userId: '',

    init: () => {
        // 중복검사 버튼 이벤트
        document.getElementById('duplicate').addEventListener('click', () => {
            SIGN_UP.duplicate();
        });

        // 성별 버튼 이벤트
        document.querySelectorAll('[name="sex"]').forEach((btn) => {
            btn.addEventListener('click', (event) => {
                document.querySelectorAll('.btn-group label').forEach((temp) => {
                    temp.classList.remove('active');
                });

                event.target.closest('label').classList.add('active');
            })
        });

        // 회원가입 버튼 이벤트
        document.getElementById('signUp').addEventListener('click', (event) => {
            event.preventDefault();

            SIGN_UP.validation();
        });

        // 이전페이지로 버튼 이벤트
        document.getElementById('prev').addEventListener('click', () => {
            history.back();
        });
    },

    validation: () => {
        let id = document.querySelector('input[name="id"]');
        let duplicate = document.querySelector('input[name="hidDuplicate"]');
        let pw = document.querySelector('input[name="pw"]');
        let name = document.querySelector('input[name="name"]');
        let birthdate = document.querySelector('input[name="birthdate"]');
        let phone = document.querySelector('input[name="phone"]');

        if(duplicate.value == 'F' || COMMON.isEmpty(SIGN_UP.userId) || SIGN_UP.userId !== id) {
            alert('아이디 중복검사를 해주세요.');
            duplicate.focus();
            return false;
        }

        let idRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
        if(COMMON.isEmpty(id.value.trim()) || id.length > 30 || !idRegExp.test(id.value)) {
            alert("아이디를 확인해주세요.\n최대 30자까지 입력 가능합니다.")
            id.focus();
            return false;
        }

        //비밀번호 영문자+숫자+특수조합(8~25자리 입력) 정규식
        let pwRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
        if (COMMON.isEmpty(pw.value.trim()) || !pwRegExp.test(pw.value) || pw.value.length > 25) {
            alert("비밀번호를 확인해주세요.\n최대 25자까지 입력 가능합니다.");
            pw.focus();
            return false;
        }

        // 이름 정규표현식
        let nameRegExp = /^[ㄱ-ㅎ가-힣]+$/;
        if (COMMON.isEmpty(name.value) || !nameRegExp.test(name.value)) {
            alert("이름을 확인해주세요.");
            name.focus();
            return false;
        }

        // 생년월일 정규식
        let birthdateRegExp = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/
        if (COMMON.isEmpty(birthdate.value) || !birthdateRegExp.test(birthdate.value)) {
            alert("생년월일을 확인해주세요.");
            birthdate.focus();
            return false;
        }

        // 성별 체크
        let sexResult = false;
        let sex = document.querySelectorAll('input[name="sex"]');

        sex.forEach((btn) => {
            if(btn.checked) {
                sexResult = true;
            }
        });

        if(!sexResult) {
            alert('성별을 확인해주세요.');
            return false;
        }

        // 핸드폰 번호 정규식
        let phoneRegExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
        if (COMMON.isEmpty(phone.value) || !phoneRegExp.test(phone.value)) {
            alert("핸드폰 번호를 입력하세요");
            phone.focus();
            return false;
        }

        document.querySelector('input[name="id"]').value = hex_sha512(id.value);

        document.getElementById('frmJoin').submit();
    },

    duplicate: () => {
        let id = document.querySelector('input[name="id"]');
        let idRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
        if(COMMON.isEmpty(id.value.trim()) || id.value.length > 30 || !idRegExp.test(id.value)) {
            alert("아이디를 확인해주세요.\n최대 30자까지 입력 가능합니다.")
            id.focus();
            return false;
        }

        let cryptId = hex_sha512(id.value);

        fetch('./duplicate.jsp?id=' + cryptId, {
            method: 'GET',
            headers: {'Content-Type': 'text/html'},
        }).then((res) => {
            res.text().then((result) => {
                if(result.trim() == 'approve') {
                    SIGN_UP.userId = id.value;
                    document.getElementsByName('hidDuplicate').value = 'T';
                    document.getElementById('duplicateResult').innerHTML = `<b style="color:blue">사용가능한 아이디입니다.</b>`;
                } else {
                    SIGN_UP.userId = '';
                    document.getElementsByName('hidDuplicate').value = 'F';
                    document.getElementById('duplicateResult').innerHTML = `<b style="color:red">사용중인 아이디입니다.</b>`;
                }
            });
        }).catch((error) => {
            alert('중복확인 요청을 실패하였습니다.')
        })
    }
};
```


# 7.회고

### Java_App_Board_JSP_MVC_Model1_V5

1. 해당 프로젝트는 MVC Model1 디자인 패턴에 의거하였으며, MVC Model1과 Model2의 장단점을 직접 경험해보고자 진행한 프로젝트입니다. 또한 모듈화를 통해 유지보수에 용이성을 향상시켰습니다.
 
2. Session을 이용하여 로그인 시 Session에 정보를 저장하고 로그인이 필요한 페이지에 로그인을 하지 않은 상태로 접근하였을 경우 Login Page로 Redirect하도록 했습니다.

3. JSP에서는 Cross site script에 대한 방지가 되어 있지 않아 특정 문자를 html entity code로 변환하여 출력 할 수 있도록 하였으며, 이때 recursion 형태로 함수를 구현하여 array, object, String의 타입으로 매개변수를 전달하여도 동작 할 수 있도록 구현 하였습니다.

4. TOAST에서 안티 패턴이라는 글을 읽게 되었고 이벤트를 인라인 방식으로 바인딩 했을 때 유지보수에 좋지 않다는 내용을 보게 되어 DOMContentLoaded 이벤트를 활용하여 이벤트를 바인딩했습니다. 또한 HTML5 Semantic을 지키면서 원하는 동작을 할 수 있도록 submit Type의 버튼은 event 객체의 preventDefault 함수를 사용하였으며, 효율적인 유효성 검증을 하기 위해 공통 함수로 validation 함수를 구현하였습니다.

5.  공부한 Javascript를 보다 적극적으로 사용하고자 jQuery 라이브러리를 사용하지 않았으며, 비동기 통신을 위해 Fetch API를 이용했습니다. 또한 클라이언트 단과 서버 단에서 SHA256, 512 단방향 암호화를 적용하였으며, 메모리를 최소한으로 사용하고자 암호화 필드의 크기는 각 암호화 데이터 길이로 설계하였습니다.






