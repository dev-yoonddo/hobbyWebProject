<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="location.LocationDTO"%>
<%@page import="crew.CrewDTO"%>
<%@page import="crew.CrewDAO"%>
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
<title>SPOT</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
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
	// DB에 저장된 스팟 리스트 가져오기
	ArrayList<LocationDTO> locationList = LocationDAO.getInstance().getSpotInfoList();
	//모든 위치 데이터를 넣을 Map
    Map<String, Object> locationMap = new HashMap<>();
 
    for(LocationDTO location:locationList){
    	//하나의 스팟 데이터를 각각 저장하기 위한 HashMap
        HashMap<String, Object> locationData = new HashMap<>(); 
        locationData.put("leader", location.getUserID()); //key,value값 저장
        locationData.put("name", location.getSpotName());
        locationData.put("address", location.getAddress());
        locationData.put("latitude", location.getLatitude());
        locationData.put("longitude", location.getLongitude());
        locationData.put("crew", location.getCrewCount());
        locationData.put("available", location.getSpotAvailable());
        
        //spot name을 key로, 위에서 저장한 locationData를 value로 반복될 때 마다 저장한다.
        locationMap.put(location.getSpotName(), locationData);
    }
  	//저장한 데이터들을 JSON객체로 변환한다.
	Object locationJSON = new JSONObject(locationMap);
	
//	System.out.println(locationMap);
//	System.out.println("json :" + locationJSON);

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
		<div id="question" onmouseover="question()" onmouseout="questionOut()">
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

<script type="text/javascript">
	var locationData = <%=locationJSON%>; //Object.values(<%=locationJSON%>) 미리 value 값만 추출할 수 있다.
</script>
<script type="text/javascript" src="js/spot.js"></script>

</body>
</html>