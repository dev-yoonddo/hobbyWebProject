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
/*    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      width: 100vw;
      height: 100vh;

    }

    .wrapper {
      width: 100%;
      height: 100%;
      display: flex;

    }

    .main {
      width: 80%;
      height: 100vh;
      display: flex;
      justify-content: space-around;
      transition: all 1s linear;
      align-items: center;

      // background-color: #f1c40f;
    }

    .main div {
      width: 100px;
      height: 100px;
      border: 1px solid aliceblue;
      background-color: aliceblue;

      border-radius: 15px;
      box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5);
    }

    .aside {
      width: 20%;
      height: 100vh;
      display: flex;
      flex-direction: column;
      justify-content: space-around;
      align-items: center;
      background-color: #95a5a6;
    }

    .aside div {
      width: 50px;
      height: 50px;
      border: 1px solid aliceblue;
      background-color: aliceblue;
      border-radius: 10px;
      box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5);
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .aside div .mini {
      width: 40px;
      height: 40px;
      border: 1px solid rgb(71, 255, 227);
      background-color: rgb(71, 255, 227);
      border-radius: 8px;
      box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5);
      left: 0;
      top: 0;
    }
    */
  </style>
</head>

<body>
<% 
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
int groupID = 0;
if(request.getParameter("groupID") != null){
	groupID = Integer.parseInt(request.getParameter("groupID"));
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
				<% 
					if(userID == null){
				%>
				<li><a id="go-group-1" class="menu">Q & A</a></li>
				<%
					} else { 
				%>
				<li><a id="go-group-2" class="menu" onclick="location.href='groupPage.jsp'">Q & A</a></li>
				<%
					}
				%>
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
<div id="row">

			<tr class="board-head">
				<th style="width: 20%;"><span>그룹이름</span></th>
				<th style="width: 20%;"><span>팀장</span></th>
				<th style="width: 20%;"><span>활동중</span></th>
				<th style="width: 20%;"><span>팀원</span></th>
			</tr>
	
		<%
			GroupDAO groupDAO = new GroupDAO();
			ArrayList<GroupDTO> list = groupDAO.getList(pageNumber);
			for (int i = 0; i < list.size(); i++) {
		%>
		<div class="group-box">	
			<div class="group" id="in-group"><span><a href="groupView.jsp?groupID=<%=list.get(i).getGroupID()%>"><%= list.get(i).getGroupName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></span></div>
			<div class="group"><span><%= list.get(i).getUserID() %></span></div>
			<div class="group"><span><%= list.get(i).getGroupAvailable() %></span></div>
			<div class="group"><span>팀원---</span></div>
		</div>
		<%
		}
		%>
		
		
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
self.close(); //로그인 후 팝업창이 mainPage로 이동했을때 창 닫기


</script>
<script src="js/qna.js"></script>

</html>