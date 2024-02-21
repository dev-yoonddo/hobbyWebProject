package test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import board.BoardDAO;
import board.BoardDTO;

public class UserTest {
	public static void main(String[] args) {
//		Scanner scan = new Scanner(System.in);
		// pw 입력받기
//		String pw = scan.next();
		// random salt값 가져오기
//		String salt = PwEncrypt.getSalt();
		// PwEncrypt 클래스의 encoding 메서드에 입력받은 문자와 salt값을 넣어준 뒤 값 리턴받기 (salt값이 없어도 됨)
//		HashMap<String, String> result = PwEncrypt.encoding(pw, null);
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

		BoardDAO board = BoardDAO.getInstance();

		int id = board.getNext() - 1;
		BoardDTO vo = board.getBoardVO(id);
		String date = board.getDate();
		List<BoardDTO> list = board.getList();
		List<BoardDTO> getList = board.getListByUser("user4");

		System.out.println("new connection result: " + vo.getBoardTitle());
		System.out.println("max id: " + id);
		System.out.println("date: " + date);
		for (BoardDTO i : list) {
			System.out.println(i.getBoardID());
			System.out.println(i.getBoardTitle());
//			System.out.println(i.getBoardCategory());
//			System.out.println(i.getBoardContent());
		}
		System.out.println("===========================");

		System.out.println("카테고리 갯수-------------------");

		Map<String, Integer> categoryCounts = new HashMap<>(); // 카테고리와 갯수를 저장하기 위한 Map 객체 생성
		for (BoardDTO post : getList) { // 사용자 "test"가 작성한 게시글 리스트 반복
			categoryCounts.put(post.getBoardCategory(), // 같은 key값에
					categoryCounts.getOrDefault(post.getBoardCategory(), 0) + 1); // value+1 하기 (key 값이 존재하지 않으면 0 + 1)
		}

		System.out.println("All Categories:");
		System.out.println(categoryCounts);

		System.out.println("-----------------------------------");

		System.out.println("게시글 작성 -------------------");

		int update = board.update(70, "수정하깅", "성공", "SPORTS", null, null);
		System.out.println(update);
//		int result = board.write("반가워~", "user", "하이", "LEISURE", null, null);
//		System.out.println("result = " + result);
		if (update == 1) {
			System.out.println("작성완료");
		} else {
			System.out.println("실패");
		}
		// System.out.println(vo.toString());
		System.out.println("-----------------------------------");

		System.out.println("BoardDAO 검사 -------------------");
		List<BoardDTO> categorylist = board.getSearch("SPORTS");
		for (BoardDTO i : categorylist) {
			System.out.println(i.getBoardContent());
		}

	}
}
