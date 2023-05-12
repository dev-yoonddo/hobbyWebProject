<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="board.BoardDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>
</head>
<style>
section{
	height: 700px;
	display: flex;
	margin: 0;
	padding: 0;
	padding-top: 100px;
	margin-bottom: 150px;
	font-family: 'Nanum Gothic', monospace;
	font-weight: 500;
}
.board-container{
	width: 1000px;
	margin: 0 auto;
}
.write-table{
	width: 1000px;
}
select{
width: 200px;
height: 40px;
margin-bottom: 10px;
text-align: center;
font-size: 15pt;
font-weight: 500;
color: #B3C1EE;

}
option{
color: #B3C1EE;
height: 40px;
}
textarea{
width: 1000px;
font-size: 13pt;
font-family: 'Nanum Gothic', monospace;
border: none;
resize: none;
padding: 10px;
}
.inquiry{
padding-bottom: 100px;
}
#view-table{
width: 1000px;
height: 500px;
border-collapse: collapse;
border: 1px solid #C0C0C0;
font-size: 12pt;
}
.btn-blue{
	position: relative;
	display: inline-block;
	width: 90px;
	height: 70px;
	background-color: transparent;
	border: none; 
	cursor: pointer;
	margin: 10px;
	float: right;
}

.btn-blue span {         
  position: relative;
  display: inline-block;
  font-size: 12pt;
  font-weight: bold;
  letter-spacing: 2px;
  border-radius: 20px;
  width: 100%;
  padding: 10px;
  transition: 0.5s; 
  color: #ffffff;
  background-color: #7D95E5;
  border: 1px solid #7D95E5;
  font-family: 'Nanum Gothic Coding', monospace;
}

.btn-blue::before {
  background-color: #7D95E5;
}

.btn-blue span:hover {
  color: #7D95E5;
  background-color: #ffffff
}
</style>
<body>
		
<% 
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
} //로그인 확인 후 id값 얻어오기
%>
	<!-- header start-->
<header>
<div id="header" class="de-active">
	<nav class="navbar">
		<nav class="navbar_left">
			<div class="navbar_logo">
				<a href="mainPage.jsp" id="mainlogo" >TOGETHER</a>
			</div>
			<ul class="navbar_menu" style="float: left;">
				<li><a href="community.jsp" class ="menu">COMMUNITY</a></li>
				<% 
					if(userID == null){
				%>
				<li><a id="go-group-1" class="menu">GROUP</a></li>
				<%
					} else { 
				%>
				<li><a id="go-group-2" class="menu" onclick="location.href='groupPage.jsp'">GROUP</a></li>
				<%
					}
				%>
			</ul>
		</nav>
			<ul class="navbar_login" >
				<%
					if(userID == null){
				%>	
				<li><a href="login.jsp">LOGIN</a></li>
				<li><a href="join.jsp">JOIN</a></li>
				<%
					}else{
				%>
				<li><a href="userUpdate.jsp"><i class="fa-solid fa-gear"></i></a></li>
				<li><a href="logout.jsp">LOGOUT</a></li>
				<%
					}
				%>
			</ul>
			<a onclick="toggleAct()" class="navbar_toggleBtn">
				<i class="fa-solid fa-bars"></i>
			</a>
	</nav>
</div>
</header>
	<!-- header end-->
	
	<section>
	
		<div class="board-container">
		<h3 style="font-weight: bold; color: #646464;"><%= userID %>님 안녕하세요</h3><br>
			<div class="right-row">
				<form method="post" action="writeAction.jsp" >
					<div class="category-sel">
					<select name="boardCategory">
						<option value="0">CATEGORY</option>
						<option value="SPORTS" >SPORTS</option>
						<option value="LEISURE" >LEISURE</option>
						<option value="ART&MUSIC" >ART & MUSIC</option>
						<option value="OTHER" >OTHER</option>
					</select>
					</div>
					<table class="write-table" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr translate="yes">
								<th style="background-color: #DBE2F7; text-align: center; color: #464646; height: 40px;">글 작성</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><textarea placeholder="제목을 입력하세요" name="boardTitle" maxlength="50"></textarea></td>
							</tr>
							<tr>
								<td><textarea placeholder="내용을 입력하세요" name="boardContent" maxlength="2048" style="height: 350px;"></textarea></td>
							</tr>
						</tbody>
					</table>
					<button type="submit" class="btn-blue" value="글쓰기"><span>작성하기</span></button>
				</form>
				
			</div>
		</div>
	</section>
	
	<!-- footer start -->
	<footer><hr>
	
    	
	</footer>
	<!-- footer end-->
		<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>