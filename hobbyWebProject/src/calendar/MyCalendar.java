package calendar;


public class MyCalendar {
	
	public static boolean isLeapYear(int year) {
		return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
	}
	
	public static int lastDay(int year, int month) {
		int[] m = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
		m[1] = isLeapYear(year) ? 29 : 28;
		return m[month - 1];
	}
	
	public static int totalDay(int year, int month, int day) {
		int sum = (year - 1) * 365 + (year - 1) / 4 - (year - 1) / 100 + (year - 1) / 400;
		for (int i = 1; i < month; i++) {
			sum += lastDay(year,i);
		}
		return sum + day;
	}
	
	public static int weekDay(int year, int month, int day) {
		return totalDay(year, month, day) % 7;
	}
	
	//날짜 출력하기 (공휴일인 날과 아닌 날 구분)
	public static String printDay(int i, String holi, String notHoli, String icon) {
		String printValue = null;
		if(holi == null && notHoli != null) { //공휴일이 아니면 class이름에 요일을 넣어준다. 
			printValue = "<td class='openInfo' id='"+ notHoli +"' onclick='printValue(this)' value='"+ i +"'>" + i + "<br>"+ icon +"</td>";
		}else { //공휴일이면 span태그에 공휴일 이름을 넣어준다.
			printValue = "<td class='openInfo' id='holiday' onclick='printValue(this)' value='"+ i +"'>" + i + "<span>"+holi+"</span><br>"+ icon +"</td>";
		}
		return printValue;
	}
}
