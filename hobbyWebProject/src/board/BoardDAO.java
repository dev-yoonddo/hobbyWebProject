package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.toogether.session.SqlConfig;

import comment.CommentDAO;
import comment.CommentDTO;
import file.FileDAO;

public class BoardDAO {
	// singleton : Bill Pugh Solution (LazyHolder) 기법
	private BoardDAO() {
	}

	// static 내부 클래스를 이용
	// Holder로 만들어, 클래스가 메모리에 로드되지 않고 getInstance 메서드가 호출되어야 로드됨
	private static class BoardDAOHolder {
		private static final BoardDAO INSTANCE = new BoardDAO();
	}

	public static BoardDAO getInstance() {
		return BoardDAOHolder.INSTANCE;
	}

// singleton : Eager Initialization 기법
//private static BoardDAO instance;
//	public static BoardDAO getInstance(){
//		if (instance == null) {
//			synchronized (BoardDAO.class) {
//				if (instance == null) {
//					instance = new BoardDAO();
//				}
//			}
//		}
//		return instance;
//	}
//	private  

	// 날짜 가져오기
	public String getDate() { // 현재 시간을 가져오는 함수
//		String SQL = "SELECT NOW()"; // 현재 시간을 가져오는 MySQL의 문장
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT NOW()");
			pstmt = conn.prepareStatement(sql.toString()); // SQL문장을 실행준비 단계로 만든다
			rs = pstmt.executeQuery(); // 실제로 실행했을 때 결과를 가져온다.
			if (rs.next()) { // 결과가 있는경우
				return rs.getString(1); // 현재의 날짜를 그대로 반환한다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return ""; // 빈 문자열을 반환함으로써 데이터베이스 오류를 알려준다.
	}

	// 글 번호
	/*
	 * public int getNext() { String SQL =
	 * "SELECT boardID FROM board ORDER BY boardID DESC"; try { PreparedStatement
	 * pstmt = conn.prepareStatement(SQL); rs = pstmt.executeQuery(); if(rs.next())
	 * { return rs.getInt(1) + 1; } return 1; //첫 번째 게시물인 경우 } catch (Exception e) {
	 * e.printStackTrace(); } return -1; //데이터베이스 오류 : 게시물 번호로 적절하지 않은 -1 반환 }
	 */
	// boardID 번호매기기
	public int getNext() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT MAX(boardID) FROM board");
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int maxBoardID = rs.getInt(1);
				return maxBoardID + 1;
			} else {
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return -1;
	}

	// 글 작성하기
	public int write(String boardTitle, String userID, String boardContent, String boardCategory, String filename,
			String fileRealname, String tag) {
		String SQL = "INSERT INTO board VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			int boardID = getNext();
			pstmt.setInt(1, boardID); // board테이블에 저장된 boardID를 file테이블에도 저장하기 위해 지역변수에 저장한다.
			pstmt.setString(2, boardTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardContent);
			pstmt.setInt(6, 1);
			pstmt.setString(7, boardCategory);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			pstmt.setString(10, filename);
			pstmt.setString(11, fileRealname);
			pstmt.setInt(12, 0);
			pstmt.setString(13, tag);
			int result = pstmt.executeUpdate();
			// 성공적으로 수행되고 첨부파일이 존재하면 file테이블에도 데이터를 넣어준다.
			if (result >= 0) {
				if (filename != null) {
					// BoardDTO bdDTO = new BoardDTO();
					FileDAO fileDAO = FileDAO.getInstance();
					int ok = fileDAO.upload2(boardID, filename, fileRealname);
					if (ok >= 0) {// fileDAO의 upload2()메서드가 정상적으로 실행되면
						return 1; // board,file 테이블 모두 업로드 성공
					} else {
						return -2; // 파일 테이블에 업로드 오류
					}
				}
				return result;
			} else {
				// 실행 실패시 -1반환
				return -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("close=========");
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 글 전체 목록 출력 (삭제된 글, LIMIT 제외)
	public ArrayList<BoardDTO> getList() {
		String SQL = "SELECT * FROM board WHERE boardAvailable = 1 ORDER BY boardID DESC";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				board.setBoardCategory(rs.getString(7));
				board.setViewCount(rs.getInt(8));
				board.setHeartCount(rs.getInt(9));
				board.setFilename(rs.getString(10));
				board.setFileRealname(rs.getString(11));
				board.setFileDownCount(rs.getInt(12));
				board.setTag(rs.getString(13));
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// 해당 userID가 작성한 글의 리스트 가져오기
	public ArrayList<BoardDTO> getListByUser(String userID) {
		String SQL = "SELECT * FROM board WHERE userID = ? AND boardAvailable = 1 ORDER BY boardID DESC";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				board.setBoardCategory(rs.getString(7));
				board.setViewCount(rs.getInt(8));
				board.setHeartCount(rs.getInt(9));
				board.setFilename(rs.getString(10));
				board.setFileRealname(rs.getString(11));
				board.setFileDownCount(rs.getInt(12));
				board.setTag(rs.getString(13));
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	// 해당 글의 파일 전체 목록 출력 (삭제된 글, LIMIT 제외)
	public ArrayList<BoardDTO> getFileList(int boardID) {
		String SQL = "SELECT * FROM board WHERE boardID = ? AND boardAvailable = 1 AND filename IS NOT NULL";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				board.setBoardCategory(rs.getString(7));
				board.setViewCount(rs.getInt(8));
				board.setHeartCount(rs.getInt(9));
				board.setFilename(rs.getString(10));
				board.setFileRealname(rs.getString(11));
				board.setFileDownCount(rs.getInt(12));
				board.setTag(rs.getString(13));
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;
	}

	/*
	 * public int countBoardByCategory(String boardCategory) { int count = 0; try {
	 * String SQL = "SELECT COUNT(*) FROM board WHERE boardCategory = ?";
	 * PreparedStatement pstmt = conn.prepareStatement(SQL); pstmt.setString(1,
	 * boardCategory); ResultSet rs = pstmt.executeQuery(); if (rs.next()) { count =
	 * rs.getInt(1); } rs.close(); pstmt.close(); } catch (Exception e) {
	 * e.printStackTrace(); } return count; } 같은 카테고리인 글의 갯수가 10개 이상일 때 다음페이지로 넘기기
	 * public boolean nextPage(int pageNumber, String boardCategory) { String SQL =
	 * "SELECT * FROM board WHERE boardID < ?  AND boardCategory = ? AND boardAvailable = 1"
	 * ; int count = countBoardByCategory(boardCategory); if (count >= 10) { try {
	 * PreparedStatement pstmt = conn.prepareStatement(SQL); pstmt.setInt(1,
	 * getNext() - (pageNumber - 1) * 10); pstmt.setString(2, boardCategory); rs =
	 * pstmt.executeQuery(); if(rs.next()) { return true; } } catch (Exception e) {
	 * e.printStackTrace(); } } return false;
	 * 
	 * }
	 */
	// 작성된 게시글 보기
	public BoardDTO getBoardVO(int boardID) {
		String SQL = "SELECT * FROM board WHERE boardID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				board.setBoardCategory(rs.getString(7));
				int viewCount = rs.getInt(8);
				board.setViewCount(viewCount);
				viewCount++;
				viewCountUpdate(viewCount, boardID);
				board.setHeartCount(rs.getInt(9));
				board.setFilename(rs.getString(10));
				board.setFileRealname(rs.getString(11));
				board.setFileDownCount(rs.getInt(12));
				board.setTag(rs.getString(13));
				return board;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return null;
	}

	// 업데이트
	public int update(int boardID, String boardTitle, String boardContent, String boardCategory, String filename,
			String fileRealname, String tag) {
		String SQL = "UPDATE board SET boardTitle = ?, boardContent = ?, boardCategory = ?, filename = ?, fileRealname = ?, fileDownCount = ?, tag = ? WHERE boardID = ?";
		BoardDTO board = this.getBoardVO(boardID);
		FileDAO fileDAO = FileDAO.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setString(3, boardCategory);
			if (filename != null) {
				// 파일이 새로 업로드되면 파일명을 변경하고 다운로드 횟수를 0으로 초기화한다.
				pstmt.setString(4, filename);
				pstmt.setString(5, fileRealname);
				pstmt.setInt(6, 0);
			} else {
				// 파일을 수정하지 않으면 기존의 다운로드 횟수와 파일명을 그대로 넣어준다.
				pstmt.setString(4, board.getFilename());
				pstmt.setString(5, board.getFileRealname());
				pstmt.setInt(6, board.getFileDownCount());
			}
			pstmt.setString(7, tag);
			pstmt.setInt(8, boardID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			int result = pstmt.executeUpdate();
			// 성공적으로 수행되고 첨부파일이 존재하면 file테이블에도 데이터를 넣어준다.
			if (result >= 0) {
				if (filename != null) {
					// BoardDTO bdDTO = new BoardDTO();
					int ok = fileDAO.upload2(boardID, filename, fileRealname);
					if (ok >= 0) {// fileDAO의 upload2()메서드가 정상적으로 실행되면
						return 1; // board,file 테이블 모두 업로드 성공
					} else {
						return -2; // 파일 테이블에 업로드 오류
					}
				}
				return result;
			} else {
				// 실행 실패시 -1반환
				return -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1; // 데이터베이스 오류

	}

	// 삭제하기 : 글을 삭제하면 글에 달린 댓글들도 삭제하기
	public int delete(int boardID) {
		String SQL = "UPDATE board SET boardAvailable = 0 WHERE boardID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			// 성공적으로 수행했다면 0이상의 결과 반환
			int result = pstmt.executeUpdate();
			if (result > 0) {
				CommentDAO cmtDAO = CommentDAO.getInstance();
				// commentDAO의 geList()사용
				ArrayList<CommentDTO> cmtlist = cmtDAO.getList(boardID);
				for (CommentDTO cmtDTO : cmtlist) {
					cmtDTO.setCmtAvailable(0);
					cmtDAO.updateCommentVO(cmtDTO);
				}
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 해당 userID데이터 삭제하기
	public int deleteByUser(String userID) {
		String SQL = "UPDATE board SET boardAvailable = 0 WHERE userID = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1; // 데이터베이스 오류
	}

	// 좋아요 갯수
	public int heart(int boardID) {
		String SQL = "UPDATE board SET heartCount = heartCount + 1 WHERE boardID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;
	}

	// 좋아요 취소
	public int heartDelete(int boardID) {
		String SQL = "UPDATE board SET heartCount = heartCount - 1 WHERE boardID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;
	}

	// 조회수
	public int viewCountUpdate(int viewCount, int boardID) {
		String SQL = "UPDATE board SET viewCount = ? WHERE boardID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, viewCount);
			pstmt.setInt(2, boardID);
			pstmt.executeUpdate();
			return 1;// insert,delete,update
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;// 데이터베이스 오류
	}

	// 파일 다운로드가 완료되면 다운로드 횟수를 1증가시키는 메소드
	public int download(int boardID, String filename) {
		String SQL = "UPDATE board SET fileDownCount = fileDownCount + 1 WHERE boardID = ? AND filename = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			pstmt.setString(2, filename);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
		return -1;
	}

	// 관리자 공지사항 리스트 가져오기
	public ArrayList<BoardDTO> getNotice() {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		String SQL = "SELECT * FROM board WHERE boardAvailable = 1 AND boardCategory LIKE '%NOTICE%' ORDER BY boardID DESC";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				board.setBoardCategory(rs.getString(7));
				board.setViewCount(rs.getInt(8));
				board.setHeartCount(rs.getInt(9));
				board.setFilename(rs.getString(10));
				board.setFileRealname(rs.getString(11));
				board.setFileDownCount(rs.getInt(12));
				board.setTag(rs.getString(13));
				list.add(board);// list에 해당 인스턴스를 담는다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;// 리스트 반환
	}

	// 검색하기
	// boardAvailable = 1일때만 값 출력 : 게시글을 삭제했을때 & 회원탈퇴 했을때 게시글이 보이지 않는다.
	public ArrayList<BoardDTO> getSearch(String searchField2) {// 특정한 리스트를 받아서 반환
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		String SQL = "SELECT * FROM board WHERE boardAvailable = 1 AND boardCategory";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = SqlConfig.getConn();
			SQL += " LIKE '%" + searchField2 + "%' ORDER BY boardID DESC";
//			StringBuffer sql = new StringBuffer();
//			sql.append(SQL);
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				board.setBoardCategory(rs.getString(7));
				board.setViewCount(rs.getInt(8));
				board.setHeartCount(rs.getInt(9));
				board.setFilename(rs.getString(10));
				board.setFileRealname(rs.getString(11));
				board.setFileDownCount(rs.getInt(12));
				board.setTag(rs.getString(13));
				list.add(board);// list에 해당 인스턴스를 담는다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return list;// 리스트 반환

	}

	// UserDAO - delete에서 사용되는 메서드
	// delete된 userID와 board의 userID가 같은 값의 리스트를 가져온다.
	public List<BoardDTO> getDelBoardVOByUserID(String userID) {
		List<BoardDTO> boardDTOs = new ArrayList<>();
		String SQL = "SELECT boardID, boardAvailable FROM board WHERE userID = ?";// userID가 작성한 board의 boardID와
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; // boardAvailable의 값을 가져온다.
		try {

			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();

			while (rs.next()) { // user 한명이 여러개의 board를 생성하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
				int boardID = rs.getInt("boardID");
				int boardAvailable = rs.getInt("boardAvailable");
				// 여기서 다른 속성도 가져올 수 있다.

				// BoardVO 객체 생성하고 가져온 속성을 BoardVO 객체에 저장한다.
				BoardDTO boardDTO = new BoardDTO();
				boardDTO.setBoardID(boardID);
				boardDTO.setBoardAvailable(boardAvailable);

				// boardVOs list에 boardVO object 추가
				boardDTOs.add(boardDTO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, rs, pstmt);
		}
		return boardDTOs;
	}

	// UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateBoardVO(BoardDTO boardDTO) {
		String SQL = "UPDATE board SET boardAvailable = ? WHERE boardID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = SqlConfig.getConn();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardDTO.getBoardAvailable());
			pstmt.setInt(2, boardDTO.getBoardID());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			SqlConfig.closeResources(conn, null, pstmt);
		}
	}
}
