<%@page import="group.GroupDTO"%>
<%@page import="user.UserDTO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.UserDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="group.GroupDAO"%>
<%@page import="java.io.PrintWriter"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="user.UserDTO" scope="page" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>EMAIL ADRESS</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>
<style>
	.login-wrapper{
	margin: 30px;
	margin-top: 30px;
	margin-bottom: 0;
	width: 400px;
	height: 400px;
	justify-content: center;
}

.category-sel{
width: 400px;

}
body{
	font-family: 'Nanum Gothic', monosp ace;
}

h2{
	margin-top: 30px;
}
input{
	width: 350px;
}
select{
	width: 250px;
	height: 50px;
	margin-bottom: 10px;
	text-align: center;
	font-size: 15pt;
	font-weight: 500;
	color: #B3C1EE;
	border : 2px solid  #dddddd;
}
option{
	color: #B3C1EE;
	height: 50px;
}
#login-form > input[type="submit"] {
	margin-top: 10px;
}
#userEmail , #submit{
	margin: 0;
}
#check{
	height: 20px;
}
#checkMessage{
	color: black;
}
</style>
<body>
<%
PrintWriter script = response.getWriter();
String userID = null;

UserDAO userDAO = new UserDAO();
UserDTO userVO=new UserDAO().getUserVO(userID); //유저 정보 가져오기
ArrayList<UserDTO> list = userDAO.getEmailList(); //모든 유저 이메일 리스트 가져오기
//for (UserDTO list : lists) {
//    System.out.println("User Email: " + list);
//}

if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
if(userID == null){
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
	script.println("</script>");
}
%>
<div class="login-wrapper" id="header">
	<div>
		<h2>이메일 주소를 입력하세요</h2>
		<br><br>
		<form method="post" action="emailAdUpdateAction" role="form" id="login-form">
		    <input type="text" name="userEmail" id="userEmail" maxlength="30" placeholder="이메일 주소를 입력하세요" onkeyup="emailCheck('<%=list%>')">
			<div id="check">
				<h5 id="checkMessage"></h5>
			</div>
		    <input type="submit" id="submit" value="인증하기">
		</form>
	</div>
</div>

</body>
</html>