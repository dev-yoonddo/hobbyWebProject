<%@page import="file.FileDAO"%>
<%@page import="file.FileDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
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
	String uploadDirectory = application.getRealPath("/fileupload/");
//	String uploadDirectory = "D:/upload/";
//	String[] files = new File(uploadDirectory).list();

//	테이블에 저장된 업로드된 전체 파일 정보를 얻어온다.
	ArrayList<FileDTO> files = new FileDAO().getList();
	
	out.println("업로드된 파일 목록<br/>");
	for (FileDTO file : files) {
%>
<a href="<%=request.getContextPath()%>/downloadAction?file=<%=URLEncoder.encode(file.getFilename(), "UTF-8")%>">
	<%=file.getFilename()%>(다운로드 횟수: <%=file.getDownloadCount()%>)
</a><br/>

<%
	}
%>

<a href="index.jsp">돌아가기</a>

</body>
</html>