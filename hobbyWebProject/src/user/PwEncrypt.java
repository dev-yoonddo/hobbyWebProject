package user;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.HashMap;

public class PwEncrypt {
	public static HashMap<String, String> encoding(String str, String salt) {
		HashMap<String, String> resultPW = new HashMap<>();
		String encodeString = "";
		// salt값이 null이면 회원가입하는 사용자를 의미하기 때문에 새로운 salt값을 가져와 저장한다.
		// salt값이 not null이면 이미 회원가입 한 사용자의 로그인 요청을 의미하기 때문에 기존 salt값을 사용한다.
		if (salt == null) {
			salt = PwEncrypt.getSalt();
		}
		try {
			// 암호화 시작
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			String shaAndSalt = str + salt;

			/*
			 * 사용자가 입력한 비밀번호 암호화 md.update((str).getBytes());
			 * 
			 * byte[] encodeData = md.digest();
			 * 
			 * for (int i = 0; i < encodeData.length; i++) { encodeString +=
			 * Integer.toHexString(encodeData[i] & 0xFF); } System.out.println("평문 암호화 = " +
			 * encodeString);
			 */

			// (사용자 입력 비밀번호 + salt) 해쉬값 업데이트
			md.update((shaAndSalt).getBytes());

			byte[] encodeData = md.digest();
			System.out.println("digest: " + md.digest());

			for (int i = 0; i < encodeData.length; i++) {
				encodeString += Integer.toHexString(encodeData[i] & 0xFF); // 10진수 정수 배열을 16진수 문자열로 변환한다.
			}

			// 확인
			System.out.println("str = " + str);
			System.out.println("salt = " + salt);
			System.out.println("str + salt 암호화 전 = " + shaAndSalt);
			System.out.println("str + salt 암호화 후 = " + encodeString);

//			if (encodeString.equals("317d7d8884d5f0871a2e7761ff4382a57fd70a47dba3dad65a087149bbb1cdd")) {
//				System.out.println("평문+솔트 암호화 일치");
//			} else {
//				System.out.println("평문+솔트 암호화 불일치");
//			}

			// HsashMap에 저장 후 반환
			resultPW.put("hash", encodeString);
			resultPW.put("salt", salt);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultPW;
	}

	// 랜덤 salt값을 생성하는 메서드
	public static String getSalt() {
		try {
			SecureRandom random = new SecureRandom();
//			SecureRandom sha = SecureRandom.getInstance("SHA1PRNG"); 위와 같은 결과가 나온다.
			byte[] bytes = new byte[16];
			random.nextBytes(bytes);
			System.out.println("random : " + random);
			System.out.println("bytes : " + bytes);
			// create salt
			String salt = new String(Base64.getEncoder().encode(bytes)); // 배열을 다시 문자열로 변경

			System.out.println(salt);
			return salt;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * public static void main(String[] args) { String key = null; String value =
	 * null; HashMap<String, String> result = PwEncrypt.encoding("qlalf9228?",
	 * null); result.getOrDefault(key, value); System.out.println("회원가입 hashpw::: "
	 * + result.keySet()); System.out.println("회원가입 slat::: " + result.values());
	 * HashMap<String, String> result2 = PwEncrypt.encoding("1234",
	 * "XKdiXlhCZuN6dbCNxLGqQQ=="); System.out.println("로그인 hashpw ::: " +
	 * result2.keySet()); System.out.println("로그인 salt ::: " + result2.values()); }
	 * 
	 * 테스트 public static void main(String[] args) { String raw = "1234"; String
	 * after = "";
	 * 
	 * after = pwEncrypt.encoding(raw); System.out.println(after); }
	 */
}