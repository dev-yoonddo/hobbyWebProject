<%@page import="java.math.BigInteger"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>Login</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>

</head>
<style>
.login-wrapper{
margin: 20px;
}
</style>
<body>
<% 
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
%>
<header id="header">
<jsp:include page="/header/header.jsp"/>
</header>
<section>
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
	   </div>
	</div>
</section>
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
</script>
<script>
/*
function onSignIn(googleUser){
	var profile = googleUser.getBasicProfile();
	id = profile.getId();
	username = profile.getName();
	img = profile.getImageUrl();
	email = profile.getEmail();
	alert("로그인 완료");
	console.log(id);
	console.log(username);
	console.log(email);
	post_to_url("http://localhost:8080/glLoginAction.jsp",{'id' : id , 'username' : username, 'email' : email , 'img': img})
}
function post_to_url(path, params){
	const form = document.createElement('form');
	form.method = 'POST';
	form.action = path;
	console.log(params);
	for(const key in params){
		if(params.hasOwnProperty(key)){
			const hiddenField = document.createElement('input');
			hiddenField.type = 'hidden';
			hiddenField.name = key;
			hiddenField.value = params[key];
			form.appendChild(hiddenField);
		}
	}
	document.body.appendChild(form);
	form.submit();
}

function onSignIn(googleUser) {
  var profile = googleUser.getBasicProfile();
  var id_token = googleUser.getAuthResponse().id_token;
  $("#googleBtn").click(function(){
	  $.ajax({
		  url: 'glLoginAction.jsp',
		  type: 'POST',
		  data: {
			  'idtoken' : id_token, 
			  'profile' : profile
			},
		  dataType: 'JSON',
		  beforeSend : function(xhr){
			  xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		  },
		  success: function(json) {
			  if (json.login_result == "success"){
				  location.href = "mainPage";
			  }//end if
          }//success
	  });//ajax
  });//click
}
*/
</script>
</body>
</html>