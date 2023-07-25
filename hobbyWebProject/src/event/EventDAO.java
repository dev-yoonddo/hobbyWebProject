package event;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import event.EventDTO;

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
	public int apply(String userID, String groupName, String eventContent, String userPassword) {
		String SQL ="INSERT INTO event VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, groupName);
			pstmt.setString(4, eventContent);
			pstmt.setInt(5, 1);
			pstmt.setInt(6, 0);
			pstmt.setString(7, userPassword);
			pstmt.setString(8, "");
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//	로그인 유저에 해당하는 정보 가져오기
	public EventDTO getEventVO(String userID) {
		String SQL="SELECT * FROM event WHERE userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);//물음표
			rs=pstmt.executeQuery();//select
			if(rs.next()) {//결과가 있다면
				EventDTO event = new EventDTO();
				event.setEventID(rs.getInt(1));//첫 번째 결과 값
				event.setUserID(rs.getString(2));//첫 번째 결과 값
				event.setGroupName(rs.getString(3));
				event.setEventContent(rs.getString(4));
				event.setEventAvailable(rs.getInt(5));
				event.setEventWin(rs.getInt(6));
				event.setUserPassword(rs.getString(7));
				event.setEventWinMsg(rs.getString(8));
				return event;//8개의 항목을 인스턴스에 넣어 반환한다.
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//전체 목록 출력 (eventWin = 1인 유저 제외)
	public ArrayList<EventDTO> getList(){
		String SQL = "SELECT * FROM event WHERE eventWin = 0 ORDER BY eventID DESC";
		ArrayList<EventDTO> list = new ArrayList<EventDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
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
				event.setEventWinMsg(rs.getString(8));
				list.add(event);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return list; 
	}
	//로그인 유저가 응모한 이벤트 목록 가져오기
	public ArrayList<EventDTO> getListByUser(String userID){
		String SQL = "SELECT * FROM event WHERE userID = ?";
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
				event.setEventWinMsg(rs.getString(8));
				list.add(event);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	//당첨자는 eventWin 값을 1로 변경하기
	public int raffleWin(String userID) {
		String SQL="UPDATE event SET eventWin = 1 WHERE userID = ?";//특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	//당첨자에게 메시지 보내기
	public int raffleWinMsg(String userID, String eventWinMsg) {
		String SQL="UPDATE event SET eventWinMsg = ? WHERE userID = ?";//특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, eventWinMsg);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	//당첨메시지 더이상 보지않기
	public int raffleMsgExit(String userID) {
		String SQL="UPDATE event SET eventAvailable = 0 WHERE userID = ?";//특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
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
