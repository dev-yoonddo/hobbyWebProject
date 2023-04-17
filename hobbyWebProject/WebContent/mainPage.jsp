<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="css/board.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>


</head>

<body>
<header>
<% 
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
} %>
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
<section>
<div class="main">
<div id="message"></div>
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
		<div id="m2" onclick="alert('이미 회원입니다.')">
		TOGETHER 회원가입
		</div>
		<%} %>
	</div>
	
	<div class="move_btns">
	  <div class="moveTop" onclick="topBtn()">
	  <i class="fa-solid fa-circle-arrow-up fa-2x"></i>
	  </div>
	  <div class="moveBottom" onclick="bottomBtn()">
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
        <img src="./image/hike.png">

        <div class="details">
          <h2>SPORTS</h2>
            <div class="info-item">
             <h2>인원 모집중</h2>
            </div>
        
          
          <div class="btn"><a href="#">TOGETHER</a></div>
        </div>
      </div>
<!--       Slide One -->
<!--       Slide Two -->
      <div class="slide">
        <img src="https://contentservice.mc.reyrey.net/image_v1.0.0/?id=bcc24faa-00f1-5165-8a61-084cf088d117&637062227314430208" alt="2020 GMC Canyon" />
        <div class="details">
          <h2>LEISURE SPORTS</h2>
            <div class="info-item">
              <h2>인원 모집중</h2>
            </div>           
          
          <div class="btn"><a href="#">TOGETHER</a></div>
        </div>
      </div>
<!--       Slide Two -->
<!--       Slide Three -->
      <div class="slide">
        <img src="https://contentservice.mc.reyrey.net/image_v1.0.0/?id=bcc24faa-00f1-5165-8a61-084cf088d117&637062227314430208" alt="2020 GMC Canyon" />
        <div class="details">
          <h2>MUSIC & INSTRUMENT</h2>
            <div class="info-item">
              <h2>인원 모집중</h2>
            </div>
          
          <div class="btn"><a href="#">TOGETHER</a></div>
        </div>
      </div>
<!--       Slide Three -->
<!--       Slide Four -->
      <div class="slide">
        <img src="https://contentservice.mc.reyrey.net/image_v1.0.0/?id=bcc24faa-00f1-5165-8a61-084cf088d117&637062227314430208" alt="2020 GMC Canyon" />
        <div class="details">
          <h2>OTHER</h2>
            <div class="info-item">
              <h2>찾아보기</h2>
            </div>
          <div class="btn"><a href="#">GO</a></div>
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

</body>
</html>