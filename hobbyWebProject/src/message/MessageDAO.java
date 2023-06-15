package message;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import member.MemberDTO;

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
	//메시지 전송하기
	public int send(String userID, String toUserID, String msgTitle, String msgContent) {
		String SQL ="INSERT INTO message VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, toUserID);
			pstmt.setString(3, msgTitle);
			pstmt.setString(4, msgContent);
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 1);
			pstmt.setString(7, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//해당 유저에게 온 메시지 리스트
	public ArrayList<MessageDTO> getMessageList(String userID){
		String SQL = "SELECT * FROM message WHERE userID = ? AND msgAvailable = 1 ORDER BY msgDate DESC"; 
		ArrayList<MessageDTO> list = new ArrayList<MessageDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MessageDTO msg = new MessageDTO();
				msg.setUserID(rs.getString(1));
				msg.setToUserID(rs.getString(2));
				msg.setMsgTitle(rs.getString(3));
				msg.setMsgContent(rs.getString(4));
				msg.setMsgCheck(rs.getInt(5));
				msg.setMsgAvailable(rs.getInt(6));
				msg.setMsgDate(rs.getString(6));
				list.add(msg);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	//메시지 삭제하기 (msgAvailable = 0 으로 업데이트)
	public int delete(String msgTitle) {
		String SQL = "UPDATE message SET msgAvailable = 0 WHERE msgTitle = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, msgTitle);
			//성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//메시지 전체 삭제하기
	public int deleteMsgByUser(String userID) {
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
	
	//하나의 메시지 정보 가져오기
	public ArrayList<MessageDTO> getMessageCheck(String userID) {
		String SQL = "SELECT * FROM message WHERE userID = ? , msgAvailable = 1 AND msgCheck = 0";
		ArrayList<MessageDTO> checklist = new ArrayList<MessageDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MessageDTO msg = new MessageDTO();
				msg.setUserID(rs.getString(1));
				msg.setToUserID(rs.getString(2));
				msg.setMsgTitle(rs.getString(3));
				msg.setMsgContent(rs.getString(4));
				msg.setMsgCheck(rs.getInt(5));
				msg.setMsgAvailable(rs.getInt(6));
				msg.setMsgDate(rs.getString(7));
				checklist.add(msg);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return checklist;
	}
	//해당 userID가 가입한 그룹리스트(memberID) 최근에 가입한 순서대로 가져오기 
		public ArrayList<MemberDTO> getListByUser(String userID){
			String SQL = "SELECT * FROM member WHERE userID = ? AND mbAvailable = 1 ORDER BY mbDate DESC"; 
			ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					MemberDTO mb = new MemberDTO();
					mb.setMemberID(rs.getString(1));
					mb.setGroupID(rs.getInt(2));
					mb.setUserID(rs.getString(3));
					mb.setMbAvailable(rs.getInt(4));
					mb.setMbContent(rs.getString(5));
					mb.setMbDate(rs.getString(6));
					list.add(mb);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list; 
		}
}
