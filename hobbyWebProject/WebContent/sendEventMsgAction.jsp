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
			script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
			script.println("<script>");
		}else{
			EventDAO eventDAO = new EventDAO();
			//파라미터 값들을 배열에 저장한다.
		    String[] events = request.getParameterValues("event");
			//배열의 길이만큼 반복한다.
		    for(int i = 0 ; i < events.length ; i++){
		    	//userID와 입력한 메시지를 raffleWinMsg() 메서드에 넘겨 저장한다.
		    	int result = eventDAO.raffleWinMsg(events[i], event.getEventWinMsg());
		    	if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류')");
					script.println("history.back()");
					script.println("</script>");
				}
		    	//성공적으로 실행시 seccess + 1 해준다.
		    	success++;
		    }
			//배열의 길이와 seccess의 크기가 같으면 모든 userID의 eventWinMsg에 값이 정상적으로 들어감을 의미한다.
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