package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import board.BoardDAO;
import board.BoardDTO;
import comment.CommentDAO;
import comment.CommentDTO;

public class MemberDAO {

		private Connection conn;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		
		public MemberDAO() {
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
	//	가입하기
	public int join(String memberID, int groupID, String userID, String mbContent) {
		String SQL ="INSERT INTO member VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			pstmt.setInt(2, groupID);
			pstmt.setString(3, userID);
			pstmt.setInt(4, 1);
			pstmt.setString(5, mbContent);
			pstmt.setString(6, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 , primary key인 memberid가 중복됐을때도 오류가 난다.
	}
//	회원 정보 보기	
	public MemberDTO getMemberVO(String memberID) {
		String SQL="SELECT * FROM member WHERE memberID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);//물음표
			rs=pstmt.executeQuery();//select
			if(rs.next()) {//결과가 있다면
				MemberDTO mb = new MemberDTO();
				mb.setMemberID(rs.getString(1));
				mb.setGroupID(rs.getInt(2));
				mb.setUserID(rs.getString(3));
				mb.setMbAvailable(rs.getInt(4));
				mb.setMbContent(rs.getString(5));
				mb.setMbDate(rs.getString(6));
				return mb;//6개의 항목을 user인스턴스에 넣어 반환한다.
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//삭제하기
		public int delete(int memberID) {
			
			
			String SQL = "UPDATE member SET mbAvailable = 0 WHERE memberID = ? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, memberID);
				//성공적으로 수행했다면 0이상의 결과 반환
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
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
		
		//멤버 리스트 출력하기
		public ArrayList<MemberDTO> getList(int groupID){
			String SQL = "SELECT * FROM member WHERE groupID= ? AND mbAvailable = 1 ORDER BY groupID DESC"; 
			ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, groupID);
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
		//하나의 멤버 정보 가져오기
		public MemberDTO getMemberVO(String userID, int groupID) {
			String SQL = "SELECT * FROM member WHERE userID = ? AND groupID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				pstmt.setInt(2, groupID);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					MemberDTO mb = new MemberDTO();
					mb.setMemberID(rs.getString(1));
					mb.setGroupID(rs.getInt(2));
					mb.setUserID(rs.getString(3));
					mb.setMbAvailable(rs.getInt(4));
					mb.setMbContent(rs.getString(5));
					mb.setMbDate(rs.getString(6));
					return mb;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		/*//그룹 탈퇴하기 (1. 데이터 삭제)
		public int delete(String memberID) {
			String SQL = "DELETE FROM member WHERE memberID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, memberID);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}*/
		//그룹 탈퇴하기 (2. mbAvailable = 0 으로 업데이트)
		public int delete(String memberID) {
			String SQL = "UPDATE member SET mbAvailable = 0 WHERE memberID = ? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, memberID);
				//성공적으로 수행했다면 0이상의 결과 반환
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
		//특정 groupID에 해당되는 member의 갯수 구하기
		public int getMemberCount(int groupID) {
		    String SQL = "SELECT COUNT(*) FROM member WHERE groupID = ?";
		    try {
		        PreparedStatement pstmt = conn.prepareStatement(SQL);
		        pstmt.setInt(1, groupID);
		        rs = pstmt.executeQuery();
		        if (rs.next()) {
		            return rs.getInt(1);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return -1;
		}
		
		//UserDAO - delete에서 사용되는 메서드
		//delete된 userID와 board의 userID가 같은 값의 리스트를 가져온다.
		public List<MemberDTO> getDelMemberVOByUserID(String userID) {
		    List<MemberDTO> memberDTOs = new ArrayList<>();
		    String SQL = "SELECT memberID, mbAvailable FROM member WHERE userID = ?";//userID가 작성한 board의 boardID와 boardAvailable의 값을 가져온다.
		    try {
		        PreparedStatement pstmt = conn.prepareStatement(SQL);
		        pstmt.setString(1, userID);
		        ResultSet rs = pstmt.executeQuery();
		        
		        while (rs.next()) { //user 한명이 여러개의 board를 생성하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
		            String memberID = rs.getString("memberID");
		            int mbAvailable = rs.getInt("mbAvailable");
		            //여기서 다른 속성도 가져올 수 있다.

		            // BoardVO 객체 생성하고 가져온 속성을 BoardVO 객체에 저장한다.
		            MemberDTO memberDTO = new MemberDTO();
		            memberDTO.setMemberID(memberID); 
		            memberDTO.setMbAvailable(mbAvailable);

		            // boardVOs list에 boardVO object 추가
		            memberDTOs.add(memberDTO);
		        }
		        rs.close();
		        pstmt.close();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return memberDTOs;
		}
		
		//UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
		public void updateMemberVO(MemberDTO memberDTO){
		    String SQL = "UPDATE member SET mbAvailable = ? WHERE memberID = ?";
		    try {
		        PreparedStatement pstmt = conn.prepareStatement(SQL);
		        pstmt.setInt(1, memberDTO.getMbAvailable());
		        pstmt.setString(2, memberDTO.getMemberID());
		        pstmt.executeUpdate();
		        pstmt.close();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		}
	
}
