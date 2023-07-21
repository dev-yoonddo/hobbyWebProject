package event;

public class EventDTO {
	private int eventID;
	private String userID;
	private String eventContent;
	private String groupName;
	private int eventAvailable;
	private int eventWin;
	private String userPassword;
	
	public int getEventID() {
		return eventID;
	}
	public void setEventID(int eventID) {
		this.eventID = eventID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getEventContent() {
		return eventContent;
	}
	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public int getEventAvailable() {
		return eventAvailable;
	}
	public void setEventAvailable(int eventAvailable) {
		this.eventAvailable = eventAvailable;
	}
	public int getEventWin() {
		return eventWin;
	}
	public void setEventWin(int eventWin) {
		this.eventWin = eventWin;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
	
}
