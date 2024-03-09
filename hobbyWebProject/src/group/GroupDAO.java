package group;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.toogether.session.SqlConfig;

public class GroupDAO {
	// singleton : Bill Pugh Solution (LazyHolder) 기법
	private GroupDAO() {
	}

	// static 내부 클래스를 이용
	// Holder로 만들어, 클래스가 메모리에 로드되지 않고 getInstance 메서드가 호출되어야 로드됨
	private static class GroupDAOHolder {
		private static final GroupDAO INSTANCE = new GroupDAO();
	}

	public static GroupDAO getInstance() {
		return GroupDAOHolder.INSTANCE;
	}

	private Connection conn = SqlConfig.getConn();

	// GroupID 번호매기기
	// SQL명령어 중 GROUP 이 있기 때문에 백틱 ``을 사용해 구분을 해줘야한다.
	public int getNext() {
		String SQL = "SELECT groupID FROM `group` ORDER BY groupID DESC";// 마지막 게시물 반환
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 그룹인 경우
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return -1;
	}

	// 그룹 생성하기
	public int createGroup(String groupName, String groupPassword, String userID, int groupNoP) {
		String SQL = "INSERT INTO `group` VALUES(?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, groupName);
			pstmt.setString(3, groupPassword);
			pstmt.setString(4, userID);
			pstmt.setInt(5, 1);
			pstmt.setInt(6, groupNoP);
			pstmt.setString(7, null);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;
	}

	// 모든 그룹 리스트 출력하기 (조건x)
	public ArrayList<GroupDTO> getList() {
		String SQL = "SELECT * FROM `group` ORDER BY groupID desc";
		ArrayList<GroupDTO> list = new ArrayList<GroupDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GroupDTO grp = new GroupDTO();
				grp.setGroupID(rs.getInt(1));
				grp.setGroupName(rs.getString(2));
				grp.setGroupPassword(rs.getString(3));
				grp.setUserID(rs.getString(4));
				grp.setGroupAvailable(rs.getInt(5));
				grp.setGroupNoP(rs.getInt(6));
				grp.setGroupNotice(rs.getString(7));
				list.add(grp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// 해당 userID의 groupList 가져오기 (조건 x)
	public ArrayList<GroupDTO> getListByUser(String userID) {
		String SQL = "SELECT * FROM `group` WHERE userID = ? ORDER BY groupID desc";
		ArrayList<GroupDTO> list = new ArrayList<GroupDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GroupDTO grp = new GroupDTO();
				grp.setGroupID(rs.getInt(1));
				grp.setGroupName(rs.getString(2));
				grp.setGroupPassword(rs.getString(3));
				grp.setUserID(rs.getString(4));
				grp.setGroupAvailable(rs.getInt(5));
				grp.setGroupNoP(rs.getInt(6));
				grp.setGroupNotice(rs.getString(7));
				list.add(grp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// 해당 userID의 groupList 가져오기 (활동중인 그룹만)
	public ArrayList<GroupDTO> getListActiveByUser(String userID) {
		String SQL = "SELECT * FROM `group` WHERE userID = ? AND groupAvailable = 1 ORDER BY groupID desc";
		ArrayList<GroupDTO> list = new ArrayList<GroupDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GroupDTO grp = new GroupDTO();
				grp.setGroupID(rs.getInt(1));
				grp.setGroupName(rs.getString(2));
				grp.setGroupPassword(rs.getString(3));
				grp.setUserID(rs.getString(4));
				grp.setGroupAvailable(rs.getInt(5));
				grp.setGroupNoP(rs.getInt(6));
				grp.setGroupNotice(rs.getString(7));
				list.add(grp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// 하나의 그룹 정보 가져오기
	public GroupDTO getGroupVO(int groupID) {
		String SQL = "SELECT * FROM `group` WHERE groupID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, groupID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				GroupDTO grp = new GroupDTO();
				grp.setGroupID(rs.getInt(1));
				grp.setGroupName(rs.getString(2));
				grp.setGroupPassword(rs.getString(3));
				grp.setUserID(rs.getString(4));
				grp.setGroupAvailable(rs.getInt(5));
				grp.setGroupNoP(rs.getInt(6));
				grp.setGroupNotice(rs.getString(7));
				return grp;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return null;
	}
	/*
	 * public boolean nextPage(int pageNumber) {//페이지 처리를 위한 함수 String
	 * SQL="SELECT * from `group` where groupID < ?"; try { PreparedStatement
	 * pstmt=conn.prepareStatement(SQL); pstmt.setInt(1,
	 * getNext()-(pageNumber-1)*10); rs=pstmt.executeQuery(); if(rs.next()) { return
	 * true;//다음 페이지로 넘어갈 수 있음 } } catch(Exception e) { e.printStackTrace(); }
	 * return false; }
	 */

	// 공지사항 등록하기
	public int noticeUpdate(int groupID, String groupNotice) {
		String SQL = "UPDATE `group` SET groupNotice = ? WHERE groupID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, groupNotice);
			pstmt.setInt(2, groupID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			int result = pstmt.executeUpdate();
			// System.out.println(result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 삭제하기
	public int delete(int groupID) {
		String SQL = "UPDATE `group` SET groupAvailable = 0 WHERE groupID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, groupID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 해당 userID데이터 삭제하기
	public int deleteByUser(String userID) {
		String SQL = "UPDATE `group` SET groupAvailable = 0 WHERE userID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}
	/*
	 * public String getGroupPW(int groupID){ String SQL =
	 * "SELECT groupPassword FROM `group` WHERE groupID = ?"; try {
	 * PreparedStatement pstmt=conn.prepareStatement(SQL); pstmt.setInt(1, groupID);
	 * rs=pstmt.executeQuery(); if (rs.next()) { String password =
	 * rs.getString("groupPassword"); return password; } } catch(Exception e) {
	 * e.printStackTrace(); } return ""; }
	 */

	// UserDAO - delete에서 사용되는 메서드
	// delete된 userID와 board의 userID가 같은 값의 리스트를 가져온다.
	public List<GroupDTO> getDelGroupVOByUserID(String userID) {
		List<GroupDTO> groupDTOs = new ArrayList<>();
		String SQL = "SELECT groupID, groupAvailable FROM `group` WHERE userID = ?";// userID가 작성한 board의 boardID와
																					// boardAvailable의 값을 가져온다.
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();

			while (rs.next()) { // user 한명이 여러개의 board를 생성하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
				int groupID = rs.getInt("groupID");
				int groupAvailable = rs.getInt("groupAvailable");
				// 여기서 다른 속성도 가져올 수 있다.

				// BoardVO 객체 생성하고 가져온 속성을 BoardVO 객체에 저장한다.
				GroupDTO groupDTO = new GroupDTO();
				groupDTO.setGroupID(groupID);
				groupDTO.setGroupAvailable(groupAvailable);

				// boardVOs list에 boardVO object 추가
				groupDTOs.add(groupDTO);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return groupDTOs;
	}

	// UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateGroupVO(GroupDTO groupDTO) {
		String SQL = "UPDATE `group` SET groupAvailable = ? WHERE groupID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, groupDTO.getGroupAvailable());
			pstmt.setInt(2, groupDTO.getGroupID());
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
	}
}
