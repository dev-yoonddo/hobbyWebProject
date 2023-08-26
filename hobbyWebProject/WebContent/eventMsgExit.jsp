<%@page import="user.PwEncrypt"%>
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
		PrintWriter script = response.getWriter();
		EventDAO eventDAO = new EventDAO();
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
			script.println("</script>");
		}else{
		    int result = eventDAO.raffleMsgExit(userID);
		    if(result == -1){
		    	script.println("<script>");
				script.println("alert(데이터베이스 오류)");				
				script.println("self.close()");
				script.println("</script>");
		    }else{
		    	script.println("<script>");
				script.println("self.close()");
				script.println("</script>");
		    }
			
		}
		
	%>

</body>
</html>