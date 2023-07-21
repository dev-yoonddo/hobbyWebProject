<%@page import="event.EventDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="user.pwEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>
<style>
#updateicon, #toggleicon{
	margin-top: 15px;
}
</style>
<body>
<header>
<% 
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
BoardDAO bdDAO = new BoardDAO();
EventDAO eventDAO = new EventDAO();
//작성한 게시글이 5개 이상일 때 이벤트에 응모할 수 있는 팝업창이 뜨도록 한다.
//이벤트에 응모는 아이디당 한번씩만 가능하다.
int boardCount = bdDAO.getListByUser(userID).size(); //유저가 작성한 게시글 수 가져오기
int eventCount = eventDAO.getListByUser(userID).size(); //이벤트 응모 기록 가져오기
if(boardCount >= 5 && eventCount == 0){ //게시글이 5개 이상이고 이벤트 응모 기록이 없으면 팝업창 띄우기
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("window.open('eventPopUp.jsp', 'EVENT', 'width=500, height=550, top=50%, left=50%')");
	script.println("</script>");
}
%>
<!-- header -->
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
				<li><a href="userUpdate.jsp"><i class="fa-solid fa-gear" id="updateicon"></i></a></li>
				<li><a href="logout.jsp">LOGOUT</a></li>
				<%
					}
				%>
			</ul>
			<a onclick="toggleAct()" class="navbar_toggleBtn" id="toggleicon">
				<i class="fa-solid fa-bars"></i>
			</a>
	</nav>
</div>
</header>
<!-- header -->

<!-- section -->
<section>
<div class="main">
	<div class="main-text">
		<div id="m1">
		<i class="fa-regular fa-lightbulb fa-2x" style="padding-bottom: 20px;"></i><br>
		취미활동도 같이하고<br>지원금도 받고싶다면?
		<hr id="line">
		</div>		
		<% if(userID == null) {%>
		<div id="m2" onclick="location.href='join.jsp'">
		TOGETHER 회원가입
		</div>
		<%} else{%>
		<div id="m2" onclick="location.href='write.jsp'">
		글 작성하기
		</div>
		<%} %>
	</div>
	
	<div class="move_btns">
		<div class="moveTop">
			<i class="fa-solid fa-circle-arrow-up fa-2x"></i>
		</div>
		<div class="moveBottom">
			<i class="fa-solid fa-circle-arrow-down fa-2x"></i>
		</div>
	</div>
</div>



<div class="container-slide">
	<div id="slide-main">
	  <div id="slide-in">
	    <div id="content">
	<!--       Slide One -->
	      <div class="slide showing">
	        <img src="./image/sports.png">
	        <div class="details">
	          <h2>SPORTS</h2>
	            <div class="info-item">
	             <h2>함께 하러가기</h2>
	            </div>
	        	<form method="post" action="searchPage.jsp">
			      <input type="hidden" name="searchField2" value="SPORTS">
			      <div class="btn"><button type="submit">TOGETHER</button></div>
			    </form>
	        </div>
	      </div>
	<!--       Slide One -->
	<!--       Slide Two -->
	      <div class="slide">
	        <img src="./image/surfing.png">
	        <div class="details">
	          <h2>LEISURE SPORTS</h2>
	            <div class="info-item">
	              <h2>함께 하러가기</h2>
	            </div>           
		        <form method="post" action="searchPage.jsp">
			      <input type="hidden" name="searchField2" value="LEISURE">
			      <div class="btn"><button type="submit">TOGETHER</button></div>
			    </form>
	        </div>
	      </div>
	<!--       Slide Two -->
	<!--       Slide Three -->
	      <div class="slide">
	        <img src="./image/music.png">
	        <div class="details">
	          <h2>MUSIC</h2>
	            <div class="info-item">
	              <h2>함께 하러가기</h2>
	            </div>
	          	<form method="post" action="searchPage.jsp">
			      <input type="hidden" name="searchField2" value="MUSIC">
			      <div class="btn"><button type="submit">TOGETHER</button></div>
			    </form>
	        </div>
	      </div>
	<!--       Slide Three -->
	<!--       Slide Four -->
	      <div class="slide">
	        <img src="./image/other.png">
	        <div class="details">
	          <h2>OTHER</h2>
	            <div class="info-item">
	              <h2>함께 하러가기</h2>
	            </div>
	            <form method="post" action="searchPage.jsp">
			      <input type="hidden" name="searchField2" value="OTHER">
			      <div class="btn"><button type="submit">GO</button></div>
			    </form>
	        </div>
	      </div>
	<!--       Slide Four -->
	    </div>
	<!--     Swap Btns -->
	    <div class="arrowBtn"><i class="fa-solid fa-arrow-left"></i></div>
	    <div class="arrowBtn"><i class="fa-solid fa-arrow-right"></i></div>
	<!--     Swap Btns -->
	    
	  </div>
	</div>
</div>

<div class="container-banner">
	<div id="animatedBackground"></div>
</div>

</section>
<!-- section -->

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
opener.location.reload(); //부모창 리프레쉬
self.close(); //로그인 후 팝업창이 닫힌다.
   
function event(boardCount){
	if(boardCount >= 5){
		window.open("eventPopUp.jsp?userID=" + userID , "EVENT", "width=500, height=500, top=50%, left=50%") ;
	  	self.close();
	}
}
</script>
</body>
</html>