<%@page import="schedule.ScheduleDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>SCHEDULE</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

<style>
h2{
	font-family: 'Bruno Ace', cursive;
	font-weight: bold;
	font-size: 20pt;
	color: #2E2F49;
}
#sb{
width: 100%;
}
#sb span{
color: #ffffff;
  background-color: #2E2F49;
  border: 1px solid #2E2F49;
  padding-top: 15px;
  padding-bottom: 15px;
}
#sb::before {
  background-color: #2E2F49;
}

#sb span:hover {
  color: #2E2F49;
  background-color: #ffffff;
}
#schedule-container{
	width: 370px;
	margin: 40px;
	padding-top: 10px;
}
#sked-form > input{
	width: 370px;
	height: 150px;
}
</style>
</head>
<body id="header">
<%
PrintWriter script = response.getWriter();
String userID = null;
String spotName = null;
int skedMonth = 0;
int skedDay = 0;
String a = null;


ScheduleDAO skedDAO = new ScheduleDAO();

if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
}
if(request.getParameter("spot") != null){
	spotName = request.getParameter("spot");
}
if(request.getParameter("month") != null){
	skedMonth = Integer.parseInt(request.getParameter("month"));
}
if(request.getParameter("day") != null){
	skedDay = Integer.parseInt(request.getParameter("day"));
}
if(request.getParameter("a") != null){
	a = request.getParameter("a");
}

if(a == null){ //a값이 존재하지 않으면 접속이 아닌 검사를 의미한다.
	if(userID == null){
		script.print("null");
		script.flush();
	}else if(spotName == null || skedMonth == 0 || skedDay == 0){
		script.print("info error");
		script.flush();
	}else{
		script.print("ok");
		script.flush();
	}
	script.close();
}else{
%>
<div id="schedule-container">
    <h2><%=skedMonth%>/<%=skedDay%>&nbsp;&nbsp;New Schedule</h2>
    <div id="sked-form">
        <input type="text" placeholder="스케줄 내용을 입력하세요" name="skedContent" id="skedContent" class="intro" maxlength="100">
        <button type="button" class="btn-blue" id="sb" onclick="regist()"><span>등록하기</span></button>
	</div>
</div>
<%}%>
<script>

function regist(){
	var spot = "<%=spotName%>";
	var content = document.getElementById('skedContent').value;
	//console.log(content);
	var month = "<%=skedMonth%>";
	var day = "<%=skedDay%>";
	var data = {
	    spot: spot,
	    content: content,
	    month: month,
	    day: day
	};
	$.ajax({
	    type: 'POST',
	    //url: 'https://toogether.me/spotAccess',
	    url: 'scheduleRegistAction',
	    data: data,
	    success: function (response) {
	    	if (response.includes("null userID")) {
	    		alert("로그인 후 다시 시도해주세요.");
	 			window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%');
	    	}else if(response.includes("info error")){
	    		alert('내용을 입력하세요');
	    	}else if(response.includes("database error")){
	    		alert('데이터베이스 오류');
	    	}else{
	    		self.close();
	    		opener.location.reload();
	    	}
	    },
	 error: function (xhr, status, error) {
	     //console.error('Spot registration error:', error);
	     alert('오류');
	 }
	});
}
</script>
</body>
</html>