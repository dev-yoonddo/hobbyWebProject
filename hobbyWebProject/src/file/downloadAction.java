package file;

import java.io.File;

import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		int boardID = Integer.parseInt(request.getParameter("boardID"));
		String filename = request.getParameter("file");
//		다운로드 할 파일이 저장된 실제 물리적 디렉토리 경로를 다운로드 할 파일 이름과 연결한다.
		//String uploadDirectory = "C:/gookbiProject/JSP/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp2/wtpwebapps/hobbyWebProject/fileupload/" + filename;
		//String uploadDirectory = request.getContextPath() + "/fileupload/";
		//String uploadDirectory = application.getRealPath("/fileupload/"); //ServletContext에도 있기때문에 deprecated된다.
		String uploadDirectory =  request.getSession().getServletContext().getRealPath("/fileupload/" + filename);
		//String uploadDirectory = request.getParameter("path");
		File file = new File(uploadDirectory);

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
		
		//다운로드가 완료되면 다운로드 횟수를 증가시킨다.
		new FileDAO().hit(boardID, filename);
		//다운로드가 완료되면 board테이블의 다운로드 횟수도 증가시킨다.
		new BoardDAO().download(boardID,filename);
	}

}














