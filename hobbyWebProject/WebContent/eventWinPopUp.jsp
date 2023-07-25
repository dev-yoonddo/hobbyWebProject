<%@page import="java.io.PrintWriter"%>
<%@page import="event.EventDTO"%>
<%@page import="event.EventDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EVENT</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
</head>
<style>
.login-wrapper{
	margin: 25px;
	width: 450px;
	height: 260px;
	justify-content: center;
}

body{
	font-family: 'Nanum Gothic', monospace;
}

h2{
	padding: 0;
	margin: 0;
}

#eventWin{
	width: 400px;
	margin: 0 auto;
	justify-content: center;
	align-items: center;
}
#exit{
	cursor: pointer;
	margin-top: 20px;
}
</style>

<body>
<%
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
EventDAO eventDAO = new EventDAO();
%>
	<div class="login-wrapper">
	 	<div id="eventWin">
			<h2 style="font-size: 19pt; ">TO. <%=userID%>님 <br><br> <%= eventDAO.getEventVO(userID).getEventWinMsg().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></h2>
			<button type="button" id="exit" onclick="eventMsgExit()">더이상 보지않기 Ⅹ</button>
	   </div>
	</div>
<script>
function eventMsgExit(){
   	window.open('eventMsgExit.jsp', '', 'width=100, height=100, top=50%, left=50%');
   	self.close(); //이전 팝업 닫기
}
</script>
</body>
</html>