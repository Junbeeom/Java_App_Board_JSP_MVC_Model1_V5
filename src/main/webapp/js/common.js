// 객체 리터럴
// 장점 : 흔한 네이밍이어도 중복을 피할 수 있다.
const COMMON = {
    // 최소 체크
    // true인 경우 빈값
    isEmpty1 : (value) => {
        if(value.trim() === '' || value === undefined || value === null) {
            return true;
        }

        return false;
    },

    // 0은 허용하는 체크
    isEmpty2 : (value) => {
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
    isEmpty3 : (value) => {
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

    validation : (value) => {
        // 단순 빈값만 체크할 경우
        if(COMMON.isEmpty1(value)) {
            // 제목인 경우
            // alert('제목을 확인해주세요.');
            return false;
        } else {
            // true를 return 해줌으로써 다음 로직 실행 가능하도록
            return true;
        }

        // 빈값 + 길이 체크
        if(COMMON.isEmpty1(value) || value.length > 15) {
            // 제목인 경우, 항상 사용자 관점에서 알려줄 수 있도록(편의성)
            // alert('제목을 확인해주세요.\n제목은 15자까지 입력 가능합니다.');
            return false;
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
    //array = [0,1,2]

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



