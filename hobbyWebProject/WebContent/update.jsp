<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
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
.write-table{
	width: 1000px;
}
#view-table{
width: 1000px;
height: 500px;
border-collapse: collapse;
border: 1px solid #C0C0C0;
font-size: 12pt;
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

.td{
text-align: center;
font-size: 13pt;
}
.td span{
	
padding: 10px 20px;
border-radius: 20px;
background-color: #CCE5FF;
}
#view-title{
font-weight: bold;
font-size: 25pt;
color: #646464;
font-family: 'Noto Sans KR', sans-serif;
animation: fadeInLeft 2s;
}

textarea{
width: 1000px;
font-size: 13pt;
font-family: 'Nanum Gothic', monospace;
border: none;
resize: none;
padding: 10px;
}
</style>
<body>
		
<%
//userID 가져오기
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
}

//boardID 가져오기
int boardID = 0;
if(request.getParameter("boardID") != null){
	boardID = Integer.parseInt(request.getParameter("boardID"));
}

BoardDTO board = new BoardDAO().getBoardVO(boardID);
%>
<!-- header -->
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
<!-- header -->
<!-- section -->
<section>
	
		<div class="board-container">
		<h3 style="font-weight: bold; color: #646464;"><%= userID %>님 안녕하세요</h3><br>
			<div class="right-row">
				<form method="post" action="updateAction.jsp?boardID=<%= boardID %>">
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
								<th style="background-color: #DBE2F7; text-align: center; color: #464646; height: 40px;">글 수정</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><textarea placeholder="제목을 입력하세요" name="boardTitle" maxlength="50"><%= board.getBoardTitle() %></textarea></td>
							</tr>
							<tr>
								<td><textarea placeholder="내용을 입력하세요" name="boardContent" maxlength="2048" style="height: 350px;"><%= board.getBoardContent() %></textarea></td>
							</tr>
						</tbody>
					</table>
					<button type="submit" class="btn-blue" value="글쓰기"><span>수정하기</span></button>
				</form>
			</div>
		</div>
	</section>
<!-- footer -->
<footer>
<hr>
<div class="inform">
	<ul>
		<li>06223 서울특별시 강남구 역삼로1004길 (역삼동, 대박타워) ㈜TOGETHER 대표이사 : 정윤서 | 사업자 등록번호: 222-22-22222｜통신판매업신고: 강남 1004호</li>
		<li>｜개인정보 보호책임자 : 정윤서 | 문의 : Webmaster@TOGETHER.co.kr | Copyright ⓒ TOGETHER. All rights reserved.</li>
		<li>㈜투게더의 사전 서면동의 없이 사이트(PC, 모바일)의 일체의 정보, 콘텐츠 및 UI 등을 상업적 목적으로 전재, 전송, 스크래핑 등 무단 사용할 수 없습니다.</liz>
	</ul>
</div>
</footer>
<!-- footer -->
<script>
let boardCategory = '<%= board.getBoardCategory() %>';

let selectBox = document.getElementsByName('boardCategory')[0];

for (let i = 0; i < selectBox.options.length; i++) {
  if (selectBox.options[i].value === boardCategory) {
    selectBox.options[i].setAttribute('selected', 'selected');
    break;
  }
}
</script>
</body>
</html>