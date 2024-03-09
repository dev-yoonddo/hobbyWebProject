package location;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.toogether.session.SqlConfig;

public class LocationDAO {

	// singleton : Bill Pugh Solution (LazyHolder) 기법
	private LocationDAO() {
	}

	// static 내부 클래스를 이용
	// Holder로 만들어, 클래스가 메모리에 로드되지 않고 getInstance 메서드가 호출되어야 로드됨
	private static class LocationDAOHolder {
		private static final LocationDAO INSTANCE = new LocationDAO();
	}

	public static LocationDAO getInstance() {
		return LocationDAOHolder.INSTANCE;
	}

	// 위치 정보 저장
	public int regist(String userID, String spotName, String address, Double latitude, Double longitude) {
		String SQL = "INSERT INTO location VALUES (?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			// conn = SqlConfig.getConn(); pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, spotName);
			pstmt.setString(3, address);
			pstmt.setDouble(4, latitude);
			pstmt.setDouble(5, longitude);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;
	}

	// 해당 이름의 위치 정보 보기
	public LocationDTO getLocationVO(String spotName) {
		String SQL = "SELECT * FROM location WHERE spotName = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, spotName);// 물음표
			rs = pstmt.executeQuery();// select
			if (rs.next()) {// 결과가 있다면
				LocationDTO loc = new LocationDTO();
				loc.setUserID(rs.getString(1));
				loc.setSpotName(rs.getString(2));
				loc.setAddress(rs.getString(3));
				loc.setLatitude(rs.getDouble(4));
				loc.setLongitude(rs.getDouble(5));
				loc.setCrewCount(rs.getInt(6));
				loc.setSpotAvailable(rs.getInt(7));
				return loc;// 6개의 항목을 user인스턴스에 넣어 반환한다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return null;
	}

	// 유저가 생성한 스팟 리스트 가져오기
	public ArrayList<LocationDTO> getLocationVOByUserID(String userID) {
		String SQL = "SELECT * FROM location WHERE userID = ?";
		ArrayList<LocationDTO> list = new ArrayList<LocationDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);// 물음표
			rs = pstmt.executeQuery();// select
			while (rs.next()) {
				LocationDTO loc = new LocationDTO();
				loc.setUserID(rs.getString(1));
				loc.setSpotName(rs.getString(2));
				loc.setAddress(rs.getString(3));
				loc.setLatitude(rs.getDouble(4));
				loc.setLongitude(rs.getDouble(5));
				loc.setCrewCount(rs.getInt(6));
				loc.setSpotAvailable(rs.getInt(7));
				list.add(loc);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return null;
	}

	// 스팟 네임, 주소 리스트 출력하기
	public ArrayList<LocationDTO> getNameAdList() {
		String SQL = "SELECT spotName , address FROM location";
		ArrayList<LocationDTO> list = new ArrayList<LocationDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {// 결과가 있다면
				LocationDTO loc = new LocationDTO();
				loc.setSpotName(rs.getString(1));
				loc.setAddress(rs.getString(2));
				list.add(loc);
			}
			// System.out.println(list);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// 저장된 스팟 정보 리스트 출력하기
	public ArrayList<LocationDTO> getSpotInfoList() {
		String SQL = "SELECT * FROM location WHERE spotAvailable = 1";
		ArrayList<LocationDTO> list = new ArrayList<LocationDTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {// 결과가 있다면
				LocationDTO loc = new LocationDTO();
				loc.setUserID(rs.getString(1));
				loc.setSpotName(rs.getString(2));
				loc.setAddress(rs.getString(3));
				loc.setLatitude(rs.getDouble(4));
				loc.setLongitude(rs.getDouble(5));
				loc.setCrewCount(rs.getInt(6));
				loc.setSpotAvailable(rs.getInt(7));
				list.add(loc);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// spot 참여하기를 클릭하면 memberCount + 1
	public int spotJoin(String spotName) {
		String SQL = "UPDATE location SET crewCount = crewCount + 1 WHERE spotName = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, spotName);
			// 성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// UserDAO - delete에서 사용되는 메서드
	// delete된 userID와 spot의 userID가 같은 값의 리스트를 가져온다.
	public List<LocationDTO> getDelSpotVOByUserID(String userID) {
		List<LocationDTO> locationDTOs = new ArrayList<>();
		String SQL = "SELECT spotAvailable , userID FROM location WHERE userID = ?";// userID가 가입한 crew의 탈퇴여부
																					// crewAvailable을 가져온다.
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) { // user 한명이 여러개의 crew를 가입하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
				int spotAvailable = rs.getInt("spotAvailable");
				String id = rs.getString("userID");
				// 여기서 다른 속성도 가져올 수 있다.

				LocationDTO locationDTO = new LocationDTO();
				locationDTO.setSpotAvailable(spotAvailable);
				locationDTO.setUserID(id);
				locationDTOs.add(locationDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return locationDTOs;
	}

	// UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateSpotVO(LocationDTO locationDTO) {
		String SQL = "UPDATE location SET spotAvailable = ? WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, locationDTO.getSpotAvailable());
			pstmt.setString(2, locationDTO.getUserID());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
	}
}
