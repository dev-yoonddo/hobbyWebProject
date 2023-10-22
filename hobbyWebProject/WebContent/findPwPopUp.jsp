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
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>FIND</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
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
	font-family: 'Nanum Gothic', monospace;
}

h2{
	margin: 0;
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
</style>
<body>
<%
PrintWriter script = response.getWriter();
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
//groupID 가져오기
int groupID = 0;
if(request.getParameter("groupID") != null){
	groupID = Integer.parseInt(request.getParameter("groupID"));
}
if(userID == null){
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
	script.println("</script>");
}
GroupDAO groupDAO = new GroupDAO();
MemberDAO memberDAO = new MemberDAO();

UserDTO user=new UserDAO().getUserVO(userID); //유저 정보 가져오기
ArrayList<MemberDTO> mbList = memberDAO.getListByUser(userID); //유저가 가입한 그룹 리스트 가져오기
%>
<div class="login-wrapper" id="header">
	<div>
		<h2>정보를 입력하세요</h2>
		<br><br>
		<form method="post" action="findPwAction.jsp" role="form" id="login-form">
		    <input hidden="hidden" type="text" name="groupID" id="groupID" maxlength="11" value="<%=groupID%>" placeholder="회원 전화번호를 입력해주세요">
		    <input type="text" name="userPhone" id="userPhone" maxlength="11" placeholder="회원 전화번호를 입력해주세요">
		    <input type="password" name="userPassword" id="userPassword" placeholder="회원 비밀번호를 입력해주세요">
		    <input type="submit" value="비밀번호 찾기">
		</form>
	</div>
	</div>
</body>
</html>