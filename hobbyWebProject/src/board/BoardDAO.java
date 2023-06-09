package board;

import java.sql.Connection;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import comment.CommentDAO;
import comment.CommentDTO;

public class BoardDAO {
	private Connection conn; //자바와 데이터베이스 연결
	private ResultSet rs; //결과값 받아오기
	
	
	public BoardDAO() {
		try {
		 	String dbURL = "jdbc:mysql://database-1.cxujakzvpvip.ap-southeast-2.rds.amazonaws.com:3306/hobbyWebProject?useUnicode=true&characterEncoding=UTF-8";
		 	String dbID = "root";
		 	String dbPassword = "qlalf9228?";
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
	//글 번호
	/*public int getNext() {
		String SQL = "SELECT boardID FROM board ORDER BY boardID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 : 게시물 번호로 적절하지 않은 -1 반환
	}*/
	//boardID 번호매기기
	public int getNext() {
	    String SQL = "SELECT MAX(boardID) FROM board";
	    try {
	    	PreparedStatement pstmt = conn.prepareStatement(SQL);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            int maxBoardID = rs.getInt(1);
	            return maxBoardID + 1;
	        } else {
            return 1;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;
	}
	//글 작성하기
	public int write(String boardTitle, String userID, String boardContent, String boardCategory, int viewCount, int heartCount) {
		String SQL = "INSERT INTO board VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, boardTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardContent);
			pstmt.setInt(6, 1);
			pstmt.setString(7, boardCategory);
			pstmt.setInt(8, viewCount);
			pstmt.setInt(9, heartCount);

			//성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//글 전체 목록 출력 (삭제된 글, LIMIT 제외)
	public ArrayList<BoardDTO> getList(){
		String SQL = "SELECT * FROM board WHERE boardAvailable = 1 ORDER BY boardID DESC";
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
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
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	//해당 userID가 작성한 글의 리스트 가져오기
	public ArrayList<BoardDTO> getListByUser(String userID){
		String SQL = "SELECT * FROM board WHERE userID = ? AND boardAvailable = 1 ORDER BY boardID DESC";
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
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
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	
	/*public int countBoardByCategory(String boardCategory) {
	    int count = 0;
	    try {
	        String SQL = "SELECT COUNT(*) FROM board WHERE boardCategory = ?";
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, boardCategory);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	        rs.close();
	        pstmt.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;
	}
	같은 카테고리인 글의 갯수가 10개 이상일 때 다음페이지로 넘기기
	public boolean nextPage(int pageNumber, String boardCategory) {
		String SQL = "SELECT * FROM board WHERE boardID < ?  AND boardCategory = ? AND boardAvailable = 1";
		int count = countBoardByCategory(boardCategory);
	    if (count >= 10) {
    	 try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			pstmt.setString(2, boardCategory);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        }
		return false; 
		
	}*/
	//작성된 게시글 보기
	public BoardDTO getBoardVO(int boardID) {
		String SQL = "SELECT * FROM board WHERE boardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				board.setBoardCategory(rs.getString(7));
				int viewCount=rs.getInt(8);
				board.setViewCount(viewCount);
				viewCount++;
				viewCountUpdate(viewCount,boardID);
	
				board.setHeartCount(rs.getInt(9));
				return board;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	//업데이트
	public int update(int boardID, String boardTitle, String boardContent, String boardCategory) {
		String SQL = "UPDATE board SET boardTitle = ?, boardContent = ?, boardCategory = ? WHERE boardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setString(3, boardCategory);
			pstmt.setInt(4, boardID);
			//성공적으로 수행했다면 0이상의 결과 반환
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류

	}
	//삭제하기 : 글을 삭제하면 글에 달린 댓글들도 삭제하기
	public int delete(int boardID) {
		String SQL = "UPDATE board SET boardAvailable = 0 WHERE boardID = ? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			//성공적으로 수행했다면 0이상의 결과 반환
			int result = pstmt.executeUpdate();
			pstmt.close();
			if(result > 0) {
				CommentDAO cmtDAO = new CommentDAO();
				//commentDAO의 geList()사용
				ArrayList<CommentDTO> cmtlist = cmtDAO.getList(boardID);
				for(CommentDTO cmtDTO : cmtlist) {
					cmtDTO.setCmtAvailable(0);
					cmtDAO.updateCommentVO(cmtDTO);
				}
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	//해당 userID데이터 삭제하기
		public int deleteByUser(String userID) {
			String SQL = "UPDATE board SET boardAvailable = 0 WHERE userID = ? ";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				//성공적으로 수행했다면 0이상의 결과 반환
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
	//좋아요
	public int heart(int boardID) {
		String SQL = "UPDATE board SET heartCount = heartCount + 1 WHERE boardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} 
		return -1;
	}
	//조회수
	public int viewCountUpdate(int viewCount, int boardID) {
		String SQL = "UPDATE board SET viewCount = ? WHERE boardID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, viewCount);
			pstmt.setInt(2, boardID);
			return pstmt.executeUpdate();//insert,delete,update			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	//검색하기
	//boardAvailable = 1일때만 값 출력 : 게시글을 삭제했을때 & 회원탈퇴 했을때 게시글이 보이지 않는다.
	public ArrayList<BoardDTO> getSearch(String searchField2){//특정한 리스트를 받아서 반환
	      ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
	      String SQL ="SELECT * FROM board WHERE boardAvailable = 1 AND boardCategory";
	      try {
	            SQL +=" LIKE '%"+searchField2+"%' ORDER BY boardID DESC";
	            
	            PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();//select
	    	  
				while(rs.next()) {
	        	 
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
	            list.add(board);//list에 해당 인스턴스를 담는다.
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list;//리스트 반환
	   }
	
	//UserDAO - delete에서 사용되는 메서드
	//delete된 userID와 board의 userID가 같은 값의 리스트를 가져온다.
	public List<BoardDTO> getDelBoardVOByUserID(String userID) {
	    List<BoardDTO> boardDTOs = new ArrayList<>();
	    String SQL = "SELECT boardID, boardAvailable FROM board WHERE userID = ?";//userID가 작성한 board의 boardID와 boardAvailable의 값을 가져온다.
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, userID);
	        ResultSet rs = pstmt.executeQuery();
	        
	        while (rs.next()) { //user 한명이 여러개의 board를 생성하면 데이터가 1개 이상 나오기때문에 while을 사용한다.
	            int boardID = rs.getInt("boardID");
	            int boardAvailable = rs.getInt("boardAvailable");
	            //여기서 다른 속성도 가져올 수 있다.

	            // BoardVO 객체 생성하고 가져온 속성을 BoardVO 객체에 저장한다.
	            BoardDTO boardDTO = new BoardDTO();
	            boardDTO.setBoardID(boardID); 
	            boardDTO.setBoardAvailable(boardAvailable);

	            // boardVOs list에 boardVO object 추가
	            boardDTOs.add(boardDTO);
	        }
	        rs.close();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return boardDTOs;
	}
	
	//UserDAO - delete에서 삭제된 user와 관련된 정보를 업데이트 한다.
	public void updateBoardVO(BoardDTO boardDTO){
	    String SQL = "UPDATE board SET boardAvailable = ? WHERE boardID = ?";
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, boardDTO.getBoardAvailable());
	        pstmt.setInt(2, boardDTO.getBoardID());
	        pstmt.executeUpdate();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
}

