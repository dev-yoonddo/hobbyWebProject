<%@page import="java.util.ArrayList"%>
<%@page import="group.GroupDTO"%>
<%@page import="group.GroupDAO"%>
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
	height: 250px;
	justify-content: center;
}

.category-sel{
width: 400px;

}
body{
	font-family: 'Nanum Gothic', monospace;
}

h2{
	padding: 0;
	margin: 0;
}
input{
	width: 350px;
}
select{
	width: 250px;
	height: 50px;
	margin-bottom: 10px;
	text-align: center;
	font-size: 15pt;
	font-weight: 500;
	color: #B3C1EE;
	border : 2px solid  #dddddd;
}
option{
	color: #B3C1EE;
	height: 50px;
}
#eventWin{
	margin: 0 auto;
	justify-content: center;
	align-items: center;
}
#exit{
	cursor: pointer;
	margin-top: 30px;
}
</style>

<body>
<%
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}

GroupDAO grDAO = new GroupDAO();
ArrayList<GroupDTO> list = grDAO.getListByUser(userID);
%>
	<div class="login-wrapper">
	 	<div id="eventWin">
			<h2 style="font-size: 25pt;">활동지원금 이벤트에</h2>
			<h2 style="font-size: 30pt;">당첨 되셨습니다!</h2>
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