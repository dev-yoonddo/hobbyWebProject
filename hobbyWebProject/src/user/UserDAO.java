package user;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import board.BoardDAO;
import board.BoardDTO;
import comment.CommentDAO;
import comment.CommentDTO;
import group.GroupDAO;
import group.GroupDTO;
import member.MemberDAO;
import member.MemberDTO;

public class UserDAO {

		private Connection conn;
		private ResultSet rs;
		
		
		public UserDAO() {
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
	
//  회원 로그인
	public int login(String userID, String userPassword, int userAvailable) {
		String SQL = "SELECT userPassword, userAvailable FROM user WHERE userID = ?";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			//둘 중 하나라도 입력하지 않았을 때
			if(userID ==  null || userPassword == null) {
				return 2;
			}
			if (rs.next()) { //입력한 아이디가 존재할 때
	            int available = rs.getInt("userAvailable"); //userAvailable 값 가져오기
	            String password = rs.getString("userPassword"); //password 값 가져오기
	            
	            if (available == 1) {
	            	if(password.equals(userPassword)) { //userAvailable == 1이고 password 값이 일치하면
	                    return 1; // 로그인 성공
	                } else {
	                    return 0; // 비밀번호 불일치
	                }
                }
		      /*else {
	            return -3; // db에 아이디는 있지만 userAvailable = 0일때 (탈퇴한 회원일때)
	            			회원 정보가 아예 존재하지 않을때와 구별할 수 있지만 생략함.
	            }*/
	        }
	        return -1; // 입력한 아이디가 존재하지 않을때
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -2; // 데이터베이스 오류
	}
	
//	회원 가입
	public int join(UserDTO user) {
		try {
			String SQL ="INSERT INTO user VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			//pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserBirth());
			pstmt.setString(4, user.getUserPhone());
			pstmt.setString(5, pwEncrypt.encoding(user.getUserPassword()));
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
//	회원 정보 보기	
	public UserDTO getUserVO(String userID) {
		String SQL="SELECT * FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);//물음표
			rs=pstmt.executeQuery();//select
			if(rs.next()) {//결과가 있다면
				UserDTO user = new UserDTO();
				user.setUserID(rs.getString(1));//첫 번째 결과 값
				user.setUserName(rs.getString(2));
				user.setUserBirth(rs.getString(3));
				user.setUserPhone(rs.getString(4));
				user.setUserPassword(rs.getString(5));
				user.setUserAvailable(rs.getInt(6));
				return user;//6개의 항목을 user인스턴스에 넣어 반환한다.
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
// 회원 정보 수정	
	public int update(String userID, String userName, String userBirth, String userPhone, String userPassword ) {
		String SQL="UPDATE user SET userName = ?, userBirth = ?, userPhone = ?, userPassword = ? WHERE userID = ?";//특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			pstmt.setString(2, userBirth);
			pstmt.setString(3, userPhone);
			pstmt.setString(4, userPassword);
			pstmt.setString(5, userID);

			return pstmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
//	회원 탈퇴
//	1. 데이터 베이스 삭제
	/*
	public int delete(String userID) {
		String SQL="DELETE FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}*/
	
//	userAvailable을 0으로 변경
	public int delete(String userID) {
		String SQL = "UPDATE user SET userAvailable = 0 WHERE userID = ? " ;
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			//return pstmt.executeUpdate();
			//성공적으로 수행했다면 0이상의 결과 반환
			int result = pstmt.executeUpdate(); //userAvailable = 0이 성공적으로 실행되면 0이상의 결과를 result에 저장
			pstmt.close();
	        if (result > 0) {
	            BoardDAO boardDAO = new BoardDAO(); 
	            List<BoardDTO> boardVOList = boardDAO.getDelBoardVOByUserID(userID);
	            for (BoardDTO boardDTO : boardVOList) {
	                boardDTO.setBoardAvailable(0);
	                boardDAO.updateBoardVO(boardDTO);
	            }

	            CommentDAO commentDAO = new CommentDAO();
	            List<CommentDTO> commentVOList = commentDAO.getDelCommentVOByUserID(userID);
	            for (CommentDTO commentDTO : commentVOList) {
	                commentDTO.setCmtAvailable(0);
	                commentDAO.updateCommentVO(commentDTO);
	            }
	            
	            GroupDAO groupDAO = new GroupDAO(); 
	            List<GroupDTO> groupVOList = groupDAO.getDelGroupVOByUserID(userID);
	            for (GroupDTO groupDTO : groupVOList) {
	            	groupDTO.setGroupAvailable(0);
	            	groupDAO.updateGroupVO(groupDTO);
	            }
	            
	            MemberDAO memberDAO = new MemberDAO(); 
	            List<MemberDTO> memberVOList = memberDAO.getDelMemberVOByUserID(userID);
	            for (MemberDTO memberDTO : memberVOList) {
	            	memberDTO.setMbAvailable(0);
	            	memberDAO.updateMemberVO(memberDTO);
	            }
	        }
	        return result;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return -1; // database error
	    }
	}
	


}
