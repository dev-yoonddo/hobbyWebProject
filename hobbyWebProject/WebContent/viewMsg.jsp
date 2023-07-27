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
<title>VIEW MESSAGE</title>
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
</head>
<style>
body{
	cursor: default;
}
.board-container{
	width: 500px;
	display: flex;
	justify-content: center;
	margin: 30px;
	color: #646464;
	font-family: 'Noto Sans KR', sans-serif;
}
#view-table{
	width: 450px;
	height: 450px;
	border-collapse: collapse;
	border: 1px solid #C0C0C0;
	font-size: 12pt;
}

thead{

}
.td{
	text-align: center;
	font-size: 12pt;
}
.td span{	
	padding: 10px 15px;
	border-radius: 20px;
	background-color: #CCE5FF;
}
.btn-blue{
	height: 50px;
}
</style>
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
	script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
	script.println("</script>");
}
//msgID 가져오기
int msgID = 0;
if(request.getParameter("msgID") != null){
	msgID = Integer.parseInt(request.getParameter("msgID"));
}
if(msgID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 접근입니다.')");
	script.println("history.back()");
	script.println("</script>");
}
MessageDAO msgDAO = new MessageDAO();
//msgID에 해당하는 글의 정보 가져오기
MessageDTO msg = new MessageDAO().getMsgVO(msgID);
//페이지 접속시 msgCheck = 1 로 변경해서 메시지 읽음으로 변경하기
int result = msgDAO.msgCheckUpdate(msgID, userID);
if(result == -1){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('데이터베이스 오류')");
	script.println("history.back()");
	script.println("</script>");
}
%>
<div class="board-container">
	<div>
		<div class="inquiry">
				<table id="view-table">
					<tbody>
						<tr height="20%" style="border-bottom: 1px solid #C0C0C0;">
							<td class="td" style="width:30%;"><span>보낸사람</span></td>
							<td><%=msg.getUserID().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						</tr>
						<tr height="20%" style="border-bottom: 1px solid #C0C0C0;">
							<td class="td"><span>제목</span></td>
							<td><%=msg.getMsgTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						</tr>
						<tr height="60%" valign="top">
							<td class="td" style="padding-top: 50px;"><span>내용</span></td>
							<!-- 특수문자 처리 -->
							<td style="padding-top: 50px;"><%=msg.getMsgContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						</tr>
						<!-- <tr>
							<td class="td"><span>조회수</span></td>
							<td colspan="2"board.getViewCount()+1)+1 %></td>
						</tr>
						<tr>
							<td class="td"><span>하트</span></td>
							<td colspan="2"board.getHeartCount()t() %></td>
						</tr> -->
					</tbody>
				</table>
				
			</div><br>
			
			<%
				if(userID != null){
			%>
				<button type="button" class="btn-blue" onclick="viewMsgList('<%=msg.getGroupID()%>')"><span>목록</span></button>
				<% 
					if(!userID.equals(msg.getUserID())){
				%>
					<button type="button" class="btn-blue" id="cmt-write-btn" onclick="writeReply('<%=msg.getMsgID()%>',<%=msg.getGroupID()%>)"><span>답장하기</span></button>
				<%
					}
				%>
			<%
				}
			%>
	</div>
</div>		
</body>
<script>
//목록 버튼을 클릭하면 다시 메시지 리스트 팝업을 띄운다.
function viewMsgList(groupID){
   	window.open("viewMsgListPopUp?groupID=" + groupID , "MESSAGE", "width=500, height=500, top=50%, left=50%") ;
   	self.close();
}
//답장하기 버튼을 클릭하면 답장하기 팝업을 띄운다.
function writeReply(msgID, groupID){
	window.open("sendMsgPopUp?msgID=" + msgID + "&groupID=" + groupID , "MESSAGE", "width=500, height=500, top=50%, left=50%") ;
   	self.close();
}
</script>
</html>