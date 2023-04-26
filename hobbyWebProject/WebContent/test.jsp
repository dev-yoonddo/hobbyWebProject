<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@500&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>


<style>
body {
  background-color: rgb(10, 10, 10);
  display: flex;
  padding-top: 200px;
}

#gallery {
  height: 100%;
  width: 100%; 
  display: flex;
  display: flex;
}

.tile {
  border-radius: 10px;
  transition: transform 0.5s ease;
  height: 200px;
  width: 200px;
  background-color: rgb(204, 204, 255);
  margin:0 auto;
  display: flex;
}

.tile:hover {
  transform: scale(1.2);
}
.tile:hover > .text{
opacity: 0;
}
.tile:hover > .img {
  opacity: 1;
  transform: scale(1.1);
}

.img {
  width: 150px;
  height: 100px;
  opacity: 0;
  transition: opacity 0.5s ease,
    transform 0.5s ease;
  margin: 0 auto;
  align-items: center;
}
.item{
	width:150px;
	height: 100px;
	margin: 0 auto;
	padding: 20px;
	justify-content: center;
}



</style>

<body>
<%
%>
<div id="gallery">
  <div class="tile">
  <div class="text">
  테스트 111
  </div>
  	<div class="img">
  	 <div class="item">
	  	테스트중입니다
		<button type="button" class="btn-blue" id="btn-del"><span>삭제</span></button>
  	</div>
  	</div>
  </div>
</div>


</body>
</html>