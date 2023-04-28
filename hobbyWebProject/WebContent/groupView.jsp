<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO"%>
<%@page import="user.UserDTO"%>
<%@page import="group.GroupDTO"%>
<%@page import="group.GroupDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GROUP VIEW</title>
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</head>
<style>
section{
	height: 800px;
	padding-top: 150px;
	padding-left: 100px;
	padding-right: 100px;
}	
h2{
	font-family: 'Bruno Ace', cursive;
	font-weight: bold;
	font-size: 20pt;
	color: #2E2F49;
}
#group-main{
	height: 200px;
}
.btn-blue{
	width: 100px;
} 

</style>
<body>
<%
//userID 가져오기
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
}
//boardID 가져오기
int boardID = 0;
if(request.getParameter("boardID") != null){
	boardID = Integer.parseInt(request.getParameter("boardID"));
}
//groupID 가져오기
int groupID = 0;
if(request.getParameter("groupID") != null){
	groupID = Integer.parseInt(request.getParameter("groupID"));
}
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp.jsp', 'Login', 'width=450, height=500, top=50%, left=50%')");
	script.println("</script>");
}
//유효하지 않은 그룹일때
if(groupID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('해당 그룹이 존재하지 않습니다.')");
	script.println("location.href = 'groupPage.jsp'");
	script.println("</script>");
}
GroupDTO group = new GroupDAO().getGroupVO(groupID);
int userAccess = Integer.parseInt(request.getParameter("userAccess"));
MemberDAO mbDAO = new MemberDAO();
ArrayList<MemberDTO> mblist = mbDAO.getList(groupID);
%>

<!-- header -->
<header>
<div id="header" class="de-active">
	<nav class="navbar">
		<nav class="navbar_left">
			<div class="navbar_logo">
				<a href="mainPage.jsp" id="mainlogo" >TOGETHER</a>
			</div>
			<ul class="navbar_menu" style="float: left;">
				<li><a href="community.jsp" class ="menu">COMMUNITY</a></li>
				<li><a class="menu" onclick="history.back()">GROUP</a></li>
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
<!-- header -->
<section>
<%= userAccess %>

	<div id="group-main">
		<div id="group-info">
		<span><%= group.getGroupName() %>에서 많은 사람들과 함께 즐겨보세요</span>
		<!-- 그룹을 만든 userID일때만 버튼 생성 -->
		<% if(userID.equals(group.getUserID())){ %>
		<button type="button" class="btn-blue" id="btn-del" onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='groupDeleteAction.jsp?groupID=<%=groupID%>'}"><span>그룹삭제</span></button>
		<%} %>
		<%= mblist.size() %>명 참여중
		<%= group.getUserID() %>
		</div>
	</div>
	<div id="member-list">
	<% 
		for(int i=0; i<mblist.size(); i++){
	%>
		<%= mblist.get(i).getMemberID() %>
		<%= mblist.get(i).getMbContent() %>
		<%= mblist.get(i).getMbDate().substring(0,11)+mblist.get(i).getMbDate().substring(11,13)+"시"+mblist.get(i).getMbDate().substring(14,16)+"분" %>
	<%
		}
	%>
	</div>
</section>
<script>
function mbJoin(){
	document.getElementById('joinGroup').style.display = 'block';
	document.getElementById('joinGroup-btn').style.display = 'none';
}
</script>
</body>
</html>