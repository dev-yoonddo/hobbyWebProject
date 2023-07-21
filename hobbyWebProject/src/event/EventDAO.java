package event;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class EventDAO {
	private Connection conn;
	private ResultSet rs;
	
	
	public EventDAO() {
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
	//eventID 번호매기기
	public int getNext() {
	    String SQL = "SELECT MAX(eventID) FROM event";
	    try {
	    	PreparedStatement pstmt = conn.prepareStatement(SQL);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            int maxEventID = rs.getInt(1);
	            return maxEventID + 1; 
	        } else {
            return 1;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;
	}
	//이벤트 응모하기
	public int apply(String userID, String eventContent, String groupName, String userPassword) {
		String SQL ="INSERT INTO event VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, eventContent);
			pstmt.setString(4, groupName);
			pstmt.setInt(5, 1);
			pstmt.setInt(6, 0);
			pstmt.setString(7, userPassword);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//유저가 응모한 이벤트 목록 가져오기
	public ArrayList<EventDTO> getListByUser(String userID){
		String SQL = "SELECT * FROM event WHERE userID = ? AND eventAvailable = 1";
		ArrayList<EventDTO> list = new ArrayList<EventDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				EventDTO event = new EventDTO();
				event.setEventID(rs.getInt(1));
				event.setUserID(rs.getString(2));
				event.setGroupName(rs.getString(3));
				event.setEventContent(rs.getString(4));
				event.setEventAvailable(rs.getInt(5));
				event.setEventWin(rs.getInt(6));
				event.setUserPassword(rs.getString(7));
				list.add(event);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
}
