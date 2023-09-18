package location;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import group.GroupDTO;

public class LocationDAO {
	
		private Connection conn;
		private ResultSet rs;	
		public LocationDAO() {
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
	//위치 정보 저장
	public int regist(String userID, String spotName, String address, Double latitude, Double longitude) {
		try {
			String SQL ="INSERT INTO location VALUES (?, ?, ?, ?, ?)";
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			//pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, spotName);
			pstmt.setString(3, address);
			pstmt.setDouble(4, latitude);
			pstmt.setDouble(5, longitude);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	//회원 위치 정보 보기	
	public LocationDTO getUserLocationVO(String userID) {
		String SQL="SELECT * FROM location WHERE userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);//물음표
			rs=pstmt.executeQuery();//select
			if(rs.next()) {//결과가 있다면
				LocationDTO loc = new LocationDTO();
				loc.setUserID(rs.getString(1));
				loc.setSpotName(rs.getString(2));
				loc.setAddress(rs.getString(3));
				loc.setLatitude(rs.getDouble(4));
				loc.setLongitude(rs.getDouble(5));
				return loc;//6개의 항목을 user인스턴스에 넣어 반환한다.
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//스팟 네임 리스트 출력하기
	public ArrayList<LocationDTO> getSpotList(){
		String SQL = "SELECT spotName FROM location"; 
		ArrayList<LocationDTO> list = new ArrayList<LocationDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {//결과가 있다면
				LocationDTO loc = new LocationDTO();
				loc.setSpotName(rs.getString(1));
				list.add(loc);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	//저장된 스팟 정보 리스트 출력하기
	public ArrayList<LocationDTO> getSpotInfoList(){
		String SQL = "SELECT * FROM location"; 
		ArrayList<LocationDTO> list = new ArrayList<LocationDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {//결과가 있다면
				LocationDTO loc = new LocationDTO();
				loc.setUserID(rs.getString(1));
				loc.setSpotName(rs.getString(2));
				loc.setAddress(rs.getString(3));
				loc.setLatitude(rs.getDouble(4));
				loc.setLongitude(rs.getDouble(5));
				list.add(loc);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
}
