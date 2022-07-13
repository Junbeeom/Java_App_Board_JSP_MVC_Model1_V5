package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {

    private Connection conn;
    private ResultSet rs;

    public BoardDAO() {
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

    public String getDate() // 현재시간을 넣어주기위해
    {
        String SQL = "SELECT NOW()"; // 현재시간을 나타내는 mysql
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getString(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return ""; // 데이터베이스 오류
    }

    public int getNext()
    {
        String SQL = "SELECT board_no FROM board ORDER BY board_no DESC"; // 내림차순으로 가장 마지막에 쓰인 것을 가져온다
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1) + 1; // 그 다음 게시글의 번호
            }
            return 1; // 첫 번째 게시물인 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
    public int write(String title, String content, String name) {
        String SQL = "INSERT INTO board(title, content, name, is_deleted) VALUES (?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setString(3, name);
            pstmt.setInt(4, 0);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public ArrayList<Board> getList(int pageNumber)
    {
        String SQL = "SELECT * FROM board WHERE board_no < ? AND is_deleted = 0 ORDER BY board_no DESC LIMIT 10"; // 내림차순으로 가장 마지막에 쓰인 것을 가져온다
        ArrayList<Board> list = new ArrayList<Board>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Board board = new Board();
                board.setBoardNo(rs.getInt(1));
                board.setTitle(rs.getString(2));
                board.setContent(rs.getString(3));
                board.setName(rs.getString(4));
                board.setCreatedTs(rs.getString(5));
                board.setUpdatedTs(rs.getString(6));
                list.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //    페이징 처리를 위한 함수
    public boolean nextPage(int pageNumber) {
        String SQL = "SELECT * FROM board WHERE board_no < ? AND is_deleted = 0";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
            rs = pstmt.executeQuery();
            if (rs.next())
            {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Board getBoard(int board_no) {
        String SQL = "SELECT * FROM board WHERE board_no = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, board_no);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                Board board = new Board();
                board.setBoardNo(rs.getInt(1));
                board.setTitle(rs.getString(2));
                board.setContent(rs.getString(3));
                board.setName(rs.getString(4));
                board.setCreatedTs(rs.getString(5));
                board.setUpdatedTs(rs.getString(6));
                return board;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int update(int board_no, String title, String content) {
        String SQL = "UPDATE board SET title = ?, content = ?, updated_ts = CURRENT_TIMESTAMP() WHERE board_no = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setInt(3, board_no);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public int delete(int boardNo) {
        String SQL = "UPDATE board SET is_deleted = 1 WHERE board_no = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardNo);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
}