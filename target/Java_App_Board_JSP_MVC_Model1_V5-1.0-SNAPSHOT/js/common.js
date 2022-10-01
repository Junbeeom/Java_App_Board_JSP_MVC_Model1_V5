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
            return false;
        } else {
            return true;
        }

        // 빈값 + 길이 체크
        if(COMMON.isEmpty1(value) || value.length > 15) {
            return false;
        } else {
            return true;
        }
    },

    setRemoveXss : (value) => {
        if(COMMON.isEmpty2(value)) {
            return value;
        } else if(typeof value == 'array') {
            value.forEach((value, index) => {
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
            return str.join('');
        } else {
            return false;
        }
    }
};



