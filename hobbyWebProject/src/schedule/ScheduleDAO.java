package schedule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import group.GroupDTO;

public class ScheduleDAO {
	private Connection conn;
	private ResultSet rs;	
	public ScheduleDAO() {
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
	
	//스케줄 저장
	public int registSchedule(String userID, String spotName, int skedMonth, int skedDay, String skedContent) {
		try {
			String SQL ="INSERT INTO schedule VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			//pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, spotName);
			pstmt.setInt(3, skedMonth);
			pstmt.setInt(4, skedDay);
			pstmt.setString(5, skedContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//저장된 스케줄 리스트 모두 가져오기
	public ArrayList<ScheduleDTO> getScheduleList(){
		String SQL = "SELECT * FROM schedule ORDER BY skedMonth DESC , skedDay DESC"; 
		ArrayList<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ScheduleDTO sked = new ScheduleDTO();
				sked.setUserID(rs.getString(1));
				sked.setSpotName(rs.getString(2));
				sked.setSkedMonth(rs.getInt(3));
				sked.setSkedDay(rs.getInt(4));
				sked.setSkedContent(rs.getString(5));
				sked.setSkedAvailable(rs.getInt(6));
				list.add(sked);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	//저장된 스케줄 리스트 모두 가져오기
	public ArrayList<ScheduleDTO> getScheduleListBySpot(String spotName){
		String SQL = "SELECT * FROM schedule WHERE spotName = ?"; 
		ArrayList<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, spotName);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ScheduleDTO sked = new ScheduleDTO();
				sked.setUserID(rs.getString(1));
				sked.setSpotName(rs.getString(2));
				sked.setSkedMonth(rs.getInt(3));
				sked.setSkedDay(rs.getInt(4));
				sked.setSkedContent(rs.getString(5));
				sked.setSkedAvailable(rs.getInt(6));
				list.add(sked);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	//지정된 날짜와 일치하는 스케줄 리스트 가져오기
	public ArrayList<ScheduleDTO> getScheduleListByTime(int skedMonth, int skedDay){
		String SQL = "SELECT * FROM schedule WHERE skedMonth = ? AND skedDay = ?"; 
		ArrayList<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, skedMonth);
			pstmt.setInt(2, skedDay);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ScheduleDTO sked = new ScheduleDTO();
				sked.setUserID(rs.getString(1));
				sked.setSpotName(rs.getString(2));
				sked.setSkedMonth(rs.getInt(3));
				sked.setSkedDay(rs.getInt(4));
				sked.setSkedContent(rs.getString(5));
				sked.setSkedAvailable(rs.getInt(6));
				list.add(sked);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
}
