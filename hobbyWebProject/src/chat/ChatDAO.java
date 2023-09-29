package chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.BoardDTO;
import file.FileDAO;

public class ChatDAO {
	private Connection conn; //자바와 데이터베이스 연결
	private ResultSet rs; //결과값 받아오기
	
	
	public ChatDAO() {
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
	//채팅 저장하기
	public int send(String userID, int groupID, String chatContent) {
		String SQL = "INSERT INTO chat VALUES (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); //board테이블에 저장된 boardID를 file테이블에도 저장하기 위해 변수에 저장한다.
			pstmt.setInt(2, groupID);
			pstmt.setString(3, chatContent);
			pstmt.setString(4, getDate());
			pstmt.setInt(5, 1);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//전송 채팅 보기
	public ChatDTO getChatVO(int groupID) {
		String SQL = "SELECT * FROM chat WHERE groupID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, groupID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setUserID(rs.getString(1));
				chat.setGroupID(rs.getInt(2));
				chat.setChatContent(rs.getString(3));
				chat.setChatDate(rs.getString(4));
				chat.setChatAvailable(rs.getInt(5));
				
				return chat;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	//해당 그룹의 채팅 리스트 가져오기
	public ArrayList<ChatDTO> getChatList(int groupID){
		String SQL = "SELECT * FROM chat WHERE groupID = ? AND chatAvailable = 1";
		ArrayList<ChatDTO> list = new ArrayList<ChatDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, groupID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setUserID(rs.getString(1));
				chat.setGroupID(rs.getInt(2));
				chat.setChatContent(rs.getString(3));
				chat.setChatDate(rs.getString(4));
				chat.setChatAvailable(rs.getInt(5));
				list.add(chat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
}
