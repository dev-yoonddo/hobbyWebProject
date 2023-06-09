package message;

public class MessageDTO {
	private int msgID;
	private String userID;
	private String toUserID;
	private int groupID;
	private String msgTitle;
	private String msgContent;
	private int msgCheck;
	private int msgAvailable;
	private String msgDate;
	
	
	public int getMsgID() {
		return msgID;
	}
	public void setMsgID(int msgID) {
		this.msgID = msgID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getToUserID() {
		return toUserID;
	}
	public void setToUserID(String toUserID) {
		this.toUserID = toUserID;
	}
	public int getGroupID() {
		return groupID;
	}
	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}
	public String getMsgTitle() {
		return msgTitle;
	}
	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	public int getMsgCheck() {
		return msgCheck;
	}
	public void setMsgCheck(int msgCheck) {
		this.msgCheck = msgCheck;
	}
	public int getMsgAvailable() {
		return msgAvailable;
	}
	public void setMsgAvailable(int msgAvailable) {
		this.msgAvailable = msgAvailable;
	}
	public String getMsgDate() {
		return msgDate;
	}
	public void setMsgDate(String msgDate) {
		this.msgDate = msgDate;
	}
	
	
	
}
