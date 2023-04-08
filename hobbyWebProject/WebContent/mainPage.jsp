<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="css/board.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<script type="text/javascript" defer src="js/script.js"></script>
<script defer src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<style>
section{
}
.main{
	height: 600px;
	padding-top: 80px;
	background-image:linear-gradient(180deg, var(--colorTwo) 0%, var(--colorOne) 100%);
	display: flex;
	justify-content: center;
	align-items: center;
	
}
.main-text{
	width: 100%;
	height: 600px;
	display: flex;
	animation: compare 2s infinite alternate;
	
}
#m1{
	font-size: 40pt;
	font-weight: 600;
	position: absolute;
	bottom: 60%;
	left: 10%;
	animation:bounce 1s ease-in-out Infinite Alternate;
}
#m2{
	font-size: 25pt;
	font-weight: bold;
	position: absolute;
	bottom: 30%;
	left: 50%;
	color: white;
	background-color: #3c3c3c;
	border-radius: 50px;
	padding: 17px;
	cursor: pointer;
}
#line{
	width: 530px; 
	height: 2px; 
	background-color: black;
}
.move_btns{
	width: 30px;
	height: 50px;
	position: fixed;
	right: 3%; 
	bottom: 50%; 
	z-index: 100;
}
.moveTop , .moveBottom {
	cursor: pointer;
	padding-top: 10px;
}
.container{
	margin-top: 100px;
}
@media screen and (max-width:1200px) {
  #m1{
    font-size: 33pt;
    position: absolute;
  	bottom: 60%;
  }
  #m2{
    font-size: 17pt;
    position: absolute;
    bottom: 10%;
    left: 30%;
  }
  #line{
  	width: 450px;
  }
 }
 @media screen and (max-width:600px) {
  #m1{
  	font-size: 30pt;
  }
  #m2{
    font-size: 15pt;
    position: absolute;
    bottom: 15%;
    left: 30%;
  }
  .move_btns{
  	bottom: 10%;
  }
  #line{
  	width: 400px;
  }
 }
@keyframes bounce {
  0% {
    top:200px;
  }
  100% {
    top: 250px;
  }
}
</style>
</head>

<body>
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
			<li><a href="login.jsp">LOGIN</a></li>
			<li><a href="join.jsp">JOIN</a></li>
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
	<div id="m2">
	TOGETHER 회원가입
	</div>
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
<!--       Vehicle One -->
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
<!--       Vehicle One -->
<!--       Vehicle Two -->
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
<!--       Vehicle Two -->
<!--       Vehicle Three -->
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
<!--       Vehicle Three -->
<!--       Vehicle Four -->
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
<!--       Vehicle Four -->
    </div>
<!--     Swap Btns -->
    <div class="arrowBtn"><i class="fa-solid fa-arrow-left"></i></div>
    <div class="arrowBtn"><i class="fa-solid fa-arrow-right"></i></div>
<!--     Swap Btns -->
    
  </div>
</div>
</div>

<div class="container-banner">
<div id="animatedBackground">
</div>
</div>

</section>
<footer>
<hr>
<div class="inform">
	
	
		<ul>
     		<li class="m-0 text">06223 서울특별시 강남구 역삼로1004길 (역삼동, 대박타워) ㈜TOGETHER 대표이사 : 정윤서 | 사업자 등록번호: 222-22-22222｜통신판매업신고: 강남 1004호</li>
     		<li class="m-0 text">｜개인정보 보호책임자 : 정윤서 | 문의 : Webmaster@TOGETHER.co.kr | Copyright ⓒ TOGETHER. All rights reserved.</li>
     		<li class="m-0 text">㈜투게더의 사전 서면동의 없이 사이트(PC, 모바일)의 일체의 정보, 콘텐츠 및 UI 등을 상업적 목적으로 전재, 전송, 스크래핑 등 무단 사용할 수 없습니다.</liz>
   		</ul>
	
  	
</div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
<script>
</script>
</body>
</html>