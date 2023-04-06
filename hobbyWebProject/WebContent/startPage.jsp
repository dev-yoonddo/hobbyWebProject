<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script type="text/javascript" defer src="js/script.js"></script>
<script defer src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script defer src="option/jquery/jquery.min.js"></script>

<style type="text/css">
body{
	width: auto;
	height: 100%;
	background-color: #01002D;
}
header{
	height: 300px;
	padding-top: 100px;
}
section{
	height: 400px;
	display: flex;
	justify-content: center;
}
.start-text{
	width: 650px;
	margin-top: 100px;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 30pt;
	color: #ffffff;
	list-style: none;
	text-decoration: none;
}
.text1{
	align-items: center;
}
#animated-icon {
	font-size:35px;
	font-weight: 400;
	font-family: 'Gowun Dodum', sans-serif;
	color: #424242;
	position: relative;
	width: 1300px;
	margin-top: 100px;
	overflow-x: hidden;
	overflow-y: hidden;
}

#track1 {
	width: 1300px;
	position: absolute;
	margin: 0;
	white-space: nowrap;
	will-change: transform;
	animation: marquee1 7s linear infinite;
}
#track2 {
	width: 1300px;
	position: absolute;
	margin-top: 70px;
	white-space: nowrap;
	will-change: transform;
	animation: marquee2 7s linear infinite;
}
#track3 {
	width: 1300px;
	position: absolute;
	margin-top: 0px;
	white-space: nowrap;
	will-change: transform;
	animation: marquee3 3s linear infinite;	
}
#track4 {
	width: 1300px;
	position: absolute;
	margin-top: 100px;
	white-space: nowrap;
	will-change: transform;
	animation: marquee3 10s linear infinite;
}
@keyframes marquee1 {
  from { transform: translateX(0%); }
  to { transform: translateX(100%); }
}
@keyframes marquee2 {
  from { transform: translateX(100%); }
  to { transform: translateX(0%); }
}
@keyframes marquee3 {
  from { transform: translateX(70%); }
  to { transform: translateX(30%); }
}
@keyframes marquee4 {
  from { transform: translateX(20%); }
  to { transform: translateX(80%); }
}

</style>
</head>
<body>
	<header>
		<div id="animate-icon">
			<div id="track1">
				<div class="icon">
				<i class="fa-solid fa-person-biking fa-10x"></i>
				</div>
			</div>
			<div id="track2">
				<div class="icon">
				<i class="fa-solid fa-person-swimming fa-10x"></i>
				</div>
			</div>
			<div id="track3">
				<div class="icon">
				<i class="fa-solid fa-table-tennis-paddle-ball fa-10x"></i>		
				</div>
			</div>
			<div id="track4">
				<div class="icon">
				<i class="fa-solid fa-fish-fins fa-10x"></i>
				</div>
			</div>
		</div>
	</header>
	
	<section>
		<div class="start-web" align="center">
			<div class="start-text">
				<span class="text1"></span>
			</div><br><br><br>
			<div class="spinner-border text-light" role="status">
			  <span class="visually-hidden">Loading</span>
			</div>
		</div>
		
</section>
<footer>
</footer>	
<script>
  setTimeout('pageStart()', 6000); //5초후에 move_page함수실행
  function pageStart(){
  location.href="mainPage.jsp"  // 페이지 이동
  }
</script>
<script>
const content = "주말에 취미 활동 시작하고 싶은데.. 누구랑 하지?";
const text1 = document.querySelector('.text1');
let i = 0;

function typing(){
    if (i < content.length) {
	    let txt = content.charAt(i);
	    text1.innerHTML += txt;
	    i++;
    }
}
setInterval(typing, 150)
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
