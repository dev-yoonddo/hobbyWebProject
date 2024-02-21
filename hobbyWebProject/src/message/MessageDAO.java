package message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.toogether.session.SqlConfig;

public class MessageDAO {
	// singleton : Bill Pugh Solution (LazyHolder) 기법
	private MessageDAO() {
	}

	// static 내부 클래스를 이용
	// Holder로 만들어, 클래스가 메모리에 로드되지 않고 getInstance 메서드가 호출되어야 로드됨
	private static class MessageDAOHolder {
		private static final MessageDAO INSTANCE = new MessageDAO();
	}

	public static MessageDAO getInstance() {
		return MessageDAOHolder.INSTANCE;
	}

	private Connection conn = SqlConfig.getConn();

	// msgID 번호매기기
	public int getNext() {
		String SQL = "SELECT MAX(msgID) FROM message";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int maxMsgID = rs.getInt(1);
				return maxMsgID + 1;
			} else {
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return -1;
	}

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

	// 메시지 읽음 (getMsgVO에서 해도 된다)
	public int msgCheckUpdate(int msgID, String toUserID) {
		String SQL = "UPDATE message SET msgCheck = 1 WHERE msgID = ? AND toUserID = ?"; // msgID만 넣으면 보낸사람이 읽어도 읽음으로
																							// 처리되기 때문에 toUserID ==
																							// userID일 때만 읽음처리한다.
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, msgID);
			pstmt.setString(2, toUserID);
			return pstmt.executeUpdate();// insert,delete,update
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
		return -1;// 데이터베이스 오류
	}

	// 메시지 전송하기
	public int send(String userID, String toUserID, int groupID, String msgTitle, String msgContent) {
		String SQL = "INSERT INTO message VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, toUserID);
			pstmt.setInt(4, groupID);
			pstmt.setString(5, msgTitle);
			pstmt.setString(6, msgContent);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 1);
			pstmt.setString(9, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 해당 유저에게 온 메시지 전체 리스트 (30일 전)
	public ArrayList<MessageDTO> getMessageList(String toUserID) {
		String SQL = "SELECT * FROM message WHERE toUserID = ? AND msgAvailable = 1 ORDER BY msgDate DESC";
		ArrayList<MessageDTO> list = new ArrayList<MessageDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toUserID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MessageDTO msg = new MessageDTO();
				// 메시지 수신 날짜 판별 메서드 사용
				long result = msgListDateCheck(rs.getInt("msgID"), rs.getString("msgDate"));
				if (result == 1) {
					msg.setMsgID(rs.getInt(1));
					msg.setUserID(rs.getString(2));
					msg.setToUserID(rs.getString(3));
					msg.setGroupID(rs.getInt(4));
					msg.setMsgTitle(rs.getString(5));
					msg.setMsgContent(rs.getString(6));
					msg.setMsgCheck(rs.getInt(7));
					msg.setMsgAvailable(rs.getInt(8));
					msg.setMsgDate(rs.getString(9));
					list.add(msg);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return list;
	}

	// 받은메시지가 며칠 전에 수신된 메시지인지 판별 후 30일 이상이면 삭제
	public long msgListDateCheck(int msgID, String date) {
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date data = dateFormat.parse(date); // 메시지 리스트의 날짜 정보를 가져와서 데이터형식 포맷 후
			long msgDate = data.getTime(); // getTime으로 밀리초단위의 시간을 가져온다.
			Date date2 = new Date(); // 현재시간을 가져온다.
			long currDate = date2.getTime();

			// 현재시간에서 메시지수신시간을 뺀 후 24*60*60*1000 (== 1일)로 나눈다.
			long checkDate = (currDate - msgDate) / (24 * 60 * 60 * 1000);
			// System.out.println(checkDate);
			// 1일로 나눴을때 30 이상이면 메시지가 수신된지 30일 지났음을 의미하므로 삭제한다.
			if (checkDate > 30) {
				delete(msgID);
			} else {
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	// 해당 유저가 보낸 메시지 전체 리스트 (userID가 내 아이디랑 일치하는 데이터)
	public ArrayList<MessageDTO> getSendMessageList(String userID) {
		String SQL = "SELECT * FROM message WHERE userID = ? AND msgAvailable = 1 ORDER BY msgDate DESC";
		ArrayList<MessageDTO> list = new ArrayList<MessageDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				long result = msgListDateCheck(rs.getInt("msgID"), rs.getString("msgDate"));
				MessageDTO msg = new MessageDTO();
				if (result == 1) {
					msg.setMsgID(rs.getInt(1));
					msg.setUserID(rs.getString(2));
					msg.setToUserID(rs.getString(3));
					msg.setGroupID(rs.getInt(4));
					msg.setMsgTitle(rs.getString(5));
					msg.setMsgContent(rs.getString(6));
					msg.setMsgCheck(rs.getInt(7));
					msg.setMsgAvailable(rs.getInt(8));
					msg.setMsgDate(rs.getString(9));
					list.add(msg);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return list;
	}

	// 메시지 삭제하기 (msgAvailable = 0 으로 업데이트)
	public int delete(int msgID) {
		String SQL = "UPDATE message SET msgAvailable = 0 WHERE msgID = ? ";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, msgID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 삭제되지않은 메시지 갯수 구하기
	public int msgCount(String toUserID, String userID) {
		String SQL = "SELECT COUNT(*) FROM message WHERE toUserID = ? AND userID = ? ";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 받은 메시지 삭제하기 : toUserID == userID 이면 받은메시지이다.
	public int deleteRcvMsg(String userID) {
		String SQL = "UPDATE message SET msgAvailable = 0 WHERE toUserID = ? ";
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

	// 받은 메시지 삭제하기
	public int deleteSendMsg(String userID) {
		String SQL = "UPDATE message SET msgAvailable = 0 WHERE userID = ? ";
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

	// 메시지 전체 삭제하기
	public int deleteAllMsgByUser(String userID) {
		try {
			deleteRcvMsg(userID);
			deleteSendMsg(userID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	// 로그인한 userID값을 toUserID값에 대입해 해당 그룹멤버가 보낸 메세지중 안읽은 메세지를 가져온다.
	public ArrayList<MessageDTO> getMessageCheck(String toUserID, int groupID) {
		String SQL = "SELECT * FROM message WHERE toUserID = ? AND groupID = ? AND msgAvailable = 1 AND msgCheck = 0 ORDER BY msgDate DESC";
		ArrayList<MessageDTO> checklist = new ArrayList<MessageDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toUserID);
			pstmt.setInt(2, groupID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				long result = msgListDateCheck(rs.getInt("msgID"), rs.getString("msgDate"));
				MessageDTO msg = new MessageDTO();
				if (result == 1) {
					msg.setMsgID(rs.getInt(1));
					msg.setUserID(rs.getString(2));
					msg.setToUserID(rs.getString(3));
					msg.setGroupID(rs.getInt(4));
					msg.setMsgTitle(rs.getString(5));
					msg.setMsgContent(rs.getString(6));
					msg.setMsgCheck(rs.getInt(7));
					msg.setMsgAvailable(rs.getInt(8));
					msg.setMsgDate(rs.getString(9));
					checklist.add(msg);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return checklist;
	}

	// 내가 만든 그룹의 멤버인 userID에게 온 메세지 리스트 전체 가져오기
	public ArrayList<MessageDTO> getMsgList(String toUserID, int groupID) {
		String SQL = "SELECT * FROM message WHERE toUserID = ? AND groupID = ? AND msgAvailable = 1 ORDER BY msgDate DESC";
		ArrayList<MessageDTO> msglist = new ArrayList<MessageDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toUserID);
			pstmt.setInt(2, groupID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				long result = msgListDateCheck(rs.getInt("msgID"), rs.getString("msgDate"));
				MessageDTO msg = new MessageDTO();
				if (result == 1) {
					msg.setMsgID(rs.getInt(1));
					msg.setUserID(rs.getString(2));
					msg.setToUserID(rs.getString(3));
					msg.setGroupID(rs.getInt(4));
					msg.setMsgTitle(rs.getString(5));
					msg.setMsgContent(rs.getString(6));
					msg.setMsgCheck(rs.getInt(7));
					msg.setMsgAvailable(rs.getInt(8));
					msg.setMsgDate(rs.getString(9));
					msglist.add(msg);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return msglist;
	}

	// 한 개의 메시지 정보
	public MessageDTO getMsgVO(int msgID) {
		String SQL = "SELECT * FROM message WHERE msgID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, msgID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				MessageDTO msg = new MessageDTO();
				msg.setMsgID(rs.getInt(1));
				msg.setUserID(rs.getString(2));
				msg.setToUserID(rs.getString(3));
				msg.setGroupID(rs.getInt(4));
				msg.setMsgTitle(rs.getString(5));
				msg.setMsgContent(rs.getString(6));
				msg.setMsgCheck(rs.getInt(7));
				msg.setMsgAvailable(rs.getInt(8));
				msg.setMsgDate(rs.getString(9));

				/*
				 * 메시지 조회 처리 다른 방법 int viewCount=rs.getInt(8); board.setViewCount(viewCount);
				 * viewCount++; viewCountUpdate(viewCount,boardID);
				 */
				return msg;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return null;
	}

	// UserDAO - delete에서 사용되는 메서드
	// delete된 userID와 message의 userID가 같은 값의 리스트를 가져온다.
	public List<MessageDTO> getDelMsgVOByUserID(String userID) {
		List<MessageDTO> messageDTOs = new ArrayList<>();
		String SQL = "SELECT msgID, msgAvailable FROM message WHERE userID = ?";// userID가 전송한 msgID와 삭제여부 msgAvailable을
																				// 가져온다.
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) { // user 한명이 여러개의 member를 생성하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
				int msgID = rs.getInt("msgID");
				int msgAvailable = rs.getInt("msgAvailable");
				// 여기서 다른 속성도 가져올 수 있다.

				// memberDTO 객체를 생성하고 가져온 속성을 객체에 저장한다.
				MessageDTO messageDTO = new MessageDTO();
				messageDTO.setMsgID(msgID);
				messageDTO.setMsgAvailable(msgAvailable);

				// memberDTOs list에 memberDTO object 추가
				messageDTOs.add(messageDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, rs, pstmt);
		}
		return messageDTOs;
	}

	// UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateMsgVO(MessageDTO messageDTO) {
		String SQL = "UPDATE message SET msgAvailable = ? WHERE msgID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, messageDTO.getMsgAvailable());
			pstmt.setInt(2, messageDTO.getMsgID());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(null, null, pstmt);
		}
	}
}
