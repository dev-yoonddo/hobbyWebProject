<%@page import="file.FileDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String path = "C:/gookbiProject/JSP/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp2/wtpwebapps/hobbyWebProject/fileupload";
	request.setCharacterEncoding("UTF-8");
	MultipartRequest multipartRequest = new MultipartRequest(
		request,
//		application.getRealPath("/fileupload/"),
//		보안성 향상을 위해 upload 폴더를 WebContent 폴더 바깥에 만든다.
		path,
		10 * 2048 * 2048,
		"UTF-8",
		new DefaultFileRenamePolicy()
	);
	
//	다중 파일 업로드
//	index.jsp에서 넘어오는 업로드 할 파일 이름 여러개를 받는다.
	Enumeration filenames = multipartRequest.getFileNames();

//	hasMoreElements(): Enumeration 인터페이스 객체에 다음에 읽을 데이터가 있으면 true, 없으면 false를 리턴시킨다.
	while (filenames.hasMoreElements()) { // 업로드 할 파일이 있는 동안 반복한다.
		
//		nextElement(): Enumeration 인터페이스 객체에 저장된 다음 데이터를 얻어온다.
		String parameter = (String) filenames.nextElement();
//		업로드 페이지의 type이 file인 객체의 내용을 역순으로 얻어온다.
//		out.println(parameter + "<br/>");
		String filename = multipartRequest.getOriginalFileName(parameter);
		String fileRealname = multipartRequest.getFilesystemName(parameter);
		
//		업로드 할 파일이 넘어오지 않았으면 다음 파일을 처리한다. => 남은 반복을 실행할 필요가 없다.
		if (filename == null) {
			continue;
		}

		if (!filename.endsWith(".pdf") && !filename.endsWith(".jar") && !filename.endsWith(".zip") && !filename.endsWith(".jpg") && !filename.endsWith(".png")) {
			out.println("<script>");
			out.println("alert('" + filename +  "은(는) 업로드 할 수 없는 형식의 파일입니다.\\njar, zip, jpg, png파일만 업로드가 가능합니다.')");
			out.println("</script>");
//			File file = new File(application.getRealPath("/fileupload/") + filename);
			File file = new File(path + filename);
			file.delete();
		} else {
			out.println("원본 파일 이름: " + filename + "<br/>");
			out.println("실제 업로드된 파일 이름: " + fileRealname + "<br/>");
			
//			filename과 fileRealname를 테이블에 저장하는 메소드를 실행한다.
			new FileDAO().upload2(filename, fileRealname);			
		}

	}

%>

<a href="index.jsp">돌아가기</a>

</body>
</html>

















