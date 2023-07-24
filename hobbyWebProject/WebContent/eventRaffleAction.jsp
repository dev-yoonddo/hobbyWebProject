<%@page import="user.pwEncrypt"%>
<%@page import="org.apache.tomcat.jni.Directory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="user.UserDAO" %>
<%@ page import="event.EventDAO" %>
<%@ page import="event.EventDTO" %>

<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>


<jsp:useBean id="event" class="event.EventDTO" scope="page"/>
<jsp:setProperty property="groupName" name="event"/>
<jsp:setProperty property="eventContent" name="event"/>
<jsp:setProperty property="userPassword" name="event"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EVENT</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
</head>
<style>
h3{
	font-family: 'Nanum Gothic', monospace;
	font-weight: bold;
	font-size: 20pt;
	color: #2E2F49;
}
#sb{
width: 100%;
}
#sb span{
  padding-top: 15px;
  padding-bottom: 15px;
}
  
#eventMsg{
	width: 400px;
	margin: 50px;
}
#send-form > input{
	width: 400px;
}
#msgTitle{
	height: 80px;
}
#eventWinMsg{
	height: 250px;
	border: 1px solid grey;
	border-radius: 10px;
}

</style>

<body>
	<%
		boolean raffle = false;
		EventDAO eventDAO = new EventDAO();
	    String[] events = request.getParameterValues("event");
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
		}else{
		    int raffleResult = 0;
		    for(int i = 0 ; i < events.length ; i++){
		        int eventWin = eventDAO.raffleWin(events[i]);
		        if(eventWin == -1){ //데이터베이스 오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류')");
					script.println("history.back()");
					script.println("</script>");
		        }
		        raffleResult++;
		    }
		    if(events.length == raffleResult){
		    	raffle = true;
		    }
			
		}
		
	%>
	<% if(raffle = true){%>
	<div id="eventMsg">
	<h3>당첨자에게 메시지 전송</h3>
	<form method="post" action="sendEventMsgAction.jsp" id="send-form">
		<%for(int i = 0 ; i < events.length ; i++){%>
		<input type="checkbox" checked="checked" hidden="hidden" name="event" value="<%=events[i]%>">
		<%} %>
	    <input type="text" placeholder="내용을 입력하세요" name="eventWinMsg" id="eventWinMsg" class="intro" maxlength="200">
	    <button type="submit" class="btn-blue" id="sb"><span>메시지 전송</span></button>
	</form>
	</div>
	<% } %>

</body>
</html>