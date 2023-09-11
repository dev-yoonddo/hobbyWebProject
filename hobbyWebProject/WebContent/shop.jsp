<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>SHOP</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=94bczwg9l7&submodules=geocoder"></script>

</head>
<style>
section{
	padding-top: 100px;
}
</style>
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

if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
	script.println("</script>");
}
if(!userID.equals("manager")){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('준비중입니다.')");
	script.println("history.back()");
	script.println("</script>");
}
%>
<!-- header -->
<header id="header">
<jsp:include page="/header/header.jsp"/>
</header>
<!-- header -->

<section>
<h3>위치 서비스 허용 후 이용해주세요 <br> 공용 네트워크 사용시 위치가 정확하지 않을 수 있습니다.</h3>
	<div id="map" style="width: 100%; height: 500px;"></div>
</section>
<script>
		var options = {
		  enableHighAccuracy: true,
		  timeout: 5000,
		  maximumAge: 0
		}

		
		function error(err) {
		  console.warn('ERROR(' + err.code + '): ' + err.message);
		}
		
		//사용자의 현재위치를 받아 마커로 표시한다.
		function success(pos) {
		  var crd = pos.coords;
		 	 var map = new naver.maps.Map('map', {
			    center: new naver.maps.LatLng(crd.latitude , crd.longitude),
			    zoom: 16
			});
			var marker = new naver.maps.Marker({
			    position: new naver.maps.LatLng(crd.latitude , crd.longitude),
			    map: map
			}); 
			  console.log('Your current position is:');
			  console.log('Latitude : ' + crd.latitude);
			  console.log('Longitude: ' + crd.longitude);
			  console.log('More or less ' + crd.accuracy + ' meters.');
		}
		navigator.geolocation.getCurrentPosition(success, error, options);
/*
 	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(37.5112, 127.0981), // 잠실 롯데월드를 중심으로 하는 지도
	    zoom: 15
	});

function createMap(location){
	var mapOptions = {
	    center: new naver.maps.LatLng(location), // 잠실 롯데월드를 중심으로 하는 지도
	    zoom: 15
	}
	var marker = new naver.maps.Marker({
	    position: new naver.maps.LatLng(location),
	    map: map
	}); 
}

function getCurrentPosition(){
	return navigator.geolocation.getCurrentPosition(resolve, reject);
}
const point = getCurrentPosition();
createMap(point);
*/
</script>
</body>
</html>