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
<link rel="stylesheet" href="css/board.css?after">
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
	height: auto;
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
				<li><a href="community.jsp" id ="menu">COMMUNITY</a></li>
				<li><a href="qnaPage.jsp" id="menu">Q & A</a></li>
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
		<h4 style="font-weight: bold; color: #646464;">글 쓰기</h4><br>
			<div class="row">
				<form method="post" action="writeAction.jsp">
					<table class="write-table" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr translate="yes">
								<th style="background-color: #464646; text-align: center; color: #ffffff;">문의하기</th>
							
								<th>
								<select class="form-control" name="boardCategory">
									<option value="0">CATEGORY</option>
									<option value="SPORTS" >SPORTS</option>
									<option value="LEISURE" >LEISURE</option>
									<option value="ART&MUSIC" >ART & MUSIC</option>
									<option value="OTHER" >OTHER</option>
								</select>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="boardTitle" maxlength="50"></td>
							</tr>
							<tr>
								<td><textarea class="form-control" placeholder="글 내용" name="boardContent" maxlength="2048" style="height: 350px;"></textarea></td>
							</tr>
						</tbody>
					</table>
					<button type="submit" class="btn-black" value="글쓰기"><span>작성하기</span></button>
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