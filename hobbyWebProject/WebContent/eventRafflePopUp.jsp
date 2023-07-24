<%@page import="event.EventDTO"%>
<%@page import="event.EventDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="group.GroupDTO"%>
<%@page import="group.GroupDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EVENT</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script defer type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/userdata.js"></script>
</head>
<style>
body{
	font-family: 'Nanum Gothic', sans-serif;
	cursor: default;
	color: black;
}
h2{
	font-family: 'Nanum Gothic', sans-serif;
	font-weight: bold;
	font-size: 20pt;
	color: #646464;
}
  
#viewMsg{
	width: 450px;
	height: auto;
	margin: 25px;
	margin-bottom: 0;
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
form{
	height: 450px;
}
thead{
	height: 30px;
	background-color: #C9D7FF;
	text-align: center; 
	}

table{
	font-size: 10pt; 
	width: 450px; 
	text-align: left; 
}
tr{
	align-items: center;
}

#more-btn-5{
	float: right;
	font-size: 11pt;
	font-weight: bold;
	cursor: pointer;

}
.none-list{
	text-align: center; 
	padding: 10px; 
}

#row-btn-sec{
	width:auto;
	display: flex;
	margin: 0;
	padding: 0;
}
#more-btn{
	margin: 0 auto;
	font-size: 15pt;
	font-weight: bold;
	color: #404040;
	cursor: pointer;
}
#more-btn:hover{
	color: #E0E0E0;
}
#bottom{
	width: 450px;
	height: 70px;
	display: flex;
	justify-content: center;
	margin-bottom: 30px;
}
#result{
	width: 200px;
	border:0.5px solid #404040;
	padding: 3px;
}
.btn-blue{
	width: 70px;
	height: 50px;
	font-size: 19pt;
	margin-left: 50px;
}
</style>

<body>
<%
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	script.println("window.open('loginPopUp.jsp', 'Login', 'width=500, height=550, top=50%, left=50%')");
	script.println("</script>");
}
if(!userID.equals("manager")){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('잘못된 접근입니다')");
	script.println("self.close()");
	script.println("</script>");
}
EventDAO eventDAO = new EventDAO();
ArrayList<EventDTO> list = eventDAO.getList();
%>
<div id="viewMsg">
	<form action="eventRaffleAction.jsp">
	<div id="bottom">
		<div id='result'></div>
		<button type="submit" class="btn-blue" id="eventWin"><span>당첨</span></button>
	</div>
	<table>
		<thead>
			<tr class="board-head">
				<th style="width: 20%;"><span>아이디</span></th>
				<th style="width: 20%;"><span>그룹이름</span></th>
				<th style="width: 60%;"><span>응모내용</span></th>
			</tr>
		</thead>
		<!-- 글이 0개이면 -->
		<% if (list.size() == 0) { %>
		<tbody>
			<tr>
				<td colspan="4" class="none-list">응모한 회원이 없습니다.</td>
			</tr>
		</tbody>
		
		<!-- 글이 1개 이상이면 -->
		<% }else{ %>
		<tbody>
			<%
				for (int i = 0; i < list.size(); i++) {
			%>
			<tr class="showEventList" style="height: 50px;">
				<td><input type="checkbox" name="event" onclick="getCheckboxValue()" value="<%=list.get(i).getUserID()%>"><%=list.get(i).getUserID()%></td>
				<td><%=list.get(i).getGroupName() %></td>
				<td><%=list.get(i).getEventContent() %></td>			
			</tr>
			<%
				}
			%>
		</tbody>
		<%
			}
		%>
	</table><br>
	
	<br>
	<div id="row-btn-sec">
		<div id="more-btn">
			<a>
			<span>MORE</span>	    
			<i class="fa-solid fa-chevron-down"></i>
			</a>
		</div>
	</div>
	</form>
</div>

<script>
$(document).ready(function(){
	$('.showEventList').hide();
    $('.showEventList').slice(0, 10).show(); // 초기갯수
    $("#more-btn").click(function(e){ // 클릭시 more
        if($('.showEventList:hidden').length == 0){ // 컨텐츠 남아있는지 확인
            alert("마지막 글입니다."); // 컨텐츠 없을시 alert 창 띄우기
            break;
        }
        e.preventDefault();
        $('.showEventList:hidden').slice(0, 5).show('slow'); // 클릭시 more 갯수 지저정
	});
});
</script>
<script>
//선택한 유저 보기
function getCheckboxValue(){
	  // 선택된 목록 가져오기
	  const query = 'input[name="event"]:checked';
	  const selectedEls = 
	      document.querySelectorAll(query);
	  
	  // 선택된 목록에서 value 찾기
	  let result = '';
	  selectedEls.forEach((el) => {
	    result += el.value + '  ';
	  });
	  
	  // 출력
	  document.getElementById('result').innerText
	    = result;
}

</script>
<script>

</script>
</body>
</html>