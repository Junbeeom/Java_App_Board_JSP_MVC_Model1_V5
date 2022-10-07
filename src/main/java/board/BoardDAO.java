package board;

import java.sql.*;
import java.util.ArrayList;

public class BoardDAO {
    private Connection conn;
    private ResultSet rs;
    private PreparedStatement pstmt;

    public BoardDAO() {
        try {
            String dbUrl = "jdbc:mysql://localhost:3306/Board";
            String dbId = "root";
            String dbPasswowrd = "26905031";
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(dbUrl, dbId, dbPasswowrd);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public int write(String title, String content, String name) throws SQLException {
        String SQL = "INSERT INTO boardtest(title, content, name, is_deleted) VALUES (?,?,?,?)";

        try {
            pstmt = conn.prepareStatement(SQL);

            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setString(3, name);
            pstmt.setInt(4, 0);

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

    public ArrayList<Board> findAll() throws SQLException {
        ArrayList<Board> boardFindAll = new ArrayList<Board>();

        String SQL = "SELECT * FROM boardtest WHERE is_deleted = 0 ORDER BY created_ts DESC";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                Board board = new Board();
                board.setBoardNo(rs.getInt("board_no"));
                board.setTitle(rs.getString("title"));
                board.setContent(rs.getString("content"));
                board.setName(rs.getString("name"));
                board.setCreatedTs(rs.getString("created_ts"));
                board.setUpdatedTs(rs.getString("updated_ts"));

                boardFindAll.add(board);
            }

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

        return boardFindAll;
    }

    public Board findByNo(int boardNo) throws SQLException {
        String SQL = "SELECT * FROM boardtest WHERE board_no = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardNo);
            rs = pstmt.executeQuery();

            if(rs.next()) {
                Board board = new Board();
                board.setBoardNo(rs.getInt("board_no"));
                board.setTitle(rs.getString("title"));
                board.setContent(rs.getString("content"));
                board.setName(rs.getString("name"));
                board.setCreatedTs(rs.getString("created_ts"));
                board.setUpdatedTs(rs.getString("updated_ts"));

                return board;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public int update(int board_no, String title, String content) throws SQLException {
        String SQL = "UPDATE boardtest SET title = ?, content = ?, updated_ts = CURRENT_TIMESTAMP() WHERE board_no = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setInt(3, board_no);

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
        return -1;
    }

    public int delete(int boardNo) throws SQLException{
        String SQL = "UPDATE boardtest SET is_deleted = 1 WHERE board_no = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardNo);
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
        return -1;
    }

    public ArrayList<Board> search(String type, String searchValue) throws SQLException{
        ArrayList<Board> searchBoard = new ArrayList<Board>();

        String SQL = "select * from boardtest WHERE is_deleted = 0 ";

        if(type.equals("total")) {
            SQL += " ORDER BY created_ts DESC";
        } else if(type.equals("title")) {
            SQL += " AND title like ? ORDER BY created_ts DESC";
        } else if(type.equals("content")) {
            SQL += " AND content like ? ORDER BY created_ts DESC";
        } else {
            SQL += " AND name like ? ORDER BY created_ts DESC";
        }

        try {
            if(type.equals("total")) {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                rs = pstmt.executeQuery();

            } else {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, searchValue);
                rs = pstmt.executeQuery();
            }

            while(rs.next()) {
                Board board = new Board();
                board.setBoardNo(rs.getInt("board_no"));
                board.setTitle(rs.getString("title"));
                board.setContent(rs.getString("content"));
                board.setName(rs.getString("name"));
                board.setCreatedTs(rs.getString("created_ts"));
                board.setUpdatedTs(rs.getString("updated_ts"));

                searchBoard.add(board);
            }

        } catch(Exception e ) {
            e.printStackTrace();
        } finally {
            if(pstmt != null) {
                pstmt.close();
            }
            if(conn != null) {
                conn.close();
            }
        }
        return searchBoard;
    }
}
