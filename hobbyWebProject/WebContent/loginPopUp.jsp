<%@page import="user.UserDAO"%>
<%@page import="user.PwEncrypt"%>
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
		    <input type="text" name="userID" id="userID" placeholder="아이디 입력" onkeyup="saveValue(this)">
		    <input type="password" name="userPassword" id="userPassword" placeholder="비밀번호 입력" onkeyup="saveValue(this)">
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
$(document).ready(function(){
	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var key = getCookie("key");
    $("#userID").val(key); 
     
    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
    if($("#userID").val() != ""){ 
        $("#remember-check").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#remember-check").change(function(){ // 체크박스에 변화가 있다면,
        if($("#remember-check").is(":checked")){ // ID 저장하기 체크했을 때,
            setCookie("key", $("#userID").val(), 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("key");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#userID").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#remember-check").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            setCookie("key", $("#userID").val(), 7); // 7일 동안 쿠키 보관
        }
    });
});
</script>
<script>
// 쿠키 저장하기 
// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
function setCookie(cookieName, value, exdays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var cookieValue = escape(value)
			+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
	document.cookie = cookieName + "=" + cookieValue;
}

// 쿠키 삭제
function deleteCookie(cookieName) {
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires="
			+ expireDate.toGMTString();
}
 
// 쿠키 가져오기
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if (start != -1) { // 쿠키가 존재하면
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
			end = cookieData.length;
            console.log("end위치  : " + end);
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}
/*부모창이 새로고침돼도 입력값 유지하기
//1. input에 입력된 값 로컬스토리지에 저장
function saveValue(e){
	var id = e.id;
	var value = e.value;
	localStorage.setItem(id, value);
}
//2. 로컬스토리지에 저장된 값으로 input 채우기
function getSavedValue(v){
	if(!localStorage.getItem(v)){
		return v.value;
	}
	return localStorage.getItem(v);
}*/
</script>
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