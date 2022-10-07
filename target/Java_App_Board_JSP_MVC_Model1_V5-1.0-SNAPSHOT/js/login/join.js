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