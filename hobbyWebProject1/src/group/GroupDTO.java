package group;

public class GroupDTO {

	private int groupID; 
	private String groupName;
	private String groupPassword;
	private String userID;
	private int groupAvailable;
	private int groupNoP;
	
	
	public int getGroupID() {
		return groupID;
	}
	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getGroupPassword() {
		return groupPassword;
	}
	public void setGroupPassword(String groupPassword) {
		this.groupPassword = groupPassword;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getGroupAvailable() {
		return groupAvailable;
	}
	public void setGroupAvailable(int groupAvailable) {
		this.groupAvailable = groupAvailable;
	}
	public int getGroupNoP() {
		return groupNoP;
	}
	public void setGroupNoP(int groupNoP) {
		this.groupNoP = groupNoP;
	}
	
	
}
