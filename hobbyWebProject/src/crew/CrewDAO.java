package crew;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.toogether.session.SqlConfig;

public class CrewDAO {
	// singleton : Bill Pugh Solution (LazyHolder) 기법
	private CrewDAO() {
	}

	// static 내부 클래스를 이용
	// Holder로 만들어, 클래스가 메모리에 로드되지 않고 getInstance 메서드가 호출되어야 로드됨
	private static class CrewDAOHolder {
		private static final CrewDAO INSTANCE = new CrewDAO();
	}

	public static CrewDAO getInstance() {
		return CrewDAOHolder.INSTANCE;
	}

	// 멤버 정보 저장
	public int joinCrew(String userID, String spotName) {
		String SQL = "INSERT INTO crew VALUES (?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			// conn = SqlConfig.getConn(); pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, spotName);
			pstmt.setInt(3, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;
	}

	// userID의 리스트를 가져와서 이미 가입한 그룹인지 확인
	public ArrayList<CrewDTO> getJoinedList(String userID, String spotName) {
		String SQL = "SELECT * FROM crew WHERE userID = ? AND spotName = ?";
		ArrayList<CrewDTO> list = new ArrayList<CrewDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, spotName);
			rs = pstmt.executeQuery();
			while (rs.next()) {// 결과가 있다면
				CrewDTO crew = new CrewDTO();
				crew.setUserID(rs.getString(1));
				crew.setSpotName(rs.getString(2));
				crew.setCrewAvailable(rs.getInt(3));
				list.add(crew);
			}
			// System.out.println(list);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// userID와 spotName을 받아 정상적으로 데이터가 저장되었는지 검사
	public CrewDTO getCheckRegist(String userID, String spotName) {
		String SQL = "SELECT * FROM crew WHERE userID = ? AND spotName = ? AND crewAvailable = 1";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, spotName);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				CrewDTO crew = new CrewDTO();
				crew.setUserID(rs.getString(1));
				crew.setSpotName(rs.getString(2));
				crew.setCrewAvailable(rs.getInt(3));
				return crew;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return null;
	}

	// UserDAO - delete에서 사용되는 메서드
	// delete된 userID와 crew의 userID가 같은 값의 리스트를 가져온다.
	public List<CrewDTO> getDelCrewVOByUserID(String userID) {
		List<CrewDTO> crewDTOs = new ArrayList<>();
		String SQL = "SELECT crewAvailable , userID FROM crew WHERE userID = ?";// userID가 가입한 crew의 탈퇴여부 crewAvailable을
																				// 가져온다.
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) { // user 한명이 여러개의 crew를 가입하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
				int crewAvailable = rs.getInt("crewAvailable");
				String id = rs.getString("userID");
				// 여기서 다른 속성도 가져올 수 있다.

				CrewDTO crewDTO = new CrewDTO();
				crewDTO.setCrewAvailable(crewAvailable);
				crewDTO.setUserID(id);
				crewDTOs.add(crewDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return crewDTOs;
	}

	// UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateCrewVO(CrewDTO crewDTO) {
		String SQL = "UPDATE crew SET crewAvailable = ? WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, crewDTO.getCrewAvailable());
			pstmt.setString(2, crewDTO.getUserID());
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
	}
}
