package chat;

public class ChatDTO {
	private String userID;
	private int groupID;
	private String chatContent;
	private String chatDate;
	private int chatAvailable;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getGroupID() {
		return groupID;
	}
	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatDate() {
		return chatDate;
	}
	public void setChatDate(String chatDate) {
		this.chatDate = chatDate;
	}
	public int getChatAvailable() {
		return chatAvailable;
	}
	public void setChatAvailable(int chatAvailable) {
		this.chatAvailable = chatAvailable;
	}
	
	
}
