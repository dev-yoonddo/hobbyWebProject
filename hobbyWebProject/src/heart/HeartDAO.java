package heart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.toogether.session.SqlConfig;

public class HeartDAO {
	// singleton : Bill Pugh Solution (LazyHolder) 기법
	private HeartDAO() {
	}

	// static 내부 클래스를 이용
	// Holder로 만들어, 클래스가 메모리에 로드되지 않고 getInstance 메서드가 호출되어야 로드됨
	private static class HeartDAOHolder {
		private static final HeartDAO INSTANCE = new HeartDAO();
	}

	public static HeartDAO getInstance() {
		return HeartDAOHolder.INSTANCE;
	}

	public int heart(String userID, int boardID) {
		String SQL = "INSERT INTO heart VALUES (?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, boardID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;// 데이터베이스 오류
	}

	public int delete(String userID, int boardID) {
		String SQL = "DELETE FROM heart WHERE userID = ? AND boardID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, boardID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;// 데이터베이스 오류
	}

	public HeartDTO getHeartVO(int boardID) {
		String SQL = "SELECT * FROM heart WHERE boardID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				HeartDTO heart = new HeartDTO();
				heart.setUserID(rs.getString(1));
				heart.setBoardID(rs.getInt(2));
				return heart;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return null;
	}

	public HeartDTO getHeartVOByUser(String userID, int boardID) {
		String SQL = "SELECT * FROM heart WHERE userID = ? AND boardID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, boardID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				HeartDTO heart = new HeartDTO();
				heart.setUserID(rs.getString(1));
				heart.setBoardID(rs.getInt(2));
				return heart;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return null;
	}

	public ArrayList<HeartDTO> getHeartList(int boardID) {
		String SQL = "SELECT * FROM heart WHERE boardID = ? AND userID IS NOT NULL"; // boardID가 일치하고 userID가 null이 아닌
																						// heart의 리스트를 가져온다
		ArrayList<HeartDTO> hearts = new ArrayList<HeartDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				HeartDTO heart = new HeartDTO();
				heart.setUserID(rs.getString(1));// heart메서드와 동일한 순서로 넣어야 정상적인 결과가 나온다.
				heart.setBoardID(rs.getInt(2));
				hearts.add(heart);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return hearts;
	}
}