<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="css/board.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
</head>

<body>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	UserDTO user=new UserDAO().getUserVO(userID);
%>
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
				<%
					if(userID == null){
				%>	
				<li><a href="login.jsp">LOGIN</a></li>
				<li><a href="join.jsp">JOIN</a></li>
				<%
					}else{
				%>
				<li><a href="logout.jsp">LOGOUT</a></li>
				<%
					}
				%>
			</ul>
			<a onclick="toggleAct()" class="navbar_toggleBtn">
				<i class="fa-solid fa-bars"></i>
			</a>
	</nav>
</div>
</header>
<section>
<div class="user-info">
 	<div>
        <h2>내 정보 수정<h2>
        <form method="post" action="userUpdateAction.jsp" id="user-update" onsubmit="return passwordCheck(this)">
		<input type="text" value=<%=user.getUserID()%> name="userID" id="userID" maxlength="20">
		<input type="text" value=<%=user.getUserName()%> name="userName" id="userName"maxlength="20">
		<input type="text" value=<%=user.getUserBirth()%> name="userBirth" id="userBirth" maxlength="20">
		<input type="text" value=<%=user.getUserPhone()%> name="userPhone" id="userPhone" maxlength="20">
		<input type="password" value=<%=user.getUserPassword()%> name="userPassword" id="userPassword" maxlength="20" onkeyup="passwordCheck2()">
        <input type="password" name="userPassword1" id="userPassword1" placeholder="비밀번호 확인" onkeyup="passwordCheck2()">
            <div id="check">
				<h5 id="passwordCheckMessage"></h5>
			</div>
        <input type="submit" value="update">
        </form>
        <button type="button" id="user-delete" onclick="if(confirm('정말 탈퇴 하시겠습니까?')){location.href='userDeleteAction.jsp'}">회원 탈퇴하기</button>
    </div>
</div>
</section>
</body>
</html>