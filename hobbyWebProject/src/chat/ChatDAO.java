package chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import board.BoardDTO;
import crew.CrewDTO;
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
		String SQL = "SELECT * FROM chat WHERE groupID = ? ORDER BY chatDate DESC";
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
	
	//UserDAO - delete에서 사용되는 메서드
	//delete된 userID와 chat의 userID가 같은 값의 리스트를 가져온다.
	public List<ChatDTO> getDelChatVOByUserID(String userID) {
	    List<ChatDTO> chatDTOs = new ArrayList<>();
	    String SQL = "SELECT chatAvailable FROM chat WHERE userID = ?";//userID가 입력한 chat의 삭제여부 chatAvailable을 가져온다.
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) { //user 한명이 여러개의 chat을 입력하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
	        	int chatAvailable = rs.getInt("chatAvailable");
	        	//String id = rs.getString("userID");
	            //여기서 다른 속성도 가져올 수 있다.

	        	ChatDTO chatDTO = new ChatDTO();
	        	chatDTO.setChatAvailable(chatAvailable);
	        	chatDTO.setUserID(userID);
	        	chatDTOs.add(chatDTO);
	        }
	        rs.close();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return chatDTOs;
	}
	
	//UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateChatVO(ChatDTO chatDTO){
	    String SQL = "UPDATE chat SET chatAvailable = ? WHERE userID = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, chatDTO.getChatAvailable());
	        pstmt.setString(2, chatDTO.getUserID());
	        pstmt.executeUpdate();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
		
	//MemberDAO - delete에서 사용되는 메서드
	//탈퇴한 그룹의 memberID로 userID를 구한 후 chat의 userID가 같은 값의 리스트를 가져온다.
	public List<ChatDTO> getDelChatVOByMbID(String userID, int groupID) {
	    List<ChatDTO> chatDTOs = new ArrayList<>();
	    String SQL = "SELECT chatAvailable FROM chat WHERE userID = ? AND groupID = ?";//userID가 입력한 chat의 삭제여부 chatAvailable을 가져온다.
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        pstmt.setInt(2, groupID);
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) { //user 한명이 여러개의 chat을 입력하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
	        	int chatAvailable = rs.getInt("chatAvailable");
	        	//String id = rs.getString("userID");
	        	//int gr = rs.getInt("groupID");
	            //여기서 다른 속성도 가져올 수 있다.
	        	
	        	ChatDTO chatDTO = new ChatDTO();     	
	        	chatDTO.setChatAvailable(chatAvailable);
	        	chatDTO.setUserID(userID);
        		chatDTO.setGroupID(groupID);
	        	
	        	chatDTOs.add(chatDTO);
	        }
	        rs.close();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return chatDTOs;
	}
		
	//MemberDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateMbChatVO(ChatDTO chatDTO){
	    String SQL = "UPDATE chat SET chatAvailable = ? WHERE userID = ? AND groupID = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, chatDTO.getChatAvailable());
	        pstmt.setString(2, chatDTO.getUserID());
	        pstmt.setInt(3, chatDTO.getGroupID());
	        pstmt.executeUpdate();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
}
