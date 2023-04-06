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
	bottom: 35%;
	left: 10%;
	animation:bounce 1s ease-in-out Infinite Alternate;
}
#m2{
	font-size: 17pt;
	font-weight: bold;
	position: absolute;
	bottom: 35%;
	left: 50%;
	color: white;
	background-color: #3c3c3c;
	border-radius: 50px;
	padding: 15px;
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
@media screen and (max-width:1200px) {
  #m2{
    position: absolute;
    bottom: 15%;
    left: 30%;
  }
 }
 @media screen and (max-width:600px) {
  #m1{
  	font-size: 30pt;
  }
  #m2{
    position: absolute;
    bottom: 25%;
    left: 25%;
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
			<li><a onclick="ClickStack()" id ="menu">COMMUNITY</a></li>
			<li><a onclick="ClickQNA()" id="menu">Q & A</a></li>
		</ul>
	</nav>
		<ul class="navbar_login" >
			<li><a href="user.jsp">LOGIN</a></li>
			<li><a href="blog.jsp">JOIN</a></li>
		</ul>
		<a onclick="toggleAct()" class="navbar_toggleBtn">
			<i class="fa-solid fa-bars"></i>
		</a>
</nav>
</div>
</header>
<section>
<div class="main">
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



<div class="container">
<div id="slide-main">
  <div id="slide-in">
    <div id="content">
<!--       Vehicle One -->
      <div class="slide showing">
        <img src="https://contentservice.mc.reyrey.net/image_v1.0.0/?id=bcc24faa-00f1-5165-8a61-084cf088d117&637062227314430208" alt="2020 GMC Canyon" />
        <div class="car-details">
          <h2>Golf & Tennis</h2>
          <div class="c-info">
            <div class="c-info-item">
              STARTING AT
              <h2>$XX,XXX</h2>
            </div>
          </div>
          
          <div class="btn"><a href="#">SHOP NOW</a></div>
        </div>
      </div>
<!--       Vehicle One -->
<!--       Vehicle Two -->
      <div class="slide">
        <img src="https://contentservice.mc.reyrey.net/image_v1.0.0/?id=bcc24faa-00f1-5165-8a61-084cf088d117&637062227314430208" alt="2020 GMC Canyon" />
        <div class="car-details">
          <h2>Swimming & Surfing</h2>
          <div class="c-info">
            <div class="c-info-item">
              STARTING AT
              <h2>$XX,XXX</h2>
            </div>           
          </div>
          
          <div class="btn"><a href="#">SHOP NOW</a></div>
        </div>
      </div>
<!--       Vehicle Two -->
<!--       Vehicle Three -->
      <div class="slide">
        <img src="https://contentservice.mc.reyrey.net/image_v1.0.0/?id=bcc24faa-00f1-5165-8a61-084cf088d117&637062227314430208" alt="2020 GMC Canyon" />
        <div class="car-details">
          <h2>Running & Weight Training</h2>
          <div class="c-info">
            <div class="c-info-item">
              STARTING AT
              <h2>$XX,XXX</h2>
            </div>
          </div>
          
          <div class="btn"><a href="#">SHOP NOW</a></div>
        </div>
      </div>
<!--       Vehicle Three -->
<!--       Vehicle Four -->
      <div class="slide">
        <img src="https://contentservice.mc.reyrey.net/image_v1.0.0/?id=bcc24faa-00f1-5165-8a61-084cf088d117&637062227314430208" alt="2020 GMC Canyon" />
        <div class="car-details">
          <h2>Biking & Hiking</h2>
          <div class="c-info">
            <div class="c-info-item">
              STARTING AT
              <h2>$XX,XXX</h2>
            </div>
          </div>
          <div class="btn"><a href="#">SHOP NOW</a></div>
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

<div class="container">
<div id="animatedBackground">
	<div id= "animatedText">
        <div>역삼동 서울특별시 강남구 <br>이전 활동 기준 <br>위치 업데이트</div>
        <div>역삼동 서울특별시 강남구 <br>이전 활동 기준 <br>위치 업데이트</div>
        <div>역삼동 서울특별시 강남구 <br>이전 활동 기준 <br>위치 업데이트</div>
        <div>역삼동 서울특별시 강남구 <br>이전 활동 기준 <br>위치 업데이트</div>
	</div>
</div>
</div>

</section>


<script>
$('#m2').hide();
$('#m2').fadeIn(5000);

</script>
</body>
</html>