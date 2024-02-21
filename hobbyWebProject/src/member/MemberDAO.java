package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.toogether.session.SqlConfig;

import chat.ChatDAO;
import chat.ChatDTO;

public class MemberDAO {

	// singleton : Bill Pugh Solution (LazyHolder) 기법
	private MemberDAO() {
	}

	// static 내부 클래스를 이용
	// Holder로 만들어, 클래스가 메모리에 로드되지 않고 getInstance 메서드가 호출되어야 로드됨
	private static class MemberDAOHolder {
		private static final MemberDAO INSTANCE = new MemberDAO();
	}

	public static MemberDAO getInstance() {
		return MemberDAOHolder.INSTANCE;
	}

	private Connection conn = SqlConfig.getConn();

	// 날짜 가져오기
	public String getDate() { // 현재 시간을 가져오는 함수
		String SQL = "SELECT NOW()"; // 현재 시간을 가져오는 MySQL의 문장
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL); // SQL문장을 실행준비 단계로 만든다
			rs = pstmt.executeQuery(); // 실제로 실행했을 때 결과를 가져온다.
			if (rs.next()) { // 결과가 있는경우
				return rs.getString(1); // 현재의 날짜를 그대로 반환한다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return ""; // 빈 문자열을 반환함으로써 데이터베이스 오류를 알려준다.
	}

	// 가입하기
	public int join(String memberID, int groupID, String userID, String mbContent) {
		String SQL = "INSERT INTO member VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			pstmt.setInt(2, groupID);
			pstmt.setString(3, userID);
			pstmt.setInt(4, 1);
			pstmt.setString(5, mbContent);
			pstmt.setString(6, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
		return -1; // 데이터베이스 오류 , primary key인 memberid가 중복됐을때도 오류가 난다.
	}

	// 멤버 리스트 출력하기
	public ArrayList<MemberDTO> getList(int groupID) {
		String SQL = "SELECT * FROM member WHERE groupID= ? AND mbAvailable = 1 ORDER BY groupID DESC";
		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return list;
	}

	// 해당 userID가 가입한 그룹리스트(memberID) 최근에 가입한 순서대로 가져오기
	public ArrayList<MemberDTO> getListByUser(String userID) {
		String SQL = "SELECT * FROM member WHERE userID = ? AND mbAvailable = 1 ORDER BY mbDate DESC";
		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return list;
	}

	// 해당 그룹에 유저가 가입했는지 검사
	public MemberDTO getMemberVO(String userID, int groupID) {
		String SQL = "SELECT * FROM member WHERE userID = ? AND groupID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return null;
	}

	// userID와 groupID로 memberID 구하기
	public MemberDTO getMemberIDS(String userID, int groupID) {
		String SQL = "SELECT memberID FROM member WHERE userID = ? AND groupID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, groupID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				MemberDTO mb = new MemberDTO();
				mb.setMemberID(rs.getString(1));
				return mb;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return null;
	}

	// memberID로 userID, groupID 구하기
	public MemberDTO getUserGroupIDS(String memberID) {
		String SQL = "SELECT userID , groupID FROM member WHERE memberID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				MemberDTO mb = new MemberDTO();
				mb.setUserID(rs.getString(1));
				mb.setGroupID(rs.getInt(2));
				return mb;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return null;
	}

	// 해당 그룹에 유저가 탈퇴했는지 검사
	public MemberDTO getMemberDelVO(String userID, int groupID) {
		String SQL = "SELECT * FROM member WHERE userID = ? AND groupID = ? AND mbAvailable = 0";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return null;
	}

	// 그룹 탈퇴하기 (1. 데이터 삭제)
	public int drop(String memberID) {
		String SQL = "DELETE FROM member WHERE memberID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 그룹 탈퇴하기 (2. mbAvailable = 0 으로 업데이트)
	public int delete(String memberID, String userID, int groupID) {
		String SQL = "UPDATE member SET mbAvailable = 0 WHERE memberID = ? ";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, memberID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			int result = pstmt.executeUpdate(); // userAvailable = 0이 성공적으로 실행되면 0이상의 결과를 result에 저장
			System.out.println(memberID);
			System.out.println(userID);
			System.out.println(groupID);
			pstmt.close();
			if (result > 0) {
				ChatDAO chatDAO = ChatDAO.getInstance();
				List<ChatDTO> chatVOList = chatDAO.getDelChatVOByMbID(userID, groupID);
				for (ChatDTO chatDTO : chatVOList) {
					chatDTO.setChatAvailable(0);
					chatDAO.updateMbChatVO(chatDTO);
				}
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 해당 userID가 가입한 그룹 전체 탈퇴하기
	public int deleteByUser(String userID) {
		String SQL = "UPDATE member SET mbAvailable = 0 WHERE userID = ? ";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 특정 groupID에 해당되는 member수 구하기
	public int getMemberCount(int groupID) {
		String SQL = "SELECT COUNT(*) FROM member WHERE groupID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, groupID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return -1;
	}

	// UserDAO - delete에서 사용되는 메서드
	// delete된 userID와 member의 userID가 같은 값의 리스트를 가져온다.
	public List<MemberDTO> getDelMemberVOByUserID(String userID) {
		List<MemberDTO> memberDTOs = new ArrayList<>();
		String SQL = "SELECT memberID, mbAvailable FROM member WHERE userID = ?";// userID가 가입한 memberID와 탈퇴여부
																					// mbAvailable을 가져온다.
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) { // user 한명이 여러개의 member를 생성하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
				String memberID = rs.getString("memberID");
				int mbAvailable = rs.getInt("mbAvailable");
				// 여기서 다른 속성도 가져올 수 있다.

				// memberDTO 객체를 생성하고 가져온 속성을 객체에 저장한다.
				MemberDTO memberDTO = new MemberDTO();
				memberDTO.setMemberID(memberID);
				memberDTO.setMbAvailable(mbAvailable);

				// memberDTOs list에 memberDTO object 추가
				memberDTOs.add(memberDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return memberDTOs;
	}

	// UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateMemberVO(MemberDTO memberDTO) {
		String SQL = "UPDATE member SET mbAvailable = ? WHERE memberID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, memberDTO.getMbAvailable());
			pstmt.setString(2, memberDTO.getMemberID());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
	}

}
