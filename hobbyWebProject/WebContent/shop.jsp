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
	height: 1000px;
}
textarea {
    border: medium;
    resize: none;
    font-size: 13pt;
}
.btn-blue{
	width: 100px;
	height: 50px;
}
#sec-top{
	height: 100px;
	 display: flex;
	 margin: 20px;
}
#search{
	display: flex;
	justify-content: center;
	align-items: center;
}
#address{
	width: 250px;
	height: 40px;
	display: flex;
	border-style: solid;
	border-radius: 20px;
	border-width: 3px;
	border-color: #B8D7FF;
	margin: 0;
	padding: 8px;
}
#map-qna{
	width: 40%; 
	color: #606060; 
	display: flex;
	margin: 0 auto;
	justify-content: center;
	align-items: center;
}
#question{
	width: 450px;
	height: 50px;
	font-size: 10pt;
	cursor: pointer;
	display: flex;
	margin: 0 auto;
	justify-content: center;
	align-items: center;
	position: absolute;
}
#question:hover{
	font-weight: bolder;
	color: black;
}
#answer{
	width: 400px;
	height: 150px;
	font-size: 12pt;
	z-index: 100;
	position: relative;
	margin: 0 auto;
	top: 80px;
}
#answer-text{
	background-color: #E0EBFF;
	 border-radius: 10px; 
	 width: 380px;
	 padding: 10px;
}
.triangle{
	display: inline-block;
	border: 20px solid transparent;
	margin-left: 45%;
}
.triangle-bottom{
	border-bottom-color: #E0EBFF;
}
h3{
	margin: 0;
}
#no-map , #map{
	width: 100%; 
	height: 600px;
}
#no-map{
	width: 100%;
	display: flex;
	background-color: #F6F6F6;
	font-size: 17pt;
	margin: 0 auto;
	justify-content: center;
	align-items: center;
}
#no-map-text{
	text-align: center;
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
<div id="sec-top">
	<div style="width: 60%; display: flex; align-items: center; margin-left: 50px;">
		<!-- <button type="button" id="schLoc" class="btn-blue" onclick="search()">위치검색하기</button> -->
		<div id="search" style="display: flex;">
	        <textarea id="address" placeholder="검색할 주소를 입력하세요 &#13;&#10;예) 불암로 55" maxlength="20"></textarea>
	        <button type="button" class="btn-blue" id="submit"><span>주소검색</span></button>
	    </div>
		<button type="button" class="btn-blue" id="myLoc"><span>현재위치</span></button>
    </div>
	<div id="map-qna">
		<div id="question" onmouseover="question()" onmouseout="questionOut()">
			<h2><i class="fa-solid fa-circle-question" style="color: #bebebe;"></i> 현재 위치가 검색되지 않거나 정확하지 않은가요 ?</h2>
		</div>
		<div id="answer" hidden="">
			<div class="triangle triangle-bottom"></div>
			<div id="answer-text">
				<h3 style="margin-bottom: 7px;">1) 위치 서비스 허용 후 이용해주세요</h3><h3>2) 공용 네트워크 사용시 위치가 정확하지 않을 수 있습니다.</h3>
			</div>
		</div>
	</div>
</div>
	<div id="no-map">
		<div id="no-map-text">
			<h3 style="margin-bottom: 7px;">위치 정보가 존재하지 않습니다</h3>
			<h3>Location information does not exist.</h3>
		</div>
	</div>
	<div id="map"></div>
	<table id="mapList"></table>
</section>
<script>
var row = 0;
	function view(){
		//navigator.geolocation.getCurrentPosition(success, error, options);
		navigator.geolocation.getCurrentPosition(success, error);
		//$('#search').hide();
	}
	function question(){
		$('#answer').show();
	}
	function questionOut(){
		$('#answer').hide();
	}
	/*function search(){
		$('#search').show();
		
	}*/
		/*var options = {
		  enableHighAccuracy: true,
		  timeout: 5000,
		  maximumAge: 0
		}
		function error(err) {
		  console.warn('ERROR(' + err.code + '): ' + err.message);
		}*/
		
		var map , marker, infoWindow;
		//사용자의 현재위치를 받아 마커로 표시한다.
		function success(pos) {
			var ad;
			$('#no-map').hide();
			//console.log(pos);
		  	var crd = pos.coords;
		    var latlng = new naver.maps.LatLng(crd.latitude, crd.longitude);
		    
		    var map = new naver.maps.Map('map', {
		        center: latlng,
		        zoom: 16
		    });

		    var marker = new naver.maps.Marker({
		        position: latlng,
		        map: map
		    });
		    
		  	naver.maps.Service.reverseGeocode({
		        coords: latlng ,
		        orders: [
		            naver.maps.Service.OrderType.ADDR,
		            naver.maps.Service.OrderType.ROAD_ADDR
		        ].join(',')
		    }, function (status, response) {
		    	if (status === naver.maps.Service.Status.ERROR) {
		            return alert('Something Wrong!');
		        }
		    	 var items = response.v2.results,
		            address = '',
		            htmlAddresses = [];

		        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
		            item = items[i];
		            address = makeAddress(item) || '';
		            addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';

		        }
		        	console.log(address);
		            searchAddressToCoordinate(address);

		    });
		}
		function error(err) {
		    // Handle errors when getting the user's location
		    alert('Error getting location: ' + err.message);
		}
		$('#myLoc').on('click', view);

			  //console.log('Your current position is:');
			  //console.log('Latitude : ' + crd.latitude);
			  //console.log('Longitude: ' + crd.longitude);
			  //console.log('More or less ' + crd.accuracy + ' meters.');
		
		/*//지도 이동을 위한 메서드
		function moveMap(len, lat) {
			var mapOptions = {
				    center: new naver.maps.LatLng(len, lat),
				    zoom: 15,
				    mapTypeControl: true
				};
				var map = new naver.maps.Map('map', mapOptions);
				var marker = new naver.maps.Marker({
				    position: new naver.maps.LatLng(len, lat),
				    map: map
				});
				
		}*/
		
		$('#address').on('keydown', function(e) {
	        var keyCode = e.which;
	        if (keyCode === 13) { // Enter Key
	            searchAddressToCoordinate($('#address').val());
	        }
	    });
	    $('#submit').on('click', function(e) {
	    	$('#mapList').remove();
	        e.preventDefault();
	        searchAddressToCoordinate($('#address').val());
	    });
	    naver.maps.Event.once(map);
	   // naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
		
	   /*var infoWindow = new naver.maps.InfoWindow({
			    anchorSkew: true
			});*/
	   //검색한 주소의 도로명,지번,영문명 주소를 각각 출력해 지도위에 표시하는 메서드

	   
	    function searchAddressToCoordinate(address) {
	        naver.maps.Service.geocode({
	        query: address
	        }, function(status, response) {
	            if (status === naver.maps.Service.Status.ERROR) {
	    			$('#no-map').show();
	    			$('#map').hide();
	    			//address의 값을 지운다.
	    			$('#address').val('');
	                alert('Something Wrong!');
	            }
	            else if (response.v2.meta.totalCount === 0) {
	            	console.log(response.v2.meta.totalCount);
	    			$('#no-map').show();
	    			$('#map').hide();
	    			//address의 값을 지운다.
	    			$('#address').val('');
	                alert('올바른 주소를 입력해주세요.');
	            }else{
	            	//console.log(response.v2.meta.totalCount);
	    			$('#map').show();
	            	$('#no-map').hide();
		            var htmlAddresses = [],
		                item = response.v2.addresses[0],
		                point = new naver.maps.Point(item.x, item.y);
		            if (item.roadAddress) {
		                htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
		            }
		            if (item.jibunAddress) {
		                htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
		            }
		            if (item.englishAddress) {
		                htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
		            }
		            /*infoWindow.setContent([
		                '<div style="padding:10px;min-width:200px;line-height:150%;">',
		                '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
		                htmlAddresses.join('<br />'),
		                '</div>'
		            ].join('\n'));*/
		            newMapList(item.roadAddress, item.x, item.y, item.jibunAddress, item.englishAddress);
		            //infoWindow.open(map, point);
		            $('#address').val('');
	            }
	        });
	    }
			//위 메서드가 처음 실행되면 row = 0으로 바로 insertAddress 메서드가 실행되지만
			//두번째 검색부터는 row = 1이기 때문에 이전 행을 삭제하고 insertAddress 메서드를 실행한다.
			function newMapList(address, latitude, longitude , jibun, engAd) {
	   		    console.log(address);
	    		if(row === 1){
	    			const table = document.getElementById('mapList');
	    			table.deleteRow(0); //이전 행 삭제
	    			row--; //row값을 -1 해줘야 row값이 0 또는 1로만 반복된다.
					//console.log(latitude + ", " + longitude); 위도 경도 출력
	    		}
	    		insertAddress(address, latitude, longitude , jibun, engAd);
	   		 }
	    	function insertAddress(address, latitude, longitude , jibun, engAd){
	    		var mapList = "";
		    	mapList += "<tr>" 
		    	mapList += "	<td>" + address +"<br>"+ latitude +"<br>"+ longitude +"<br>"+ jibun +"<br>"+ engAd +"</td>"
		    	mapList += "</tr>"
		    	$('#mapList').append(mapList);
		    	
		    	//검색한 장소로 지도와 마커의 위치를 변경한다.
		    	var map = new naver.maps.Map('map', {
		    	    center: new naver.maps.LatLng(longitude, latitude),
		    	    zoom: 16
		    	});
		        var marker = new naver.maps.Marker({
		            map: map,
		            position: new naver.maps.LatLng(longitude, latitude),
		        });
		    	row++; //모두 실행되면 row + 1 해준다.
	    	}
	    	 
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