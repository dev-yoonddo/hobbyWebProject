package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		
		public UserDAO() {
			try {
			 	String dbURL = "jdbc:mysql://localhost:3306/hobbywebproject?serverTimezone=UTC";
			 	String dbID = "root";
			 	String dbPassword = "9228";
			 	Class.forName("com.mysql.jdbc.Driver");
			 	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
//  회원정보
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
						return 1;
				else 
						return 0;	
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int join(UserVO user) {
		try {
			String SQL ="INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserBirth());
			pstmt.setString(4, user.getUserPhone());
			pstmt.setString(5, user.getUserPassword());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public UserVO getUserVO(String userID) {//하나의 글 내용을 불러오는 함수
		String SQL="SELECT * from USER where userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);//물음표
			rs=pstmt.executeQuery();//select
			if(rs.next()) {//결과가 있다면
				UserVO user = new UserVO();
				user.setUserID(rs.getString(1));//첫 번째 결과 값
				user.setUserName(rs.getString(2));
				user.setUserBirth(rs.getString(3));
				user.setUserPhone(rs.getString(4));
				user.setUserPassword(rs.getString(5));
				return user;//6개의 항목을 user인스턴스에 넣어 반환한다.
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String userID, String userName, String userBirth, String userPhone, String userPassword ) {
		String SQL="UPDATE USER SET userName = ?, userBirth = ?, userPhone = ?, userPassword = ? WHERE userID = ?";//특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			pstmt.setString(2, userBirth);
			pstmt.setString(3, userPhone);
			pstmt.setString(4, userPassword);
			pstmt.setString(5, userID);
			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int delete(String userID) {
		String SQL="DELETE FROM USER WHERE userID = ?";//특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
}
