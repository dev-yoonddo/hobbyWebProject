package crew;

public class CrewDTO {
	private String userID;
	private String spotName;
	private int crewAvailable;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getSpotName() {
		return spotName;
	}
	public void setSpotName(String spotName) {
		this.spotName = spotName;
	}
	public int getCrewAvailable() {
		return crewAvailable;
	}
	public void setCrewAvailable(int crewAvailable) {
		this.crewAvailable = crewAvailable;
	}
	
	
}
