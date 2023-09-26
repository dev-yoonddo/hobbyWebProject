package location;

public class LocationDTO {
	private String userID;
	private String spotName;
	private String address;
	private double latitude;
	private double longitude;
	private int crewCount;
	private int spotAvailable;
	
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public int getCrewCount() {
		return crewCount;
	}
	public void setCrewCount(int crewCount) {
		this.crewCount = crewCount;
	}
	public int getSpotAvailable() {
		return spotAvailable;
	}
	public void setSpotAvailable(int spotAvailable) {
		this.spotAvailable = spotAvailable;
	}
	
	
}
