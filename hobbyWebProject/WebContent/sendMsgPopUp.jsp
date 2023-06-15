<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEND MESSAGE</title>
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
  
#sendMsg{
	width: 400px;
	margin: 50px;
}
#send-form > input{
	width: 400px;
}
#msgTitle{
	height: 80px;
}
#msgContent{
	height: 180px;
}
</style>
</head>
<body>
<%
//userID 가져오기
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
}

//groupID 가져오기
int groupID = 0;
if(request.getParameter("groupID") != null){
	groupID = Integer.parseInt(request.getParameter("groupID"));
}
GroupDAO groupDAO = new GroupDAO();
String leaderID = groupDAO.getGroupVO(groupID).getUserID();
%>
<div id="sendMsg">
    <h2>To. <%=leaderID%><h2>
    <form method="post" action="sendMsgAction.jsp?groupID=<%= groupID %>" id="send-form">
        <input type="text" placeholder="제목을 입력하세요" name="msgTitle" id="msgTitle" maxlength="20">
        <input type="text" placeholder="내용을 입력하세요" name="msgContent" id="msgContent" class="intro" maxlength="200">
        <button type="submit" class="btn-blue" id="sb"><span>전송</span></button>
    </form>
</div>
</body>
</html>