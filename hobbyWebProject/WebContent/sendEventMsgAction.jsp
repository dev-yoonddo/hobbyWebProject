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
<jsp:setProperty property="eventWinMsg" name="event"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int success = 0;
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다')");
			script.println("self.close()");
			script.println("opener.location.href='login.jsp'");
			script.println("</script>");
		}else{
			EventDAO eventDAO = new EventDAO();
		    String[] events = request.getParameterValues("event");
		    for(int i = 0 ; i < events.length ; i++){
		    	int result = eventDAO.raffleWinMsg(events[i], event.getEventWinMsg());
		    	
		    	if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류')");
					script.println("history.back()");
					script.println("</script>");
				}
		    	success++;
		    }
		    if(events.length == success){
		    	PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('전송 완료')");
				script.println("self.close()");
				script.println("</script>");
		    }
		}
		
	%>
<script>

</script>
</body>
</html>