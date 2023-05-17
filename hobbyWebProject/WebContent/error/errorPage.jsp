<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error</title>
</head>
<body>
	<h1>에러발생!! <%=exception.getMessage() %></h1>
	<%
		PrintWriter er = response.getWriter();
		exception.printStackTrace(er);
	%>
	====== toString() 내용 ======<br>
	<h1><%= exception.toString() %></h1> <%-- exception 내장 객체를 사용해 예외 처리 --%>
	============ getMessage() 내용 ============<br>
	<h1><%= exception.getMessage() %></h1>
	============ printStackTrace() 내용 ============<br>
	<h1><% exception.printStackTrace(); %></h1> <%-- 이클립스 콘솔로 예외 메시지를 출력 --%>
	<h3>
	숫자만 입력 가능합니다. 다시 시도하세요.
	<a onclick='history.back()'>돌아가기</a>
</h3>
</body>
</html>