package file;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.BoardDTO;

public class FileDAO {
	private Connection conn; //자바와 데이터베이스 연결
	private ResultSet rs; //결과값 받아오기
	
	public FileDAO() {
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
	//idx 번호매기기
	public int getNext() {
	    String SQL = "SELECT MAX(fileidx) FROM file";
	    try {
	    	PreparedStatement pstmt = conn.prepareStatement(SQL);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            int maxFileIdx = rs.getInt(1);
	            return maxFileIdx + 1;
	        } else {
            return 1;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;
	}
	/* 기본 파일 업로드 메서드
	public int upload1(String fileName, String fileRealName) {

		String SQL = "INSERT INTO FILE VALUES (?, ?)";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);			
			pstmt.setString(1,  fileName);
			pstmt.setString(2,  fileRealName);
			return pstmt.executeUpdate();

		} catch(Exception e) {
			e.printStackTrace();
		}

		return -1;

	}*/
	//파일을 업로드 할 때 마다 업로드 하는 파일 이름과 실제로 저장되는 파일 이름을 테이블에 저장하는 메서드
	public int upload2(int boardID, String filename, String fileRealname) {
		try {
			String SQL = "INSERT INTO file (fileidx, boardID, filename, fileRealname, downloadCount) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(SQL);			
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, boardID);
			pstmt.setString(3, filename);
			pstmt.setString(4, fileRealname);
			pstmt.setInt(5, 0);
			int ok = pstmt.executeUpdate();
			//executeUpdate() 메소드는 sql 명령을 실행하고 정상적으로 실행된 sql 명령의 개수를 리턴한다.
			return ok;
		} catch (Exception e) {
			e.printStackTrace();
		}
		//오류가 발생되면 -1을 리턴시킨다.
		return -1;
	}
	
	//테이블에 저장된 업로드된 전체 파일 목록을 얻어오는 메소드
	public ArrayList<FileDTO> getList() {
		ArrayList<FileDTO> list = new ArrayList<FileDTO>();
		try {
			String SQL = "SELECT * FROM file ORDER BY fileidx DESC";
			PreparedStatement pstmt = conn.prepareStatement(SQL);			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FileDTO vo = new FileDTO(rs.getString("filename"), rs.getString("fileRealname"), rs.getInt("downloadCount"));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//파일을 다운로드가 완료되면 다운로드 횟수를 1증가시키는 메소드
	public int hit(int boardID, String filename) {
		try {
			String SQL = "UPDATE file SET downloadCount = downloadCount + 1 WHERE boardID = ? AND filename = ?";
			PreparedStatement pstmt = conn.prepareStatement(SQL);			
			pstmt.setInt(1, boardID);
			pstmt.setString(2, filename);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	//하나의 파일 정보 보기
	public FileDTO getFileVO(int boardID) {
		String SQL = "SELECT * FROM file WHERE boardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				FileDTO file = new FileDTO();
				file.setFileidx(rs.getInt(1));
				file.setBoardID(rs.getInt(2));
				file.setFilename(rs.getString(3));
				file.setFileRealname(rs.getString(4));
				file.setDownloadCount(rs.getInt(5));
				return file;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
}
