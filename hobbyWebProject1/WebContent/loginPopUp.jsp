<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/member.css?after">
</head>
<style>
.login-wrapper{
	margin: 35px;
	margin-top: 70px;
	margin-bottom: 0;
	height: 400px;
}
#goJoin{
	float: right; 
	height: 30px; 
	color: #C0C0C0;
	cursor: pointer;
}
#goJoin:hover{
	text-decoration: underline;
}
</style>
<body>
	<div class="login-wrapper">
	 <div>
		<h2>로그인
		</h2>
		<form method="post" action="loginAction.jsp" role="form" id="login-form">
		    <input type="text" name="userID" id="userID" placeholder="아이디 입력">
		    <input type="password" name="userPassword" id="userPassword" placeholder="비밀번호 입력">
		    <label for="remember-check">
		        <input type="checkbox" id="remember-check">아이디 저장하기
		    </label>
		    <input type="submit" value="Login">
		</form>
			<div id="goJoin" onclick="location.href='join.jsp'">
				<h4>아직 회원이 아니신가요?</h4>
			</div>
	   </div>
	</div>

</body>
<script>
</script>
</html>