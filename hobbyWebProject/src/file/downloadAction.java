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

import board.BoardDAO;

@WebServlet("/downloadAction")
public class downloadAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public downloadAction() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");

		int boardID = Integer.parseInt(request.getParameter("boardID"));
		String filename = request.getParameter("file");
//		다운로드 할 파일이 저장된 실제 물리적 디렉토리 경로를 다운로드 할 파일 이름과 연결한다.
		// 1. JSP프로젝트의 fileupload 폴더 경로 직접 지정 > String uploadDirectoryByJSP =
		// "C:/gookbiProject/JSP/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp2/wtpwebapps/hobbyWebProject/fileupload/"
		// + filename;
		// 2. 배포한 war파일의 fileupload 폴더 경로 직접 지정 > String uploadDirectory =
		// "/home/tomcat/apache-tomcat-8.5.88/webapps/hobbyWebProject/fileupload/" +
		// filename; // 여기선 hobbyWebProject/fileupload 경로를 사용했지만 밑에선 업데이트시 파일이 삭제되는걸
		// 방지하기 위해 외부폴더를 사용했다.
		// 3. 해당 프로젝트 경로를 가져온다. + 파일이름 > String uploadDirectory =
		// request.getContextPath() + "/fileupload/"; //배포프로젝트에선 작동하지 않는다.
		// 4. fileupload폴더의 진짜 경로를 가져온다. > String uploadDirectory =
		// application.getRealPath("/fileupload/"); //ServletContext에도 있기때문에
		// deprecated된다.
		// 5. 직접 경로를 지정하지 않고 사용하기 제일 적절한 방법이다. > String uploadDirectory =
		// request.getSession().getServletContext().getRealPath("/fileupload/" +
		// filename); //배포페이지와 localhost페이지에서 각각 다른 경로로 업로드,다운로드 된다.
		// System.out.println(uploadDirectory);

		// --------------------------------------------------------------------------------------------------------
		// String filePath =
		// request.getSession().getServletContext().getRealPath("/fileupload/" +
		// filename);
		// File file = new File(filePath); //각 결과에서 저장된 경로로 객체를 생성한다.
		// 위 두 줄의 코드만 사용해서 해당하는 운영체제의 경로를 받아와도 되지만 위 코드는 프로젝트 내부의 fileupload경로를 불러오는데
		// 프로젝트 업데이트시 파일이 삭제되기 때문에 외부에 파일을 만들어 경로를 따로 지정해준다.
		// 사진 다운로드가 가능하도록 하기 위해 각 경로가 존재하는지 확인하고 해당하는 경로로 객체를 생성한다.

		String filePath = null;
		String jspPath = request.getSession().getServletContext().getRealPath("/fileupload/" + filename);
		String awsPath = "/cksndbs7/tomcat/webapps/fileupload/" + filename;

		if (new File(jspPath).exists()) { // jsp경로가 존재하면 jsp에서 프로젝트를 실행했음을 의미하고
			filePath = jspPath;
		} else { // 존재하지 않으면 서버에서 프로젝트를 실행했음을 의미하므로 해당하는 경로를 변수에 저장한다.
			filePath = awsPath;
		}
		File file = new File(filePath); // 각 결과에서 저장된 경로로 객체를 생성한다.

		// --------------------------------------------------------------------------------------------------------
		// File file = new File(uploadDirectory);

		String mimeType = getServletContext().getMimeType(file.toString());
		if (mimeType == null) {
			response.setContentType("application/octet-stream");
		}

		String downloadName = null;
		if (request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downloadName = new String(filename.getBytes("UTF-8"), "8859_1");
		} else {
			downloadName = new String(filename.getBytes("EUC-KR"), "8859_1");
		}
		response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + "\";");

		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream outputStream = response.getOutputStream();
		byte[] b = new byte[1024];
		int data = 0;
		while ((data = fileInputStream.read(b, 0, b.length)) != -1) {
			outputStream.write(b, 0, data);
		}
		outputStream.flush();
		outputStream.close();
		fileInputStream.close();

		// 다운로드가 완료되면 다운로드 횟수를 증가시킨다.
		FileDAO.getInstance().hit(boardID, filename);
		// 다운로드가 완료되면 board테이블의 다운로드 횟수도 증가시킨다.
		BoardDAO.getInstance().download(boardID, filename);
	}

}
