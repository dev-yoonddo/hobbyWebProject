<%@page import="java.io.PrintWriter"%>
<%@page import="event.EventDTO"%>
<%@page import="event.EventDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
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
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>
<style>
.login-wrapper{
	margin: 25px;
	width: 450px;
	height: 450px;
	justify-content: center;
}

body{
	font-family: 'Nanum Gothic', monospace;
}

h2 , h3{
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
	top: 400px;
	position: fixed;
}
</style>

<body id="header"> <!-- 커서이벤트를 위해 id=header로 지정 -->
<%
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
EventDAO eventDAO = new EventDAO();
String msg = eventDAO.getEventVO(userID).getEventWinMsg().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
%>
	<div class="login-wrapper">
	 	<div id="eventWin">
			<h2 style="font-size: 20pt;">TO. <%=userID%>님</h2> <br><br>
			<h3 style="font-size: 16pt; color: #86A5FF; "><%=msg%></h3>
			<button type="button" id="exit" onclick="eventMsgExit()">더이상 보지않기 Ⅹ</button>
	   </div>
	</div>
<script>
function eventMsgExit(){
   	window.open('eventMsgExit', '', 'width=100, height=100, top=50%, left=50%');
   	self.close(); //이전 팝업 닫기
}
</script>
</body>
</html>