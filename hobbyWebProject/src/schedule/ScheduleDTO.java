package schedule;

public class ScheduleDTO {
	private String userID;
	private String spotName;
	private int skedYear;
	private int skedMonth;
	private int skedDay;
	private String skedContent;
	private int skedAvailable;

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

	public int getSkedYear() {
		return skedYear;
	}

	public void setSkedYear(int skedYear) {
		this.skedYear = skedYear;
	}

	public int getSkedMonth() {
		return skedMonth;
	}

	public void setSkedMonth(int skedMonth) {
		this.skedMonth = skedMonth;
	}

	public int getSkedDay() {
		return skedDay;
	}

	public void setSkedDay(int skedDay) {
		this.skedDay = skedDay;
	}

	public String getSkedContent() {
		return skedContent;
	}

	public void setSkedContent(String skedContent) {
		this.skedContent = skedContent;
	}

	public int getSkedAvailable() {
		return skedAvailable;
	}

	public void setSkedAvailable(int skedAvailable) {
		this.skedAvailable = skedAvailable;
	}

}
