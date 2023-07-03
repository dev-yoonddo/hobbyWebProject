<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error</title>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>

</head>
<style>
body{
	width: auto;
	height: 500px;
	margin-top: 150px;
	color: grey;
}
a{
	text-decoration: underline;
	cursor: pointer;
	color: blue;
}
a:hover{
	font-weight: bold;
}
h1{
	display: flex;
	justify-content: center;
}
</style>
<body>
<%
String userID=null;
if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");
}
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp.jsp', 'Login', 'width=450, height=500, top=50%, left=50%')");
	script.println("</script>");
}
if(userID != null){
%>
<div id="error" style="width:auto; display: flex; justify-content: center;">
	<div style="justify-content: center;">
		<div style="font-size: 30px; display: flex; justify-content: center;"><i class="fa-regular fa-face-frown fa-10x"></i></div>
		<h1>오류가 발생했습니다.</h1>
		<div style="margin: 0 auto;">
		<h1><%= exception.toString() %></h1>
		<a onclick="history.back()">돌아가기</a>
		</div>
	</div>
</div>
<%} %>
</body>
</html>