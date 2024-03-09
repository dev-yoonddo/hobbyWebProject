package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.toogether.session.SqlConfig;

import board.BoardDAO;
import board.BoardDTO;
import chat.ChatDAO;
import chat.ChatDTO;
import comment.CommentDAO;
import comment.CommentDTO;
import crew.CrewDAO;
import crew.CrewDTO;
import group.GroupDAO;
import group.GroupDTO;
import location.LocationDAO;
import location.LocationDTO;
import member.MemberDAO;
import member.MemberDTO;
import message.MessageDAO;
import message.MessageDTO;
import schedule.ScheduleDAO;
import schedule.ScheduleDTO;

public class UserDAO {

	// singleton : Bill Pugh Solution (LazyHolder) 기법
	private UserDAO() {
	}

	// static 내부 클래스를 이용
	// Holder로 만들어, 클래스가 메모리에 로드되지 않고 getInstance 메서드가 호출되어야 로드됨
	private static class UserDAOHolder {
		private static final UserDAO INSTANCE = new UserDAO();
	}

	public static UserDAO getInstance() {
		return UserDAOHolder.INSTANCE;
	}

//  회원 로그인
	public int login(String userID, String userPassword, int userAvailable) {
		String SQL = "SELECT userPassword, userSalt, userAvailable FROM user WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			// 둘 중 하나라도 입력하지 않았을 때
			if (userID == null || userPassword == null) {
				return 2;
			}
			if (rs.next()) { // 입력한 아이디가 존재할 때
				int available = rs.getInt("userAvailable"); // userAvailable 값 가져오기
				String salt = rs.getString("userSalt"); // salt값 가져오기
				String password = rs.getString("userPassword"); // password 값 가져오기
				// 사용자가 입력한 비밀번호와 기존 salt값을 encoding메서드로 넘겨 암호화 값을 구하고
				// 일치하면 로그인 성공 처리한다.
				HashMap<String, String> checkPW = PwEncrypt.encoding(userPassword, salt);
				System.out.println("로그인 요청!!" + salt);
				System.out.println("로그인 요청!!" + checkPW.get("hash"));
				if (available == 1) {
					if (password.equals(checkPW.get("hash"))) { // userAvailable == 1이고 password 값이 일치하면
						return 1; // 로그인 성공
					} else {
						return 0; // 비밀번호 불일치
					}
				}
				/*
				 * else { return -3; // db에 아이디는 있지만 userAvailable = 0일때 (탈퇴한 회원일때) 회원 정보가 아예
				 * 존재하지 않을때와 구별할 수 있지만 생략함. }
				 */
			}
			return -1; // 입력한 아이디가 존재하지 않을때
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return -2; // 데이터베이스 오류
	}

//	회원 가입
	public int join(UserDTO user) {
		String hashPW = null;
		String hashEmail = null;
		String salt = null;
//		String salt2 = null;
		HashMap<String, String> encrypt = null;

		// 회원가입시 salt값이 null이기 때문에 null을 넘겨준다.
		encrypt = PwEncrypt.encoding(user.getUserPassword(), null);
		// 암호화 된 값과 salt값을 가져온다.
		hashPW = encrypt.get("hash");
		salt = encrypt.get("salt");

//		System.out.println("비밀번호 암호화: " + hashPW);
//		System.out.println("salt: " + salt);

		// 비밀번호 값이 정상적으로 생성되면 같은 salt값으로 email도 암호화한다.
		if (salt != null) {
			HashMap<String, String> encryptMail;
			encryptMail = PwEncrypt.encoding(user.getUserEmail(), salt);
			hashEmail = encryptMail.get("hash");
//			salt2 = encryptMail.get("salt2");
//
//			System.out.println("이메일 암호화: " + hashEmail);
//			System.out.println("salt2: " + salt2);
//			System.out.println("salt일치: " + salt.equals(salt2));
		}
		String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			// conn = SqlConfig.getConn(); pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserBirth());
			pstmt.setString(5, user.getUserPhone());
			pstmt.setString(6, hashPW);
			pstmt.setString(7, salt);
			pstmt.setInt(8, 1);
			pstmt.setString(9, hashEmail);
			pstmt.setBoolean(10, false);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

//이메일 인증
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE user SET userEmailChecked = true WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			// conn = SqlConfig.getConn(); pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return false; // 데이터베이스 오류
	}

//이메일 인증 여부
	public boolean getUserEmailChecked(String userID) {
		String SQL = "SELECT userEmailChecked FROM user WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			// conn = SqlConfig.getConn(); pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getBoolean(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return false; // 데이터베이스 오류
	}

//이메일 가져오기
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM user WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			// conn = SqlConfig.getConn(); pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return null;
	}

//기존 회원 이메일 정보 업데이트
	public int userEmailUpdate(String userID, String userEmail) {
		// 기존 salt값 가져오기
		String salt = getUserVO(userID).getUserSalt();
		// 사용자가 업데이트 할 이메일주소 , 기존 salt값을 넘겨 새로운 emailHash값 저장하기
		HashMap<String, String> encryptMail = PwEncrypt.encoding(userEmail, salt);
		String userEmailHash = encryptMail.get("hash");
		String SQL = "UPDATE user SET userEmail = ? , userEmailHash = ? WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			// conn = SqlConfig.getConn(); pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userEmail);
			pstmt.setString(2, userEmailHash);
			pstmt.setString(3, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;// 데이터베이스 오류
	}

//모든 사용자의 이메일 리스트 가져오기
	public ArrayList<UserDTO> getEmailList() {
		String SQL = "SELECT userEmail FROM user WHERE userEmail IS NOT NULL AND userEmail != '' ";
		ArrayList<UserDTO> list = new ArrayList<UserDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserDTO usr = new UserDTO();
				usr.setUserEmail(rs.getString("userEmail"));
				list.add(usr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return list;
	}

//	회원 정보 보기	
	public UserDTO getUserVO(String userID) {
		String SQL = "SELECT * FROM user WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);// 물음표
			rs = pstmt.executeQuery();// select
			if (rs.next()) {// 결과가 있다면
				UserDTO user = new UserDTO();
				user.setUserID(rs.getString(1));// 첫 번째 결과 값
				user.setUserName(rs.getString(2));
				user.setUserEmail(rs.getString(3));
				user.setUserBirth(rs.getString(4));
				user.setUserPhone(rs.getString(5));
				user.setUserPassword(rs.getString(6));
				user.setUserSalt(rs.getString(7));
				user.setUserAvailable(rs.getInt(8));
				user.setUserEmailHash(rs.getString(9));
				user.setUserEmailChecked(rs.getBoolean(10));
				return user;// 6개의 항목을 user인스턴스에 넣어 반환한다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return null;
	}

// 회원 정보 수정	
	public int update(String userID, String userName, String userEmail, String userBirth, String userPhone,
			String userSalt, String userPassword) {
		UserDTO user = new UserDAO().getUserVO(userID);
		// DAO의 update메서드가 실행되면 userPassword는 무조건 변경되고 userEmail은 변경 되거나 되지 않을 수 있기 때문에
		// 무조건 salt값은 변경된다고 보면 된다.
		// 따라서 userPassword는 null과 함께 넘겨주고 userEmail은 encryptPW에서 구한 newSalt값과 함께 넘겨준다.
		HashMap<String, String> encryptPW = PwEncrypt.encoding(userPassword, null);
		String newPW = encryptPW.get("hash");
		String newSalt = encryptPW.get("salt");
		HashMap<String, String> encryptEmail = PwEncrypt.encoding(userEmail, newSalt);
		String newEmailHash = encryptEmail.get("hash");

		String SQL = "UPDATE user SET userName = ?,userEmail = ?, userBirth = ?, userPhone = ?, userPassword = ?, userSalt = ?, userEmailHash = ?, userEmailChecked = ? WHERE userID = ?";// 특정한
		// 바꿔준다.
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userName);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, userBirth);
			pstmt.setString(4, userPhone);
			pstmt.setString(5, newPW);
			pstmt.setString(6, newSalt);
			pstmt.setString(7, newEmailHash);
			// 입력받은 userEmail이 이미 사용자 DB에 입력된 이메일과 같으면 이메일 인증여부를 그대로 가져온다.
			if (userEmail.equals(user.getUserEmail())) {
				pstmt.setBoolean(8, user.isUserEmailChecked());
				// 다르면 재인증이 필요하기 때문에 false를 넣어준다.
			} else {
				pstmt.setBoolean(8, false);
			}
			pstmt.setString(9, userID);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;// 데이터베이스 오류
	}

//	회원 탈퇴
//	1. 데이터 베이스 삭제
	/*
	 * public int delete(String userID) { String
	 * SQL="DELETE FROM user WHERE userID = ?"; try { PreparedStatement
	 * pstmt=conn.prepareStatement(SQL); pstmt.setString(1, userID); return
	 * pstmt.executeUpdate(); } catch(Exception e) { e.printStackTrace(); } return
	 * -1;//데이터베이스 오류 }
	 */

//	userAvailable을 0으로 변경
	public int delete(String userID) {
		String SQL = "UPDATE user SET userAvailable = 0 WHERE userID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			// return pstmt.executeUpdate();
			// 성공적으로 수행했다면 0이상의 결과 반환
			int result = pstmt.executeUpdate(); // userAvailable = 0이 성공적으로 실행되면 0이상의 결과를 result에 저장
			pstmt.close();
			if (result > 0) {
				BoardDAO boardDAO = BoardDAO.getInstance();
				List<BoardDTO> boardVOList = boardDAO.getDelBoardVOByUserID(userID);
				for (BoardDTO boardDTO : boardVOList) {
					boardDTO.setBoardAvailable(0);
					boardDAO.updateBoardVO(boardDTO);
				}

				CommentDAO commentDAO = CommentDAO.getInstance();
				List<CommentDTO> commentVOList = commentDAO.getDelCommentVOByUserID(userID);
				for (CommentDTO commentDTO : commentVOList) {
					commentDTO.setCmtAvailable(0);
					commentDAO.updateCommentVO(commentDTO);
				}

				GroupDAO groupDAO = GroupDAO.getInstance();
				List<GroupDTO> groupVOList = groupDAO.getDelGroupVOByUserID(userID);
				for (GroupDTO groupDTO : groupVOList) {
					groupDTO.setGroupAvailable(0);
					groupDAO.updateGroupVO(groupDTO);
				}

				MemberDAO memberDAO = MemberDAO.getInstance();
				List<MemberDTO> memberVOList = memberDAO.getDelMemberVOByUserID(userID);
				for (MemberDTO memberDTO : memberVOList) {
					memberDTO.setMbAvailable(0); // 모든 mbAvailable 값을 0으로 변경한다.
					memberDAO.updateMemberVO(memberDTO); // 변경한 후 업데이트 한다.
				}

				MessageDAO messageDAO = MessageDAO.getInstance();
				List<MessageDTO> messageVOList = messageDAO.getDelMsgVOByUserID(userID);
				for (MessageDTO messageDTO : messageVOList) {
					messageDTO.setMsgAvailable(0); // 모든 mbAvailable 값을 0으로 변경한다.
					messageDAO.updateMsgVO(messageDTO); // 변경한 후 업데이트 한다.
				}

				ChatDAO chatDAO = ChatDAO.getInstance();
				List<ChatDTO> chatVOList = chatDAO.getDelChatVOByUserID(userID);
				for (ChatDTO chatDTO : chatVOList) {
					chatDTO.setChatAvailable(0); // 모든 chatAvailable 값을 0으로 변경한다.
					chatDAO.updateChatVO(chatDTO); // 변경한 후 업데이트 한다.
				}

				LocationDAO locationDAO = LocationDAO.getInstance();
				List<LocationDTO> spotVOList = locationDAO.getDelSpotVOByUserID(userID);
				for (LocationDTO locationDTO : spotVOList) {
					locationDTO.setSpotAvailable(0); // 모든 spotAvailable 값을 0으로 변경한다.
					locationDAO.updateSpotVO(locationDTO); // 변경한 후 업데이트 한다.
				}

				CrewDAO crewDAO = CrewDAO.getInstance();
				List<CrewDTO> crewVOList = crewDAO.getDelCrewVOByUserID(userID);
				for (CrewDTO crewDTO : crewVOList) {
					crewDTO.setCrewAvailable(0); // 모든 crewAvailable 값을 0으로 변경한다.
					crewDAO.updateCrewVO(crewDTO); // 변경한 후 업데이트 한다.
				}
				ScheduleDAO skedDAO = ScheduleDAO.getInstance();
				List<ScheduleDTO> skedVOList = skedDAO.getDelScheduleByUserID(userID);
				for (ScheduleDTO skedDTO : skedVOList) {
					skedDTO.setSkedAvailable(0);
					skedDAO.updateSkedVO(skedDTO);
				}

			}
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1; // database error
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
	}

}
