<%@page import="location.LocationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="location.LocationDAO"%>
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
	padding-top: 70px;
	height: 800px;
	position: relative;
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
#sec-left{
	width: 60%; 
	display: flex; 
	align-items: center; 
	margin-left: 50px;
}
#search{
	display: flex;
	justify-content: center;
	align-items: center;
}
#search-btn{
	display: flex;
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
#qna-icon{
}
#answer{
	width: 400px;
	height: 150px;
	font-size: 12pt;
	z-index: 999;
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
#mapInfo{
	width: auto;
	height: 220px;
	display: flex;
	align-items: center;
	position: absolute;
	z-index: 888;
	top: 22%;
	left: 70px;
}

#mapInfo-head{
	width: 300px;
	height: 70px;
	display: flex;
	align-items: center;
}
#mapList{
	height: 80px;
	max-height: 150px;
}
#regist span{
	width: 180px;
	color: #ffffff;
	background-color: #2E2F49;
	border: 1px solid #2E2F49;
}
#regist span:hover{
	color: #2E2F49;
	background-color: #ffffff;
}
/* 지도 위 infoWindow */
#info-window{
	width: auto;
	min-width: 250px;
	padding: 10px;
	font-size: 11pt;
	text-align: center;
	border-style: solid;
	border-width: 0.1px;
	border-radius: 10px;
}
#info-name{
	height: 30px;
	font-size: 13pt;
	font-weight: 900;
	margin : 0;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	
}
#info-spotName{
	height: 30px;
	cursor: pointer;
	margin-right: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
}
#info-join{
	height: 30px;
	font-size: 13pt;
	font-weight: bold;
	color: #7D95E5;
	display: none;
}
#info-spotName:hover ~ #info-join{
	display: flex;
	justify-content: center;
	align-items: center;
}
#name-icon{
	margin-right: 10px;
}

@media screen and (max-width:900px) {
	#search{
		display: inline-block;
	}
	#sec-left{
		width: 40%;
	}
	#map-qna{
		width: 60%;
	}
}
@media screen and (max-width:650px) {
	#sec-top{
		height: 120px;
		display: flex;
	}
	#sec-left{
		width: 60%;
		margin-left: 10px;
		font-size: 11pt;
	}
	#address{
		width: 200px;
		font-size: 12pt;
	}
	#search-btn{
	}
	#submit{
		width: 85px;
	}
	#submit span{
		font-size: 10pt;
	
	}
	#myLoc{
		width: 85px;
	}
	#myLoc span{
		font-size: 10pt;
	
	}
	#map-qna{
		width: 40%;
	}
	#mapInfo{
		top:22%;
		left: 20px;
		width: 360px;
		position: absolute;
		float: left;
	}
	#mapInfo-title{
		font-size: 11pt;
	}
	#regist{
	}
	#regist span{
		width: 180px;
		font-size: 10pt;
	}
	#mapList{
		font-size: 11pt;
	}
	#info-window{
		font-size: 10pt;
	}
	#info-name{
		font-size: 11pt;
	}
	#no-map{
		font-size: 11pt;
	}
	#question{
		width: 20px;
	}
	#qna-icon{
		display: block;
	}
	#qna-text{
		display: none;
	}
	.triangle{
		display: none;
	}
	#answer{
		width: 250px;
		height: 120px;
		top: 100px;
		right: 110px;
		position: relative;
	}
	#answer-text{
		width: 250px;
		height: 120px;
		font-size: 10pt;
	}
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
LocationDAO locDAO = new LocationDAO();
//지도 위에 표시할 저장된 스팟 리스트 가져오기
ArrayList<LocationDTO> locationList = locDAO.getSpotInfoList();

if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
	script.println("</script>");
}else{
%>
<!-- header -->
<header id="header">
<jsp:include page="/header/header.jsp"/>
</header>
<!-- header -->

<section>
<div id="sec-top">
	<div id="sec-left">
		<!-- <button type="button" id="schLoc" class="btn-blue" onclick="search()">위치검색하기</button> -->
		<div id="search">
	        <textarea id="address" placeholder="검색할 주소를 입력하세요 &#13;&#10;예) 불암로 55" maxlength="20"></textarea>
	        <div id="search-btn">
		        <button type="button" class="btn-blue" id="submit"><span>주소검색</span></button>
				<button type="button" class="btn-blue" id="myLoc"><span>현재위치</span></button>
			</div>
	    </div>
    </div>
	<div id="map-qna">
		<div id="question" onmouseover="question()">
			<i id="qna-icon" class="fa-solid fa-circle-question fa-2x" style="color: #bebebe;"></i>&nbsp;&nbsp;<h2 id="qna-text">현재 위치가 검색되지 않거나 정확하지 않은가요 ?</h2>
		</div>
		<div id="answer" hidden="">
			<div class="triangle triangle-bottom"></div>
			<div id="answer-text">
				<h3 style="margin-bottom: 7px;">위치가 정확하지 않거나 검색이 안되나요 ?</h3>
				<h3 style="margin-bottom: 7px;">1) 위치 서비스 허용 후 이용해주세요.</h3>
				<h3>2) 공용 네트워크 사용시 위치가 정확하지 않을 수 있습니다.</h3>
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
	<div id="map" hidden=""></div>
	<div id="mapInfo">
		<div style="width: 450px; max-width: 500px;" >
			<div id="mapInfo-head">
				<h3 id="mapInfo-title">주소 정보</h3>
				<button type="button" class="btn-blue" id="regist" onclick="registSpot()">
					<span>TOGETHER SPOT 등록</span>
				</button>
			</div>
			<table id="mapList"></table>
		</div>
	</div>
</section>
<%} %>
<script>
	var row = 0;
	var addr, latt, lonn = null;
	
	//데이터베이스에 저장된 위치 정보를 가져온다.
	var locationData = [
	    <% for (LocationDTO location : locationList) { %>
	        {
	            leader: "<%= location.getUserID() %>",
	            name: "<%= location.getSpotName() %>",
	            address: "<%= location.getAddress() %>",
	            latitude: <%= location.getLatitude() %>,
	            longitude: <%= location.getLongitude() %>,
	            crew: <%=location.getCrewCount()%>,
	            available: <%=location.getSpotAvailable()%>
	        },
	    <% } %>
	];
	
	$('#answer').hide();
	function question(){
		$('#answer').show();
	}
    
    //현재위치 버튼을 클릭하면 view 메서드 실행
	$('#myLoc').on('click', view);
	
    //사용자의 현재위치 데이터를 success와 error에 넘겨주기
	function view(){
		//navigator.geolocation.getCurrentPosition(success, error, options);
		navigator.geolocation.getCurrentPosition(success, error);
		//$('#search').hide();
	}

	//사용자의 현재위치를 받아 마커로 표시한다.
	function success(pos) {
	  	var crd = pos.coords;
	    //var latlng = new naver.maps.LatLng(crd.latitude, crd.longitude);
	    //현재위치의 위도,경도 정보를 reverse 메서드로 념긴다.
	    reverse(crd.latitude, crd.longitude);
	}
	
	//위도와 경도값으로 reverseGeoCode를 사용해 주소값 가져온 후 makeAddress 메서드로 주소를 만든다.
	function reverse(lat, lng){
	    var latlng = new naver.maps.LatLng(lat, lng);
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
				console.log(items);
	        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
	            item = items[i];
	            //reverseGeocode 데이터들은 온전한 주소의 형태가 아니기 때문에 조합해 주소를 만들어야 하기 때문에 makeAddress메서드로 값을 넘겨준다
	            address = makeAddress(item) || '';
	            //도로명 주소가 존재하면 도로명주소, 존재하지 않으면 지번주소를 주소타입으로 지정
	            addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';
				//console.log(item);
	        }
	        	console.log(address, addrType);
	        	//주소를 구했으면 serachAddressRoCoordinate 메서드에 넘겨주고 실행
	            searchAddressToCoordinate(address);

	    });
	}
	//현재위치를 구할 때 에러 발생시 에러메시지 출력
	function error(err) {
	    alert('Error getting location: ' + err.message);
	}
	
	//NAVR MAP API로 구한 주소들을 조합해 현재위치의 주소 구하기
	function makeAddress(item) {
	    if (!item) {
	        return;
	    }
	    var name = item.name,
	        region = item.region,
	        land = item.land,
	        isRoadAddress = name === 'roadaddr';

	    var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';

	    if (hasArea(region.area1)) {
	        sido = region.area1.name;
	    }

	    if (hasArea(region.area2)) {
	        sigugun = region.area2.name;
	    }

	    if (hasArea(region.area3)) {
	        dongmyun = region.area3.name;
	    }

	    if (hasArea(region.area4)) {
	        ri = region.area4.name;
	    }

	    if (land) {
	        if (hasData(land.number1)) {
	            if (hasData(land.type) && land.type === '2') {
	                rest += '산';
	            }

	            rest += land.number1;

	            if (hasData(land.number2)) {
	                rest += ('-' + land.number2);
	            }
	        }

	        if (isRoadAddress === true) {
	            if (checkLastString(dongmyun, '면')) {
	                ri = land.name;
	            } else {
	                dongmyun = land.name;
	                ri = '';
	            }

	            if (hasAddition(land.addition0)) {
	                rest += ' ' + land.addition0.value;
	            }
	        }
	    }

	    return [sido, sigugun, dongmyun, ri, rest].join(' ');
	}
	function hasArea(area) {
	    return !!(area && area.name && area.name !== '');
	}

	function hasData(data) {
	    return !!(data && data !== '');
	}

	function checkLastString (word, lastString) {
	    return new RegExp(lastString + '$').test(word);
	}

	function hasAddition (addition) {
	    return !!(addition && addition.value);
	}

	//주소를 입력하고 엔터키를 클릭하거나 주소검색 버튼을 클릭하면 searchAddressToCoordinate 메서드 실행
	$('#address').on('keydown', function(e) {
        var keyCode = e.which;
        if (keyCode === 13) { // Enter Key
            searchAddressToCoordinate($('#address').val());
        }
    });
    $('#submit').on('click', function(e) {
        e.preventDefault();
        searchAddressToCoordinate($('#address').val());
    });
	
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
            	alert('올바른 주소를 입력해주세요.');
            	//console.log(response.v2.meta.totalCount);
    			$('#no-map').show();
    			$('#map').hide();
    			//address의 값을 지운다.
    			$('#address').val('');
    			//올바른 주소가 아니면 table list를 지우고 row-- 해준다. row--를 하지 않으면 row == 1이기 때문에
    			//주소를 다시 올바르게 입력했을 때 newMapList에서 row == 1에 해당되면서 list가 존재하지 않는데 또 삭제를 하기때문에
    			//오류가 발생한다. 따라서 row--를 해줘서 이전 행이 삭제되지않고 바로 insertAddress 메서드로 넘어가도록 한다.
    			const adList = document.getElementById('mapList');
    			adList.deleteRow(0);
    			row--;
    			//console.log(row);
            }else{
            	//console.log(response.v2.meta.totalCount);
    			$('#map').show();
    			$('#no-map').hide();

	            var htmlAddresses = [],
	                item = response.v2.addresses[0],
	                point = new naver.maps.Point(item.x, item.y);
	            /*
	            if (item.roadAddress) {
	                htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
	            }
	            if (item.jibunAddress) {
	                htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	            }
	            if (item.englishAddress) {
	                htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
	            }
	            infoWindow.setContent([
	                '<div style="padding:10px;min-width:200px;line-height:150%;">',
	                '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
	                htmlAddresses.join('<br />'),
	                '</div>'
	            ].join('\n'));*/
	            
	            //item.x == longitude , item.y == latitude
	            newMapList(item.roadAddress, item.x, item.y, item.jibunAddress, item.englishAddress);
	            //infoWindow.open(map, point);
	            $('#address').val('');
            }
        });
    }
	//위 메서드가 처음 실행되면 row = 0으로 바로 insertAddress 메서드가 실행되지만
	//두번째 검색부터는 row = 1이기 때문에 이전 행을 삭제하고 insertAddress 메서드를 실행한다.
	function newMapList(address, longitude , latitude, jibun, engAd) {
		//console.log(address);
		//console.log(row);
   		if(row === 1){ // 검색이 두번 실행되면
   			const table = document.getElementById('mapList');
   			table.deleteRow(0); //이전 행 삭제
   			row--; //row값을 -1 해줘야 row값이 0 또는 1로만 반복된다.
			//console.log(latitude + ", " + longitude); 위도 경도 출력
   		}
   		insertAddress(address, longitude , latitude , jibun, engAd);
  	}
	
	//newMapList에서 가져온 정보들을 화면에 출력하고 지도의 위치를 변경한다.
   	function insertAddress(address, longitude , latitude , jibun, engAd){
   		var mapList = "";
    	mapList += "<tr>" 
    	mapList += "	<td>" + "[도로명주소] " + address +"<br>"+ "[지번주소] " + jibun +"<br>"+ "[영문주소] " + engAd +"</td>"
    	mapList += "</tr>"
    	$('#mapList').append(mapList);
    	row++; //모두 실행되면 row + 1 해준다.
    	
    	//address 값이 없으면 지번주소를 address에 넣어준다.
    	if(address === null || address === ''){
    		addr = jibun;
    	}else{
    		addr = address;
    	}
    	latt = latitude;
    	lonn = longitude;
    	rePlaceMap(latitude, longitude);
   	}
	
	var info = 0;
	var clickedInfoAddress;
	var clickleader = null;
	var clickname = null;
	var clickaddress = null;
   	//검색한 주소 또는 클릭한 주소로 지도와 마커의 위치를 변경한다.
    function rePlaceMap(latitude, longitude){

    	var map = new naver.maps.Map('map', {
    	    center: new naver.maps.LatLng(latitude, longitude),
    	    zoom: 16
    	});
        var marker = new naver.maps.Marker({
            map: map,
            position: new naver.maps.LatLng(latitude, longitude),
            icon: {
      	    	 url: './image/location-dot.png', //아이콘 경로
      	    }
        });
        //지도를 클릭했을 때의 위도,경도를 reverse 메서드로 넘겨주고 marker의 위치를 변경한다.
        naver.maps.Event.addListener(map, 'click', function(e) {
    	    marker.setPosition(e.latlng);
    	    reverse(e.latlng.y, e.latlng.x); //e.latlng.x == longitude & e.latlng.y == latitude
    	    //console.log(e.latlng.y);
    	});
        
        //데이터베이스의 locationData 길이만큼 반복해 각 위치에 marker2를 생성하고 marker2를 클릭하면 해당하는 정보를 infoWindow에 표시한다.
        for (var i = 0; i < locationData.length; i++) {
            var location = locationData[i];
            var latlng = new naver.maps.LatLng(location.latitude, location.longitude);
            var infoContent = [
            	'<div id="info-window">',
            	'<div id="info-name" onclick="joinSpot()"><i id="name-icon" class="fa-solid fa-globe"></i>',
            	'<div id="info-spotName">' + location.name + '</div><div id="info-join">참여</div></div>', 
            	'<div id="info-address">'+ location.address + '</div>',
            	'<div id="info-member"> Crew : '+ location.crew + '명</div>',
            	'</div>'
            ].join('');
            var infoWindow = new naver.maps.InfoWindow({
            	//content: infoContent
                content: infoContent,
                borderWidth: 0,
                anchorSize: new naver.maps.Size(10, 10)
            });
            
			//locationData의 marker들의 옵션
            var markerOptions = {
           	    position: latlng, //마커찍을 좌표
           	    map: map,
           	    icon: {
           	    	 url: './image/map-pin-navy.png', //아이콘 경로
           	    }
           	};
            var markerOptions2 = {
            	position: latlng, //마커찍을 좌표
            	map: map,
         	};
            //삭제되지 않은 스팟만 지도에 표시하고 클릭하면 infoWindow 표시하기
            if(location.available == 1){
	            var marker2 = new naver.maps.Marker(markerOptions);
	            
	            function handleMarkerClick(clickedMarker, clickedInfoWindow, leader, name, address) {
	                return function () {
	                    clickedInfoWindow.open(map, clickedMarker);
	                    clickleader = leader; //marker를 클릭하면 해당스팟 리더와 스팟이름, 주소를 따로 저장
						clickname = name;
						clickaddress = address;
	                };
	            }
	            //
	            naver.maps.Event.addListener(marker2, 'click', handleMarkerClick(marker2, infoWindow, location.leader, location.name, location.address));
	            
            }
        }
    } 
   	
   	//스팟 저장하기
    function registSpot() {
	   	var name;
        if(addr == null || latt == null || lonn == null){
        	alert('스팟 주소를 검색하세요');
        	return;
        }else{
	        while (true) {
	            name = prompt('스팟 이름을 입력해주세요');
	
	            if (name === null) {
	                return;
	            } else if (name.trim() === '') {
	                alert('이름을 다시 입력해주세요');
	            } else {
	                break;
	            }
	        }
	      	//저장된 데이터들을 가져온다.
	        var data = {
	            name: name, //name은 while문에서 가져오기 때문에 while문 뒤에 위치해야한다.
	            address: addr,
	            latitude: latt,
	            longitude: lonn
	        };
	        $.ajax({
	            type: 'POST',
	            url: 'https://toogether.me/spotRegistAction',
	            //url: 'spotRegistAction',
	            data: data,
	            success: function (response) {
	            	//spotRegistAction.jsp 페이지를 실행한 후 문자가 포함되어 있는지에 따라 알림창에 결과를 알려준다.
	            	if (response.includes("Spot saved successfully")) {
		                //console.log('Spot registration successful:', response);
		                alert('스팟 등록 완료');
		               	location.reload(true);
		                //console.log(data);
	            	}else if(response.includes("Information Error")){
	            		alert('원하는 스팟 주소를 검색하세요');
	            	}else if(response.includes("Spot name already exists")){
	            		//console.error('Spot registration error:', response);
	                    alert('이미 존재하는 이름입니다');
	            	}else{
	            		alert('이미 존재하는 주소입니다');
	            	}
	            },
	            error: function (xhr, status, error) {
	                //console.error('Spot registration error:', error);
	                alert('스팟 등록 오류');
	            }
	        });
        }
    }
    
    function joinSpot(){
    	console.log("Clicked on location: " + clickname);
        console.log("Address: " + clickaddress);
        var joinResult = confirm('참여 하시겠습니까?');
        if(joinResult){
	        var data2 = {
	        	leader: clickleader,//marker를 클릭했을 때 저장된 clickleader, clickname,clickaddress 가져오기
	            name: clickname,
	            address: clickaddress
	        };
	        $.ajax({
	            type: 'POST',
	            url: 'https://toogether.me/spotJoinAction',
	            //url: 'spotJoinAction',
	            data: data2,
	            success: function (response) {
	            	if (response.includes("Spot joined successfully")) {
	            		alert('스팟 참여 완료');
		               	location.reload(true);
	            	}else if(response.includes("leaders cannot join")){
	            		alert('스팟 생성 유저는 가입할 수 없습니다.')
	            	}else if(response.includes("joined exist")){
	            		alert('이미 참여한 스팟입니다.');
	            	}else if(response.includes("Join Error")){
	            		alert('참여 오류');
	            	}else if(response.includes("Database Error")){
	            		alert('데이터베이스 오류');
	            	}else{
	            		alert('정보 오류');	            		
	            	}
	            },
		        error: function (xhr, status, error) {
		            //console.error('Spot registration error:', error);
		            alert('스팟 참여 오류');
		        }
	        });
        }else{
        	return;
        }
    }
   	
/* 기본 지도 생성하기
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
//내 현재위치 지도 생성하기
function getCurrentPosition(){
	return navigator.geolocation.getCurrentPosition(resolve, reject);
}
const point = getCurrentPosition();
createMap(point);
*/
</script>

</body>
</html>