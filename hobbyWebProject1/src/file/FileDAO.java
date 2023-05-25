package file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FileDAO {
	private Connection conn; //자바와 데이터베이스 연결
	private ResultSet rs; //결과값 받아오기
	
	public FileDAO() {
		try {
			 	String dbURL = "jdbc:mysql://localhost:3306/hobbywebproject?useUnicode=true&characterEncoding=UTF-8";
			 	String dbID = "root";
			 	String dbPassword = "9228";
			 	Class.forName("com.mysql.jdbc.Driver");
			 	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int upload(String fileName, String fileRealName) {

		String SQL = "INSERT INTO FILE VALUES (?, ?)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);			
			pstmt.setString(1,  fileName);
			pstmt.setString(2,  fileRealName);
			return pstmt.executeUpdate();

		} catch(Exception e) {
			e.printStackTrace();
		}

		return -1;

	}
}
