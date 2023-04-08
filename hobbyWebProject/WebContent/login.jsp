<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script defer src="option/jquery/jquery.min.js"></script>

</head>
<style>
* {
  box-sizing: border-box;
}

body {
  background-color: #c6cdd3;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  height: 100vh;
}
h3 {
  margin: 5px;
}

.container {
  background-color: #fff;
  border-radius: 5px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
  width: 450px;
  height: 450px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
}
.login-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin: 20px;
  width: 400px;
  height: 100%;
  padding: 20px;
}

#message {
  background-color: rgb(222, 233, 238);
  border-radius: 10px;
  padding: 10px;
  text-align: center;
  margin-bottom: 15px;
  width: 95%;
}

#button_area {
  background-color: rgb(222, 233, 238);
  border-radius: 10px;
  padding: 10px;
  width: 95%;
  display: flex;
  justify-content: center;
}
</style>
<body>

<div class="container">
    <h1>Naver Login API 사용하기</h1>
    <div class="login-area">
      <div id="message">
        로그인 버튼을 눌러 로그인 해주세요.
      </div>
      <div id="button_area">
        <div id="naverIdLogin"></div>
      </div>
    </div>
  </div>
OJXUDvN3qv76O6QfBTAR
bCzShNzXcd
<!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
  <script type="text/javascript">

  const naverLogin = new naver.LoginWithNaverId(
   {
    clientId: "OJXUDvN3qv76O6QfBTAR",
    callbackUrl: "http://localhost:8080/hobbyWebProject/mainPage.jsp",
    loginButton: {color: "green", type: 4, height: 40}
    }
   );


    naverLogin.init();
    naverLogin.getLoginStatus(function (status) {
      if (status) {
          const nickName=naverLogin.user.getNickName();
          const age=naverLogin.user.getAge();
          const birthday=naverLogin.user.getBirthday();

          if(nickName===null||nickName===undefined ){
            alert("별명이 필요합니다. 정보제공을 동의해주세요.");
            naverLogin.reprompt();
            return ;  
         }else{
          setLoginStatus();
         }
    }
    });
    console.log(naverLogin);

    function setLoginStatus(){

      const message_area=document.getElementById('message');
      message_area.innerHTML=`
      <h3> Login 성공 </h3>
      <div>user Nickname : ${naverLogin.user.nickname}</div>
      <div>user Age(범위) : ${naverLogin.user.age}</div>
      <div>user Birthday : ${naverLogin.user.birthday}</div>
      `;

      const button_area=document.getElementById('button_area');
      button_area.innerHTML="<button id='btn_logout'>로그아웃</button>";

      const logout=document.getElementById('btn_logout');
      logout.addEventListener('click',(e)=>{
        naverLogin.logout();
    location.replace("http://localhost:8080/hobbyWebProject/mainPage.jsp");
      })
    }


  </script>
</body>
</html>