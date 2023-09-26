package crew;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CrewDAO {	
	private Connection conn;
	private ResultSet rs;	
	public CrewDAO() {
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
	
	//멤버 정보 저장
	public int joinCrew(String userID, String spotName) {
		try {
			String SQL ="INSERT INTO crew VALUES (?, ?, ?)";
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			//pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, spotName);
			pstmt.setInt(3, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	//userID의 리스트를 가져와서 이미 가입한 그룹인지 확인
	public ArrayList<CrewDTO> getJoinedList(String userID, String spotName){
		String SQL = "SELECT * FROM crew WHERE userID = ? AND spotName = ?"; 
		ArrayList<CrewDTO> list = new ArrayList<CrewDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, spotName);
			rs = pstmt.executeQuery();
			while(rs.next()) {//결과가 있다면
				CrewDTO crew = new CrewDTO();
				crew.setUserID(rs.getString(1));
				crew.setSpotName(rs.getString(2));
				crew.setCrewAvailable(rs.getInt(3));
				list.add(crew);
			}
			//System.out.println(list);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
