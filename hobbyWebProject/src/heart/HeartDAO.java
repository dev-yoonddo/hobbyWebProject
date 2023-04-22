package heart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import board.BoardDTO;
import comment.CommentDTO;

public class HeartDAO {
   private Connection conn;//데이터베이스에 접근하게 해주는 하나의 객체
   private ResultSet rs;//정보를 담을 수 있는 객체
   
   public HeartDAO() {//mysql에 접속을 하게 해줌,자동으로 데이터베이스 커넥션이 일어남
	   try {//예외처리
			String dbURL = "jdbc:mysql://localhost:3306/hobbywebproject?useUnicode=true&characterEncoding=UTF-8";
			String dbID="root";
			String dbPassword="9228";
			Class.forName("com.mysql.jdbc.Driver");//mysql드라이버를 찾는다.
			//드라이버는 mysql에 접속할 수 있도록 매개체 역할을 하는 하나의 라이브러리
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
   }
   
   public int heart(String userID, int boardID) {
      String SQL = "INSERT INTO heart VALUES (?, ?)";
      try {
         PreparedStatement pstmt = conn.prepareStatement(SQL);
         pstmt.setString(1, userID);
         pstmt.setInt(2, boardID);
         return pstmt.executeUpdate();
      } catch(Exception e) {
         e.printStackTrace();
      }
   return -1;//추천 중복 오류
 }

   public HeartDTO getHeartVO(int boardID) {
		String SQL = "SELECT * FROM heart WHERE boardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				HeartDTO heart = new HeartDTO();
				heart.setUserID(rs.getString(1));
				heart.setBoardID(rs.getInt(2));
				
				return heart;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
   
   
   
   public ArrayList<HeartDTO> getHeartList(int boardID){
		String SQL = "SELECT * FROM heart WHERE boardID = ? AND userID IS NOT NULL"; 
		ArrayList<HeartDTO> hearts = new ArrayList<HeartDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HeartDTO heart = new HeartDTO();
				heart.setBoardID(rs.getInt(2));
				heart.setUserID(rs.getString(1));
				hearts.add(heart);
			}
			rs.close();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } 
	    return hearts;
	}
}