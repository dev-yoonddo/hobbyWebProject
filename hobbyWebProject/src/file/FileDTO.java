package file;

public class FileDTO {
	private int fileidx;
	private int boardID;
	private String filename;
	private String fileRealname;
	private int downloadCount;
	
	public FileDTO() { }
	public FileDTO(String filename, String fileRealname, int downloadCount) {
		this.filename = filename;
		this.fileRealname = fileRealname;
		this.downloadCount = downloadCount;
	}
	
	public int getFileidx() {
		return fileidx;
	}
	public void setFileidx(int idx) {
		this.fileidx = idx;
	}
	public int getBoardID() {
		return boardID;
	}
	public void setBoardID(int boardID) {
		this.boardID = boardID;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFileRealname() {
		return fileRealname;
	}
	public void setFileRealname(String fileRealname) {
		this.fileRealname = fileRealname;
	}
	public int getDownloadCount() {
		return downloadCount;
	}
	public void setDownloadCount(int downloadCount) {
		this.downloadCount = downloadCount;
	}
	
	@Override
	public String toString() {
		return "FileDTO [fileidx=" + fileidx + ", boardID=" + boardID + ",filename=" + filename + ", fileRealname=" + fileRealname + ", downloadCount="
				+ downloadCount + "]";
	}
	
}
