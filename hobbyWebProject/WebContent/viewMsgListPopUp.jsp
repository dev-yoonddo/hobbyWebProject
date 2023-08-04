<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@page import="message.MessageDAO"%>
<%@page import="message.MessageDTO"%>
<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>MESSAGE</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script defer type="text/javascript" src="js/userdata.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>


<style>
body{
	font-family: 'Nanum Gothic', sans-serif;
	cursor: default;
}
h2{
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: bold;
	font-size: 15pt;
	color: #646464;
}
  
#viewMsg{
	width: 400px;
	height: auto;
	margin: 50px;
}
#view-head{
	color: black;
}

td{
	table-layout: fixed;
	height: 20px;
	border-bottom: solid 1px #C0C0C0;
	text-align: left;
}
#click-view:hover{
	text-decoration: underline;
}

thead{
	height: 30px;
	background-color: #C9D7FF;
	text-align: center; 
	}

table{
	font-size: 10pt; 
	width: 400px; 
	text-align: left;
	color: black;
}
tr{
	align-items: center;
}

#row-btn-sec{
	width:auto;
	display: flex;
	margin: 0;
	padding: 0;
}
#more-btn-msg{
	margin: 0 auto;
	font-size: 15pt;
	font-weight: bold;
	color: #404040;
	cursor: pointer;
}
#more-btn-msg:hover{
	color: #E0E0E0;
}
.none-list{
	text-align: center; 
	padding: 10px; 
}
</style>
</head>
<body id="header">
<%
//userID 가져오기
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
}
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
	script.println("</script>");
}

//groupID 가져오기
int groupID = 0;
if(request.getParameter("groupID") != null){
	groupID = Integer.parseInt(request.getParameter("groupID"));
}
//유효하지 않은 그룹일때
if(groupID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('해당 그룹이 존재하지 않습니다.')");
	script.println("location.href = 'groupPage'");
	script.println("</script>");
}
GroupDAO grDAO = new GroupDAO();
MessageDAO msgDAO = new MessageDAO();

//msgCheck = 0(안읽은 메시지)인 리스트 가져오기
ArrayList<MessageDTO> checklist = msgDAO.getMessageCheck(userID, groupID);

//같은 그룹의 멤버가 나에게 보낸 메시지 리스트 가져오기
ArrayList<MessageDTO> msglist = msgDAO.getMsgList(userID, groupID);
%>

<!-- 받은 메시지 리스트 -->
<div id="viewMsg">
	<tr id="view-head">
		<!-- 그룹 이름 출력 -->
		<td>
		<div style="height: 50px; display: flex; justify-content: center; align-items: center;">
		<h2 style="font-size: 25pt;">
		<i class="fa-regular fa-envelope" style="font-size: 30pt;"></i>
		<%=grDAO.getGroupVO(groupID).getGroupName()%>
		</h2>
		</div><br>
		</td>
		<!-- 나에게 온 메시지 중 안읽은 메시지 갯수 가져오기 -->
		<td><h2>안 읽은 메시지 (<%=checklist.size() %>)</h2></td>
	</tr>
	<table>
		<thead>
			<tr class="board-head">
				<th style="width: 20%;"><span>보낸 사람</span></th>
				<th style="width: 40%;"><span>제목</span></th>
				<th style="width: 20%;"><span>확인</span></th>
				<th style="width: 20%;"><span>날짜</span></th>
			</tr>
		</thead>
		<!-- 글이 0개이면 -->
		<% if (msglist.size() == 0) { %>
		<tbody>
			<tr>
				<td colspan="4" class="none-list">수신된 메시지가 없습니다.</td>
			</tr>
		</tbody>
		
		<!-- 글이 1개 이상이면 -->
		<% }else{ %>
		<tbody>
			<%
				for (int i = 0; i < msglist.size(); i++) {
			%>
			<tr class="showRcvGrMsg" style="height: 20px;">
				<td><%=msglist.get(i).getUserID()%></td>
				<td><a id="click-view" onclick="viewMsg('<%= msglist.get(i).getMsgID()%>')"><%= msglist.get(i).getMsgTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
				<!-- msgCheck == 0이면 안읽음, 1이면 읽음 표시하기 -->
				<% if(msglist.get(i).getMsgCheck() == 0){ %>
				<td>NO</td>						
				<% }else{ %>
				<td>YES</td>						
				<% } %>
				<td><%=msglist.get(i).getMsgDate().substring(0 ,11) + msglist.get(i).getMsgDate().substring(11, 13) + "시" + msglist.get(i).getMsgDate().substring(14, 16) + "분" %></td>
			</tr>
			<%
				}
			%>
		</tbody>
		<%
			}
		%>
	</table><br>
	<% if (msglist.size() > 5) { %>
		<div id="row-btn-sec">
			<div id="more-btn-msg">
				<a>
				<span>MORE</span>	    
				<i class="fa-solid fa-chevron-down"></i>
				</a>
			</div>
		</div>
	<%} %>
</div>


<script>

//메시지 제목을 클릭하면 상세팝업 띄우기
function viewMsg(msgID){
   	window.open("viewMsg?msgID=" + msgID , "VIEW MESSAGE", "width=550, height=600, top=50%, left=50%");
   	self.close(); //이전 팝업 닫기
}
</script>
</body>
</html>