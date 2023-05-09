package file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/downloadAction")
public class fileDownloadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public fileDownloadAction() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("get 방식으로 요청될 때 자동으로 실행되는 메소드");
//		System.out.println(request.getParameter("file"));
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("post 방식으로 요청될 때 자동으로 실행되는 메소드");
		actionDo(request, response);
	}
	
	protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
//		System.out.println("actionDo() 메소드");
//		System.out.println(request.getParameter("file"));
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
//		다운로드 할 파일 이름을 받는다.
		String filename = request.getParameter("file");
		
//		다운로드 할 파일이 저장된 실제 경로를 얻어와서 파일 이름과 연결한다.
//		String uploadDirectory = getServletContext().getRealPath("./upload/");
		String uploadDirectory = getServletContext().getRealPath("./upload/") + filename;
//		System.out.println(uploadDirectory);
		
//		다운로드 할 파일 객체를 만든다.
		File file = new File(uploadDirectory);
		
//		MIME: Multipurpose Internet Mail Extensions의 약자로 파일 변환을 의미한다.
//		getMimeType(): 인수로 지정된 파일의 MIME 타입을 얻어온다.
		String mimeType = getServletContext().getMimeType(file.toString());
//		System.out.println(mimeType);
//		MIME 타입을 얻어오지 못했다면 파일을 전송하는 것을 사용자에게 알려주기 위해서 response 객체를 사용해서
//		file 형태의 데이터를 전송한다는 것을 "application/octet-stream"을 사용자에게 알려준다.
		if (mimeType == null) {
			response.setContentType("application/octet-stream");
		}
		
//		접속한 브라우저에 따라 다운로드 할 파일의 헤더 정보를 다르게 설정한다.
		String downloadName = null;
		if (request.getHeader("user-agent").indexOf("MSIE") == -1) {
//			인터넷 익스플로러를 제외한 나머지 브라우저
			downloadName = new String(filename.getBytes("UTF-8"), "8859_1");
		} else {
//			인터넷 익스플로러
			downloadName = new String(filename.getBytes("EUC-KR"), "8859_1");
		}
//		attachment 뒤의 filename은 반드시 큰따옴표를 사용해서 묶어야 한다. => \"를 사용한다.
		response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + "\";");
		
//		파일 전송에 사용할 객체를 선언한다.
//		디스크의 파일을 읽어들이는 객체를 선언한다.
		FileInputStream fileInputStream = new FileInputStream(file);
//		다운로드를 실행한 브라우저로 파일을 전송하는 객체를 선언한다.
		ServletOutputStream outputStream = response.getOutputStream();
		
//		파일을 1024 바이트(1KB) 단위로 전송하기 위해 객체를 선언한다.
		byte[] b = new byte[1024];
		int data = 0;
		
//		디스크에서 읽어들인 전송할 파일에 데이터가 남아있는 동안 반복하며 브라우저로 전송한다.
//		read(배열 이름, 시작 인덱스, 마지막 인덱스): FileInputStream 객체에서 파일 내용을 바이트 단위로 읽는다.
//		파일에서 읽어들인 데이터를 지정한 배열에 배열의 시작 인덱스 부터 마지막 인덱스 까지 채우고 읽어들인
//		크기를 리턴한다. 읽어들인 내용이 없다면 -1을 리턴시킨다.
		while ((data = fileInputStream.read(b, 0, b.length)) != -1) {
			outputStream.write(b, 0, data);
		}
		
//		flush() 메소드로 ServletOutputStream 객체의 출력 버퍼에 남아있는 모든 데이터를 전송하고 전송에 사용한
//		모든 객체를 닫는다.
		outputStream.flush();
		outputStream.close();
		fileInputStream.close();
		
	}

}














