package test;

import java.util.HashMap;
import java.util.Scanner;

import user.PwEncrypt;

public class UserTest {
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		// pw 입력받기
		String pw = scan.next();
		// random salt값 가져오기
//		String salt = PwEncrypt.getSalt();
		// PwEncrypt 클래스의 encoding 메서드에 입력받은 문자와 salt값을 넣어준 뒤 값 리턴받기 (salt값이 없어도 됨)
		HashMap<String, String> result = PwEncrypt.encoding(pw, null);
//		System.out.println("random salt :" + salt);
//		System.out.println("result: " + result.get("hash"));
//		System.out.println("salt: " + result.get("salt"));

		// decode
//		String decode = new String(Base64.getDecoder().decode(result.get("hash")));
//		String decodeString = new String(decode);
//		System.out.println("decode: " + decodeString);

//		// 입력한 문자 인코딩
//		String encode = new String(Base64.getEncoder().encode(pw.getBytes()));
//		System.out.println("encoding: " + encode);
//		// 입력한 문자 디코딩
//		String decode = new String(Base64.getDecoder().decode(encode.getBytes()));
//		System.out.println("decode: " + decode);
	}
}
