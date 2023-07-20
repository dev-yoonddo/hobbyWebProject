package user;

import java.security.MessageDigest;

public class pwEncrypt {
	public static String encoding(String str) {
		String encodeString ="";
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update((str).getBytes());
			
			byte[] encodeData = md.digest();
			
			for(int i = 0; i < encodeData.length; i++) {
				encodeString += Integer.toHexString(encodeData[i]&0xFF);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return encodeString;
	}
	/* 테스트
	public static void main(String[] args) {
		String raw = "1234";
		String after = "";
		
		after = pwEncrypt.encoding(raw);
		System.out.println(after);
	}*/
}