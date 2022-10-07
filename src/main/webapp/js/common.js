const COMMON = {
    // 0은 허용하는 체크
    isEmpty : (value) => {
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
    isEmptyZero : (value) => {
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

    // XSS 방지
    setRemoveXss : (value) => {
        if(COMMON.isEmpty(value)) {
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



