package heart;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class HeartDAO {
   private Connection conn;//데이터베이스에 접근하게 해주는 하나의 객체
   private ResultSet rs;//정보를 담을 수 있는 객체
   
   public HeartDAO() {//mysql에 접속을 하게 해줌,자동으로 데이터베이스 커넥션이 일어남
	   try {
		 	String dbURL = "jdbc:mysql://database-1.cxujakzvpvip.ap-southeast-2.rds.amazonaws.com:3306/hobbyWebProject?useUnicode=true&characterEncoding=UTF-8";
		 	String dbID = "root";
		 	String dbPassword = "qlalf9228?";
		 	Class.forName("com.mysql.jdbc.Driver");
		 	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	} catch (Exception e) {
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
		 return -1;//데이터베이스 오류
   }	
   public int delete(String userID, int boardID) {
	   String SQL = "DELETE FROM heart WHERE userID = ? AND boardID = ?";
	      try {
	         PreparedStatement pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);
	         pstmt.setInt(2, boardID);
	         return pstmt.executeUpdate();
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
			 return -1;//데이터베이스 오류
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
   public HeartDTO getHeartVOByUser(String userID, int boardID) {
		String SQL = "SELECT * FROM heart WHERE userID = ? AND boardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, boardID);
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
		String SQL = "SELECT * FROM heart WHERE boardID = ? AND userID IS NOT NULL"; //boardID가 일치하고 userID가 null이 아닌 heart의 리스트를 가져온다
		ArrayList<HeartDTO> hearts = new ArrayList<HeartDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HeartDTO heart = new HeartDTO();
				heart.setUserID(rs.getString(1));//heart메서드와 동일한 순서로 넣어야 정상적인 결과가 나온다.
				heart.setBoardID(rs.getInt(2));
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