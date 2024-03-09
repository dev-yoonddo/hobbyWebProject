package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.toogether.session.SqlConfig;

public class ScheduleDAO {
	// singleton : Bill Pugh Solution (LazyHolder) 기법
	private ScheduleDAO() {
	}

	// static 내부 클래스를 이용
	// Holder로 만들어, 클래스가 메모리에 로드되지 않고 getInstance 메서드가 호출되어야 로드됨
	private static class ScheduleDAOHolder {
		private static final ScheduleDAO INSTANCE = new ScheduleDAO();
	}

	public static ScheduleDAO getInstance() {
		return ScheduleDAOHolder.INSTANCE;
	}

	// 스케줄 저장
	public int registSchedule(String userID, String spotName, int skedYear, int skedMonth, int skedDay,
			String skedContent) {
		String SQL = "INSERT INTO schedule VALUES (?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			// conn = SqlConfig.getConn(); pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, spotName);
			pstmt.setInt(3, skedYear);
			pstmt.setInt(4, skedMonth);
			pstmt.setInt(5, skedDay);
			pstmt.setString(6, skedContent);
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;
	}

	// 저장된 스케줄 리스트 모두 가져오기
	public ArrayList<ScheduleDTO> getScheduleList() {
		String SQL = "SELECT * FROM schedule ORDER BY skedYear DESC, skedMonth DESC , skedDay DESC";
		ArrayList<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ScheduleDTO sked = new ScheduleDTO();
				sked.setUserID(rs.getString(1));
				sked.setSpotName(rs.getString(2));
				sked.setSkedYear(rs.getInt(3));
				sked.setSkedMonth(rs.getInt(4));
				sked.setSkedDay(rs.getInt(5));
				sked.setSkedContent(rs.getString(6));
				sked.setSkedAvailable(rs.getInt(7));
				list.add(sked);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// 저장된 스케줄 리스트 모두 가져오기
	public ArrayList<ScheduleDTO> getScheduleListBySpot(String spotName) {
		String SQL = "SELECT * FROM schedule WHERE spotName = ?";
		ArrayList<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, spotName);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ScheduleDTO sked = new ScheduleDTO();
				sked.setUserID(rs.getString(1));
				sked.setSpotName(rs.getString(2));
				sked.setSkedYear(rs.getInt(3));
				sked.setSkedMonth(rs.getInt(4));
				sked.setSkedDay(rs.getInt(5));
				sked.setSkedContent(rs.getString(6));
				sked.setSkedAvailable(rs.getInt(7));
				list.add(sked);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// 지정된 날짜와 일치하는 스케줄 리스트 가져오기
	public ArrayList<ScheduleDTO> getScheduleListByTime(String spotName, int skedYear, int skedMonth, int skedDay) {
		String SQL = "SELECT * FROM schedule WHERE spotName = ? AND skedYear = ? AND skedMonth = ? AND skedDay = ?";
		ArrayList<ScheduleDTO> list = new ArrayList<ScheduleDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, spotName);
			pstmt.setInt(2, skedYear);
			pstmt.setInt(3, skedMonth);
			pstmt.setInt(4, skedDay);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ScheduleDTO sked = new ScheduleDTO();
				sked.setUserID(rs.getString(1));
				sked.setSpotName(rs.getString(2));
				sked.setSkedYear(rs.getInt(3));
				sked.setSkedMonth(rs.getInt(4));
				sked.setSkedDay(rs.getInt(5));
				sked.setSkedContent(rs.getString(6));
				sked.setSkedAvailable(rs.getInt(7));
				list.add(sked);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// UserDAO - delete에서 사용되는 메서드
	// delete된 userID와 schedule의 userID가 같은 값의 리스트를 가져온다.
	public List<ScheduleDTO> getDelScheduleByUserID(String userID) {
		List<ScheduleDTO> list = new ArrayList<>();
		String SQL = "SELECT skedAvailable FROM schedule WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int skedAvailable = rs.getInt("skedAvailable");
				ScheduleDTO skedDTO = new ScheduleDTO();
				skedDTO.setSkedAvailable(skedAvailable);
				skedDTO.setUserID(userID);
				list.add(skedDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateSkedVO(ScheduleDTO skedDTO) {
		String SQL = "UPDATE schedule SET skedAvailable = ? WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, skedDTO.getSkedAvailable());
			pstmt.setString(2, skedDTO.getUserID());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
	}
}
