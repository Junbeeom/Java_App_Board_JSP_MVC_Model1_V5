package user;

import common.Common;

import java.io.StringReader;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private Common common;

    public UserDAO() {
        try {
            String dbUrl = "jdbc:mysql://localhost:3306/Board";
            String dbId = "root";
            String dbPasswowrd = "26905031";
            Class.forName("com.mysql.cj.jdbc.Driver");

            common = new Common();

            conn = DriverManager.getConnection(dbUrl, dbId, dbPasswowrd);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userId, String userPassword) throws SQLException{
        String SQL = "SELECT pw FROM member WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                if(rs.getString(1).equals(common.SHA256Encrypt(userPassword))) {
                    //로그인 성공
                    return 1;
                } else {
                    //비밀번호 불일치
                    return 0;
                }
            }
            //아이디 없음
            return -1;
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if(pstmt != null) {
                pstmt.close();
            }
            if(conn != null) {
                conn.close();
            }
        }
        //데이터베이스 오류
        return -2;
    }

    public int join(User user) throws SQLException{

        String SQL = "INSERT INTO member(id, pw, name, birthdate, sex, phone) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date(formatter.parse(user.getBirthdate()).getTime());

            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getId());
            pstmt.setString(2, common.SHA256Encrypt(user.getPw()));
            pstmt.setString(3, user.getName());
            pstmt.setDate(4, date);
            pstmt.setString(5, user.getSex());
            pstmt.setString(6, user.getPhone());

            return pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if(pstmt != null) {
                pstmt.close();
            }
            if(conn != null) {
                conn.close();
            }
        }
        // 데이터베이스 오류
        return -1;
    }

    // 아이디 중복 체크
    public boolean duplicate(String id) throws SQLException {
        String SQL = "SELECT id FROM member WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            while(!rs.next()) {
                //중복된 아이디가 없으면 true
                return true;
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) { rs.close(); }
            if(pstmt != null) { pstmt.close(); }
            if(conn != null) { conn.close(); }
        }

        // 중복된 아이디가 있으면 false
        return false;
    }
}
