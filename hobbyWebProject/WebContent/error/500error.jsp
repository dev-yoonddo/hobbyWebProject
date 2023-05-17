<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>500 ERROR</title>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>

</head>
<style>
body{
	width: auto;
	height: 500px;
	margin-top: 150px;
	color: grey;
}
a{
	text-decoration: underline;
	cursor: pointer;
	color: blue;
}
a:hover{
	font-weight: bold;
}
h1{
	display: flex;
	justify-content: center;
}
</style>
<body>
<div id="error" style="width:auto; display: flex; justify-content: center;">
	<div style="justify-content: center;">
		<div style="font-size: 30px; display: flex; justify-content: center;"><i class="fa-regular fa-face-frown fa-10x"></i></div>
		<h1>500 Internet Server Error</h1>
		<h1>잠시후 다시 실행해주세요</h1>
		<a onclick="history.back()">돌아가기</a>
	</div>
</div>
</body>
</html>