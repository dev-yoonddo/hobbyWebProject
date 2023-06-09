package message;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MessageDAO {
	private Connection conn;
	private ResultSet rs;
	
	
	public MessageDAO() {
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
	//msgID 번호매기기
		public int getNext() {
		    String SQL = "SELECT MAX(msgID) FROM message";
		    try {
		    	PreparedStatement pstmt = conn.prepareStatement(SQL);
		        ResultSet rs = pstmt.executeQuery();
		        if (rs.next()) {
		            int maxMsgID = rs.getInt(1);
		            return maxMsgID + 1; 
		        } else {
	            return 1;
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return -1;
		}
	//날짜 가져오기
	public String getDate() { //현재 시간을 가져오는 함수
		String SQL = "SELECT NOW()"; //현재 시간을 가져오는 MySQL의 문장
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL문장을 실행준비 단계로 만든다
			rs = pstmt.executeQuery(); //실제로 실행했을 때 결과를 가져온다.
			if(rs.next()) { //결과가 있는경우
				return rs.getString(1); //현재의 날짜를 그대로 반환한다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //빈 문자열을 반환함으로써 데이터베이스 오류를 알려준다.
	}
	//메시지 읽음 (getMsgVO에서 해도 된다)
	public int msgCheckUpdate(int msgID, String toUserID) {
		String SQL = "UPDATE message SET msgCheck = 1 WHERE msgID = ? AND toUserID = ?"; //msgID만 넣으면 보낸사람이 읽어도 읽음으로 처리되기 때문에 toUserID == userID일 때만 읽음처리한다.
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, msgID);
			pstmt.setString(2, toUserID);
			return pstmt.executeUpdate();//insert,delete,update			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	//메시지 전송하기
	public int send(String userID, String toUserID, int groupID, String msgTitle, String msgContent) {
		String SQL ="INSERT INTO message VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, toUserID);
			pstmt.setInt(4, groupID);
			pstmt.setString(5, msgTitle);
			pstmt.setString(6, msgContent);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 1);
			pstmt.setString(9, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//해당 유저에게 온 메시지 전체 리스트
	public ArrayList<MessageDTO> getMessageList(String toUserID){
		String SQL = "SELECT * FROM message WHERE toUserID = ? AND msgAvailable = 1 ORDER BY msgDate DESC"; 
		ArrayList<MessageDTO> list = new ArrayList<MessageDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toUserID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MessageDTO msg = new MessageDTO();
				msg.setMsgID(rs.getInt(1));
				msg.setUserID(rs.getString(2));
				msg.setToUserID(rs.getString(3));
				msg.setGroupID(rs.getInt(4));
				msg.setMsgTitle(rs.getString(5));
				msg.setMsgContent(rs.getString(6));
				msg.setMsgCheck(rs.getInt(7));
				msg.setMsgAvailable(rs.getInt(8));
				msg.setMsgDate(rs.getString(9));
				list.add(msg);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	//해당 유저가 보낸 메시지 전체 리스트 (userID가 내 아이디랑 일치하는 데이터)
		public ArrayList<MessageDTO> getSendMessageList(String userID){
			String SQL = "SELECT * FROM message WHERE userID = ? AND msgAvailable = 1 ORDER BY msgDate DESC"; 
			ArrayList<MessageDTO> list = new ArrayList<MessageDTO>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					MessageDTO msg = new MessageDTO();
					msg.setMsgID(rs.getInt(1));
					msg.setUserID(rs.getString(2));
					msg.setToUserID(rs.getString(3));
					msg.setGroupID(rs.getInt(4));
					msg.setMsgTitle(rs.getString(5));
					msg.setMsgContent(rs.getString(6));
					msg.setMsgCheck(rs.getInt(7));
					msg.setMsgAvailable(rs.getInt(8));
					msg.setMsgDate(rs.getString(9));
					list.add(msg);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list; 
		}
	//메시지 삭제하기 (msgAvailable = 0 으로 업데이트)
	public int delete(int msgID) {
		String SQL = "UPDATE message SET msgAvailable = 0 WHERE msgID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, msgID);
			//성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//삭제되지않은 메시지 갯수 구하기
	public int msgCount(String toUserID, String userID) {
		String SQL = "SELECT COUNT(*) FROM message WHERE toUserID = ? AND userID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userID);
			//성공적으로 수행했다면 0이상의 결과 반환	
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	//받은 메시지 삭제하기 : toUserID == userID 이면 받은메시지이다.
	public int deleteRcvMsg(String userID) {
		String SQL = "UPDATE message SET msgAvailable = 0 WHERE toUserID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			//성공적으로 수행했다면 0이상의 결과 반환
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//받은 메시지 삭제하기
	public int deleteSendMsg(String userID) {
		String SQL = "UPDATE message SET msgAvailable = 0 WHERE userID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			//성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//메시지 전체 삭제하기
	public int deleteAllMsgByUser(String userID) {
		try {
			deleteRcvMsg(userID);
			deleteSendMsg(userID);
			//성공적으로 수행했다면 0이상의 결과 반환
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	//로그인한 userID값을 toUserID값에 대입해 해당 그룹멤버가 보낸 메세지중 안읽은 메세지를 가져온다.
	public ArrayList<MessageDTO> getMessageCheck(String toUserID, int groupID) {
		String SQL = "SELECT * FROM message WHERE toUserID = ? AND groupID = ? AND msgAvailable = 1 AND msgCheck = 0";
		ArrayList<MessageDTO> checklist = new ArrayList<MessageDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toUserID);
			pstmt.setInt(2, groupID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MessageDTO msg = new MessageDTO();
				msg.setMsgID(rs.getInt(1));
				msg.setUserID(rs.getString(2));
				msg.setToUserID(rs.getString(3));
				msg.setGroupID(rs.getInt(4));
				msg.setMsgTitle(rs.getString(5));
				msg.setMsgContent(rs.getString(6));
				msg.setMsgCheck(rs.getInt(7));
				msg.setMsgAvailable(rs.getInt(8));
				msg.setMsgDate(rs.getString(9));
				checklist.add(msg);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return checklist;
	}
	//내가 만든 그룹의 멤버인 userID에게 온 메세지 리스트 전체 가져오기
	public ArrayList<MessageDTO> getMsgList(String toUserID, int groupID){
		String SQL = "SELECT * FROM message WHERE toUserID = ? AND groupID = ? AND msgAvailable = 1 ORDER BY msgDate DESC"; 
		ArrayList<MessageDTO> msglist = new ArrayList<MessageDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toUserID);
			pstmt.setInt(2, groupID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MessageDTO msg = new MessageDTO();
				msg.setMsgID(rs.getInt(1));
				msg.setUserID(rs.getString(2));
				msg.setToUserID(rs.getString(3));
				msg.setGroupID(rs.getInt(4));
				msg.setMsgTitle(rs.getString(5));
				msg.setMsgContent(rs.getString(6));
				msg.setMsgCheck(rs.getInt(7));
				msg.setMsgAvailable(rs.getInt(8));
				msg.setMsgDate(rs.getString(9));
				msglist.add(msg);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return msglist; 
	}
	//한 개의 메시지 정보
	public MessageDTO getMsgVO(int msgID) {
		String SQL = "SELECT * FROM message WHERE msgID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, msgID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				MessageDTO msg = new MessageDTO();
				msg.setMsgID(rs.getInt(1));
				msg.setUserID(rs.getString(2));
				msg.setToUserID(rs.getString(3));
				msg.setGroupID(rs.getInt(4));
				msg.setMsgTitle(rs.getString(5));
				msg.setMsgContent(rs.getString(6));
				msg.setMsgCheck(rs.getInt(7));
				msg.setMsgAvailable(rs.getInt(8));
				msg.setMsgDate(rs.getString(9));

				/* 메시지 조회 처리 다른 방법
				int viewCount=rs.getInt(8);
				board.setViewCount(viewCount);
				viewCount++;
				viewCountUpdate(viewCount,boardID);
				*/
				return msg;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
}
