<%@page import="java.io.File"%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	

	
//	단일 파일 업로드
//	getOriginalFileName(): 사용자가 업로드 한 파일 이름을 얻어온다.
//	String filename = multipartRequest.getOriginalFileName("file");
//	getFilesystemName(): 업로드되서 실제 디스크에 저장된 파일 이름을 얻어온다.
//	String fileRealname = multipartRequest.getFilesystemName("file");
	
//	업로드 제한
//	startsWith(): 인수로 지정된 문자열로 파일 이름 이름이 시작하면 true, 그렇치 않으면 false를 리턴한다.
//	endsWith(): 인수로 지정된 문자열로 파일 이름 이름이 끝나면 true, 그렇치 않으면 false를 리턴한다.
//	*.jar 파일과 *.zip 파일만 업로드 할 수 있도록 한다. => 지정한 확장명을 가지지 않는 파일은 업로드 되자마자 제거한다.
//	if (!filename.endsWith(".jar") && !filename.endsWith(".zip") && !filename.endsWith(".jpg") && !filename.endsWith(".png")) {
//		out.println("<script>");
//		out.println("alert('" + filename +  "은(는) 업로드 할 수 없는 형식의 파일입니다.\\njar, zip 파일만 업로드가 가능합니다.')");
//		out.println("</script>");
//		업로드된 파일을 삭제한다.
//		File file = new File(application.getRealPath("./upload/") + filename);
//		delete(): 파일을 삭제한다.
//		file.delete();
//	} else {
		/*out.println("원본 파일 이름: " + filename + "<br/>");
		out.println("실제 업로드된 파일 이름: " + fileRealname + "<br/>");*/
//		out.println("<script>");
//		out.println("alert('정상적으로 업로드 되었습니다')");
//		out.println("location.href=document.referrer;");
//		out.println("</script>");
//	}
%>


</body>
</html>

















