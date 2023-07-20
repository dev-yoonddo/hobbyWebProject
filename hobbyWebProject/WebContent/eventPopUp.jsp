<%@page import="group.GroupDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="group.GroupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="css/main.css?after">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
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
<body>
<%
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}

GroupDAO grDAO = new GroupDAO();
ArrayList<GroupDTO> list = grDAO.getListByUser(userID);
%>
	<div class="login-wrapper">
	 <div>
		<h2 style="font-size: 25pt; margin-gottom: 10px;">활동 지원금 이벤트</h2>
		<h2 style="margin-bottom: 40px; font-size: 30pt;">응모 대상자입니다!</h2>
		<form method="post" action="eventAction.jsp" role="form" id="login-form">
			<div class="category-sel">
				<select name="eventGroup">
					<% if(list.size() == 0) {%>
					<option value="0" >응모 가능한 그룹이 없습니다.<option>
				    <% }else {%>
						<option value="1">SELECT GROUP</option>
						<%
					    	for (int i = 0; i < list.size(); i++) {
					  	%>
						<option class="group" value="<%=list.get(i).getGroupName()%>"><%= list.get(i).getGroupName() %></option>
					<%	
							}
						}
					%>
				</select>
			</div>
		    <input type="text" name="detail" id="detail" maxlength="500" placeholder="이벤트 응모 당첨시 활동 지원금 사용 계획을 입력해주세요">
		    <input type="password" name="userPassword" id="userPassword" placeholder="회원 비밀번호를 입력해주세요">
		    <input type="submit" value="응모하기">
		</form>
	   </div>
	</div>

</body>
<script>
//아직 회원이 아니신가요? 를 클릭하면 팝업창을 닫고 회원가입 페이지로 이동한다.
$(function(){
	  $('#goJoin').on('click',function(){
	      self.close();
	      opener.location.href='join.jsp';
	    });
	});
</script>
</html>