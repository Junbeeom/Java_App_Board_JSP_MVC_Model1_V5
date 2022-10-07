package common;

import com.mysql.cj.x.protobuf.MysqlxExpr;

import java.lang.reflect.Method;
import java.security.MessageDigest;

public class Common {
    public static final String USER_ID = "id";
    public static final String USER_PW = "pw";
    public static final String USER_NAME = "name";
    public static final String USER_BIRTHDATE = "birhdate";
    public static final String USER_PHONE = "phone";

    public static final String BOARD_NAME = "name";
    public static final String BOARD_TITLE = "title";
    public static final String BOARD_CONTENT = "content";

    public int userValidation(String type, String value) {
        switch(type) {
            case USER_ID :
                //이메일 형식 정규식
                String id = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";

                if(!(value.matches(id))) {
                    return 0;
                }
                break;

            case USER_PW :
                //영문자+숫자+특수조합(8~25자리 입력)
                String pw = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$";

                if(!(value.matches(pw))) {
                    return 0;
                }
                break;

            case USER_NAME :
                //이름 유효성 체크
                String name = "^[ㄱ-ㅎ가-힣]+$";

                if (!(value.matches(name))) {
                    return 0;
                }
                break;

            case USER_BIRTHDATE :
                //생년월일 유효성 체크
                String birthdate = "^(19[0-9][0-9]|20\\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$";

                if(!value.matches(birthdate)) {
                    return 0;
                }
                break;

            case USER_PHONE :
                String phone = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$";

                if(!value.matches(phone)) {
                    return 0;
                }
                break;
            default :
                break;

        }
        return 1;
    }

    public int boardValidation(String type, String value) {
        switch(type) {
            case BOARD_NAME:
                //이름 유효성 체크
                String isKoreanCheck = "^[가-힣]*$";
                String isAlaphaCheck = "^[a-zA-Z]*$";

                if(!(value.matches(isKoreanCheck) || value.matches(isAlaphaCheck))) {
                    return 0;
                }

            case BOARD_TITLE:
                //제목 유효성 체크
                if(value.length() >= 12) {
                    return 0;
                }

            case BOARD_CONTENT:
                //내용 유효성 체크
                if(value.length() >= 200) {
                    return 0;
                }
            default:
                break;
        }

        return 1;

    }


/*
    해당 메소드는 다양한 타입의 빈 값을 체크할 수 있는 메소드이다.
 */
    //0을 허용하는 체크
    class isEmpty<T> {
        public boolean isEmptyValue(T value) {
            if(value.equals(0) || value.equals('0')) {
                return false;
            } else if(value.equals(true) || value.equals(false)) {
                return (boolean) value;
            } else if(value != null && value.equals(' ') == false) {
                if((value instanceof String && ((String) value).length() > 0) || (value instanceof Number) || (value instanceof Method)) {
                    return false;
                } else {
                    return true;
                }
            } else {
                return true;
            }
        }

        //0도 허용하지 않는 체크
        public boolean isEmptyValue2(T value) {
            if(value.equals(0) || value.equals('0')) {
                return true;
            } else if(value.equals(true) || value.equals(false)) {
                return(boolean) value;
            } else if(value != null && value.equals(' ') == false) {
                if((value instanceof String && ((String) value).length() > 0) || (value instanceof Number)  || (value instanceof Method)) {
                    return false;
                } else {
                    return true;
                }
            } else {
                return true;
            }
        }
    }

    // 암호화 함수
    public String SHA256Encrypt(String password){
        StringBuffer hexString = new StringBuffer();

        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes("UTF-8"));

            for(int i=0; i < hash.length; i++){
                String hex = Integer.toHexString(0xff & hash[i]);

                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return hexString.toString().toUpperCase();
    }

    public String xss(String value) {
        value = value.replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>");

        return  value;
    }
}
