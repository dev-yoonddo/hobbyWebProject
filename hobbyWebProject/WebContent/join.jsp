<%@page import="java.math.BigInteger"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/board.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
<script defer src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>

<style>
*{

    border: none;
}
body{
    font-size: 14px;
    font-family: 'Roboto', sans-serif;
}
.join-wrapper{
    width: 400px;
    height: 350px;
    padding: 40px;
    box-sizing: border-box;
}

.join-wrapper > h2{
    font-size: 24px;
    color: #6A24FE;
    margin-bottom: 20px;
}
#join-form > input{
    width: 100%;
    height: 48px;
    padding: 0 10px;
    box-sizing: border-box;
    margin-bottom: 16px;
    border-radius: 6px;
    background-color: #F8F8F8;
}
#join-form > input::placeholder{
    color: #D2D2D2;
}
#join-form > input[type="submit"]{
    color: #fff;
    font-size: 16px;
    background-color: #6A24FE;
    margin-top: 20px;
}
#join-form > input[type="checkbox"]{
    display: none;
}


}
</style>
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
 <div class="join-wrapper">
        <h2>회원가입<h2>
        <form method="post" action="joinAction.jsp" id="join-form" onsubmit="return passwordCheck(this)">
            <input type="text" name="userID" id="userID" placeholder="아이디 입력">
            <input type="text" name="userName" id="userName" placeholder="이름 입력">
            <input type="text" name="userBirth" id="userBirth" placeholder="생년월일 입력">
            <input type="text" name="userPhone" id="userPhone" placeholder="핸드폰번호 입력">
            <input type="password" name="userPassword" id="userPassword" placeholder="비밀번호 입력" onkeyup="passwordCheck2()">
            <input type="password" name="userPassword1" id="userPassword1" placeholder="비밀번호 확인" onkeyup="passwordCheck2()">
            <div class="check" style="text-align: center;">
				<h5 id="passwordCheckMessage" style="color: red; font-size: 14px;"></h5>
			</div>
            <input type="submit" value="join">
        </form>
    </div>
</section>
</body>
</html>