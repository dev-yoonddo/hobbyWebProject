package certification;

import java.util.Random;


public class TestController {
	public String test1() {
		return "test";
	}
	public String testMessage(String phoneNumber) {
		Random rd = new Random();
		String numstr = "";
		for(int i = 0; i < 6; i++) {
			String ran = Integer.toString(rd.nextInt(10));
			numstr += ran;
		}
		TestCoolsms.certifiedPhoneNumber(phoneNumber,numstr);
		return "ok";
	}
}

public class TestCoolsms{
	
	public static void certifiedPhoneNumber(String phoneNumber, String cerNum) {
		String api_key = "NCSUOUMOIRT1YHVO";
		String api_secret = "3Z1EYOSICARJWFWQLS1T0VQQBFLJ1J0I";
			Message coolsms = new Message(api_key, api_secret);
	}
}
