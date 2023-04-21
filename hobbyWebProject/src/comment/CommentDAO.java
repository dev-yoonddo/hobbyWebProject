package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

	private Connection conn;
	private ResultSet rs;
	
	
	public CommentDAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	//cmtID 번호 매기기
	public int getNext() {
		String SQL = "SELECT cmtID FROM COMMENT ORDER BY cmtID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1; //첫번째 댓글인 경우
	}
	//작성하기
	public int write(String cmtContent, String userID, int boardID) {
		String SQL = "INSERT INTO COMMENT VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cmtContent);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, userID);
			pstmt.setInt(4, 1);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, boardID);
			pstmt.executeUpdate();
			return getNext();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//수정하기
	public String getUpdateComment(int cmtID) {
		String SQL = "SELECT cmtContent FROM comment WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cmtID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //오류
	}
	//댓글 리스트 출력하기
	public ArrayList<CommentDTO> getList(int boardID){
		String SQL = "SELECT * FROM comment WHERE boardID= ? AND cmtAvailable = 1 ORDER BY boardID DESC"; 
		ArrayList<CommentDTO> list = new ArrayList<CommentDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentDTO cmt = new CommentDTO();
				cmt.setCmtContent(rs.getString(1));
				cmt.setCmtID(rs.getInt(2));
				cmt.setUserID(rs.getString(3));
				cmt.setCmtAvailable(rs.getInt(4));
				cmt.setCmtDate(rs.getString(5));
				cmt.setBoardID(rs.getInt(6));
				list.add(cmt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	/*public int update(String cmtContent, int boardID, int cmtID) {
		String SQL = "UPDATE comment SET cmtContent = ? WHERE boardID = ? AND cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cmtContent);
			pstmt.setInt(2, boardID);
			pstmt.setInt(3, cmtID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}*/
	//하나의 댓글 정보 가져오기
	public CommentDTO getCommentVO(int cmtID) {
		String SQL = "SELECT * FROM comment WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  cmtID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				CommentDTO cmt = new CommentDTO();
				cmt.setCmtContent(rs.getString(1));
				cmt.setCmtID(rs.getInt(2));
				cmt.setUserID(rs.getString(3));
				cmt.setCmtAvailable(rs.getInt(4));
				cmt.setCmtDate(rs.getString(5));
				cmt.setBoardID(rs.getInt(6));
				return cmt;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//삭제하기
	public int delete(int cmtID) {
		String SQL = "DELETE FROM comment WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cmtID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	//특정 boardID에 해당되는 comment의 갯수 구하기
	public int getCommentCount(int boardID) {
	    String SQL = "SELECT COUNT(*) FROM comment WHERE boardID = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, boardID);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;
	}
	//UserDAO의 delete 메서드가 실행되면 사용되는 메서드
	//delete된 userID의 comment데이터 리스트를 가져온다.
	public List<CommentDTO> getDelCommentVOByUserID(String userID) {
	    List<CommentDTO> commentDTOs = new ArrayList<>();
	    String SQL = "SELECT cmtID, cmtAvailable FROM comment WHERE userID = ?";

	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	        	int cmtID = rs.getInt("cmtID");
	        	int cmtAvailable = rs.getInt("cmtAvailable");
	        	
	            CommentDTO commentDTO = new CommentDTO();
	            commentDTO.setCmtID(cmtID);
	            commentDTO.setCmtAvailable(cmtAvailable);

	            // Add CommentVO object to the list
	            commentDTOs.add(commentDTO);
	        }

	        rs.close();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return commentDTOs;
	}
	
	public void updateCommentVO(CommentDTO commentDTO) {
	    String SQL = "UPDATE comment SET cmtAvailable = ? WHERE cmtID = ?";

	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, commentDTO.getCmtAvailable());
	        pstmt.setInt(2, commentDTO.getCmtID());
	        pstmt.executeUpdate();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
}
	
	
