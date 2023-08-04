<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>Login</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/member.css?after">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
</head>
<style>
.login-wrapper{
	margin: 40px;
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
@media screen and (max-width:500px) {
	.login-wrapper{
		margin: 20px;
		margin-top: 40px;
	}
}
</style>
<body id="header">
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
			<div id="goJoin">
				<h4>아직 회원이 아니신가요?</h4>
			</div>
	   </div>
	</div>

</body>
<script>
//아직 회원이 아니신가요? 를 클릭하면 팝업창을 닫고 회원가입 페이지로 이동한다.
$(function(){
	  $('#goJoin').on('click',function(){
	      self.close();
	      opener.location.href='join';
	    });

	});
</script>
</html>