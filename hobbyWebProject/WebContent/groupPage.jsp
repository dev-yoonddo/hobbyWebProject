<%@page import="javafx.scene.web.PromptData"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="group.GroupDTO" %>
<%@ page import="group.GroupDAO" %>
    
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>


</head>
<style>
section{
padding-top: 100px;
margin: 0 100px;
}
#sec-top{
	display: flex;
justify-content: center;}
.btn-blue{
	width: 250px;
	height: auto;
	float: none;
	display: flex;
	justify-content: center;	
	margin: 0 auto; 
}
.btn-blue span{
	width: 230px;
	height: auto;
	margin: 0 auto;
	color: #ffffff;
	background-color: #2E2F49;
	border: 1px solid #2E2F49;
	border-radius: 200px;
	font-size: 15pt;
	padding: 15px 20px;
}

.btn-blue::before {
  background-color: #2E2F49;
}

.btn-blue span:hover {
  color: #2E2F49;
  background-color: #ffffff
}
#row{
height: auto;
margin-top: 100px;
}

#gallery {
  width: 100%; 
  height: 100%;
  display: flex;
}
#gal-inner{
	display: flex;
	width: auto;
	height: auto;
	
}
.group-box {
  border-radius: 10px;
  transition: transform 0.5s ease;
  height: 200px;
  width: 200px;
  background-color: rgb(204, 204, 255);
  margin:0 auto;
  display: flex;

}

.group-box:hover {
  transform: scale(1.2);
}
.group-box:hover > .info-box{
	opacity: 0;
}
.group-box:hover > .group-inner-box {
  opacity: 1;
  transform: scale(1.1);
}

.group-inner-box {
  width: 150px;
  height: 100px;
  opacity: 0;
  transition: opacity 0.5s ease,
    transform 0.5s ease;
  margin: 0 auto;
  align-items: center;
  position: absolute;
}
.info-box{
	width: 150px;
  	height: 100px;
	margin: 0 auto;
	justify-content: center;
	position: absolute;
}
  </style>
</head>

<body>
<% 
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
int pageNumber = 1;//기본적으로 1페이지
if (request.getParameter("pageNumber") != null)
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));


%>
<header>
<div id="header" class="de-active">
	<nav class="navbar">
		<nav class="navbar_left">
			<div class="navbar_logo">
				<a href="mainPage.jsp" id="mainlogo" >TOGETHER</a>
			</div>
			<ul class="navbar_menu" style="float: left;">
				<li><a href="community.jsp" class ="menu">COMMUNITY</a></li>
				<li><a class="menu">GROUP</a></li>
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
				<li><a href="userUpdate.jsp"><i class="fa-solid fa-gear"></i></a></li>
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
<div id="sec-top">
<div>
	<h3 style="font-weight: bold; font-size: 20pt; color: #646464;"><%= userID %>님 안녕하세요 그룹을 만들거나 참여해보세요</h3>
	<button type="button" class="btn-blue" id="create-group" value="그룹생성"><span>그룹 만들기</span></button>	
</div>
</div>
<div id="gallery">
<div id="gal-inner">
		<%
			GroupDAO groupDAO = new GroupDAO();
			ArrayList<GroupDTO> list = groupDAO.getList(pageNumber);
			for (int i = 0; i < list.size(); i++) {
		%>
		<div class="group-box">
			<div class="info-box">
				<div class="info" id="in-group">
		            <span>
		                <a onclick="showPasswordPrompt('<%=list.get(i).getGroupID()%>', '<%=list.get(i).getGroupPassword()%>','<%= list.get(i).getGroupAvailable()%>')">
		                    <%=list.get(i).getGroupName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>
		                </a>
		            </span>
		        </div>
	 			<div class="info"><span><%= list.get(i).getUserID() %></span></div>
				<div class="info">
					<span>
					<% if(list.get(i).getGroupAvailable() == 1){%>
					활동중<%}else{ %>비활동중<%} %>
					</span>
				</div>
				<div class="info"><span>팀원---</span></div>
			</div>			
  			<div class="group-inner-box">		
			</div>
		</div>
		<% if(list.get(i).getGroupID() % 3 == 0){ %><br><br><br>
		<%
		}
			}
		%>
		
</div>		
</div>		
</section>
<!--  
  <div class="wrapper">
    <section class="main">
      <div class="first-container item">1</div>
      <div class="second-container item">2</div>
      <div class="third-container item">3</div>
    </section>
    <section class="aside">
      <div class="first-sidebar side droppable"></div>
      <div class="second-sidebar side droppable"></div>
      <div class="third-sidebar side droppable"></div>
      <div class="xxx-sidebar side droppable"></div>

    </section>
  </div>
-->
</body>
<script>
opener.location.reload(); //부모창 리프레쉬
self.close(); //로그인 후 팝업 창 닫기
</script>
<script>
//groupName을 클릭하면 id,password,available value를 받아온다
function showPasswordPrompt(grID, grPassword, grAvailable) {
    var inputPassword = "";
    //활동중
    if(grAvailable == 1){
	    while (inputPassword != grPassword) {
	        inputPassword = prompt("비밀번호를 입력하세요");
	        if(inputPassword == null){ //null은 취소버튼을 눌렀을 때를 의미한다. 아무것도 입력하지 않고 확인을 누르면 ""이다."
	        	break;
	        }
	    }
	    if (inputPassword == grPassword) {
	        location.href = "groupView.jsp?groupID=" + grID;
	    }
	//비활동중
    }else{
    	alert("비활동 중인 그룹입니다.");
    }
    
    /* 다른 while
    while(true) {
        inputPassword = prompt("Enter group password:");
	    if (inputPassword == grPassword) {
	        location.href = "groupView.jsp?groupID=" + grID;
	        break;
	    }
    }
    */
}
</script>
<script src="js/qna.js"></script>

</html>