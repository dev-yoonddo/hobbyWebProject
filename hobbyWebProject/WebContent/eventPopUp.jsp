<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="group.GroupDTO"%>
<%@page import="group.GroupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>EVENT</title>
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
	width: 450px;
	height: 500px;
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

<body id="header">
<%
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
	script.println("</script>");
}
GroupDAO grDAO = new GroupDAO();
ArrayList<GroupDTO> list = grDAO.getListByUser(userID);
%>
	<div class="login-wrapper">
	 <div>
		<h2 style="font-size: 25pt; margin-gottom: 10px;">활동 지원금 이벤트</h2>
		<h2 style="margin-bottom: 40px; font-size: 30pt;">응모 대상자입니다!</h2>
		<form method="post" action="eventApplyAction.jsp" role="form" id="login-form">
			<div class="category-sel">
				<select name="groupName">
					<!-- select에서는 option의 value값이 넘어간다. -->
					<option value="0">SELECT GROUP</option>
					<%
				    	for (GroupDTO i : list) {
				    		if(i.getGroupAvailable() == 1){
				  	%>
						<option class="group" value="<%=i.getGroupName()%>"><%= i.getGroupName() %></option>
					<%	
				    		}
				    	}
					%>
				</select>
			</div>
		    <input type="text" name="eventContent" id="eventContent" maxlength="500" placeholder="이벤트 응모 당첨시 활동 지원금 사용 계획을 입력해주세요">
		    <input type="password" name="userPassword" id="userPassword" placeholder="회원 비밀번호를 입력해주세요">
		    <input type="submit" value="응모하기">
		</form>
	   </div>
	</div>

</body>
</html>