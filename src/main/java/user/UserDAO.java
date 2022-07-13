package user;

import java.io.StringReader;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO() {
        try {
            String dbUrl = "jdbc:mysql://localhost:3306/Board";
            String dbId = "root";
            String dbPasswowrd = "26905031";

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbId, dbPasswowrd);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userId, String userPassword) {
        String SQL = "SELECT pw FROM user WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                if(rs.getString(1).equals(userPassword)) {
                    return 1;//로그인 성공
                } else {
                    return 0;//비밀번호 불일치
                }
            }
            return -1; //아이디 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2;//데이터베이스 오류
    }

    public int join(User user) {
        String SQL = "INSERT INTO user(id, pw, name, birthdate, sex, phone) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date(formatter.parse(user.getBirthdate()).getTime());

            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getId());
            pstmt.setString(2, user.getPw());
            pstmt.setString(3, user.getName());
            pstmt.setDate(4, date);
            pstmt.setString(5, user.getSex());
            pstmt.setString(6, user.getPhone());

            return pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }



}
