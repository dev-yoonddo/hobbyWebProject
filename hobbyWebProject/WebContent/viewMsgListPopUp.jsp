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
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>

<style>
body{
	font-family: 'Nanum Gothic', sans-serif;
	cursor: default;
}
h2{
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: bold;
	font-size: 20pt;
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
#more-btn{
	cursor: pointer;
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
}
tr{
	align-items: center;
}

#more-btn{
	float: right;
	font-size: 11pt;
	font-weight: bold;
}
.none-list{
	text-align: center; 
	padding: 10px; 
}
</style>
</head>
<body>
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
	script.println("window.open('loginPopUp.jsp', 'Login', 'width=450, height=500, top=50%, left=50%')");
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
	script.println("location.href = 'groupPage.jsp'");
	script.println("</script>");
}

MessageDAO msgDAO = new MessageDAO();

//msgCheck = 0(안읽은 메시지)인 리스트 가져오기
ArrayList<MessageDTO> checklist = msgDAO.getMessageCheck(userID, groupID);

//내가 만든 그룹의 멤버가 나에게 보낸 메시지 리스트 가져오기
ArrayList<MessageDTO> msglist = msgDAO.getMsgList(userID, groupID);
%>

<!-- 받은 메시지 리스트 -->
<div id="viewMsg">
	<tr id="view-head">
		<!-- 나에게 온 메시지 중 안읽은 메시지 갯수 가져오기 -->
		<td><h2>안 읽은 메시지 (<%=checklist.size() %>)<h2></td>
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
			<tr class="showMsg" style="height: 20px;">
				<td><%=msglist.get(i).getUserID()%></td>
				<td><a id="click-view" onclick="viewMsg('<%= msglist.get(i).getMsgID()%>')"><%= msglist.get(i).getMsgTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
				<!-- msgCheck == 0이면 안읽음, 1이면 읽음 표시하기 -->
				<% if(msglist.get(i).getMsgCheck() == 0){ %>
				<td>NO</td>						
				<% }else{ %>
				<td>YES</td>						
				<% } %>
				<td><%=msglist.get(i).getMsgDate()%></td>
			</tr>
			<%
				}
			%>
		</tbody>
		<%
			}
		%>
	</table><br>
	<!-- 글 갯수가 1 이상이면 MORE 버튼 보이기 -->
	<% if (msglist.size() != 0) { %>
		<div id="more-btn">MORE</div>
	<%} %>
</div>


</body>
<script>
//메시지 더보기
var viewCount = 5; // 클릭할 때 마다 보여질 갯수
var lastIndex = viewCount - 1; //보여질 글의 마지막 인덱스
var rows = $('.showMsg').length; //전체 글 갯수
$('.show').slice(viewCount).hide(); // 처음 viewCount개의 글을 제외하고 모두 숨기기

$("#more-btn").click(function(e){ //more-btn을 클릭했을때
    e.preventDefault();
    if(rows <= lastIndex + 1){ //만약 전체 글의 수가 lastIndex +1 한 값보다 작거나 같으면
        alert("마지막 글입니다"); //마지막 글이라는 알림창 띄우기
	    return; //return을 하지않으면 알림창을 띄우고 또 다음으로 실행된다.
    
    }
    $('.showWrite').slice(lastIndex + 1, lastIndex + 1 + viewCount).show('slow'); // 처음 출력한 글의 다음 글들을 보여준다.
    $('.showWrite').slice(0, lastIndex + 1).hide(); // 0부터 이전의 글들을 모두 숨긴다.
    lastIndex += viewCount; // 다음 글 출력을 위해 lastIndex에 viewCount를 더해준다.
});


function viewMsg(msgID){
   	window.open("viewMsg.jsp?msgID=" + msgID , "VIEW MESSAGE", "width=550, height=600, top=50%, left=50%");
   	self.close();
}
</script>
</html>