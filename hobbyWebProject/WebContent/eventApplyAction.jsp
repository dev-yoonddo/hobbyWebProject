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
<title>Insert title here</title>
</head>
<body>
	<%
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
			UserDAO user = new UserDAO();
			//응모하는 회원의 비밀번호를 가져온다.
			String userPW = user.getUserVO(userID).getUserPassword();
			//암호화된 비밀번호와 비교하기 위해 입력한 비밀번호를 암호화한다.
			String inputPW = pwEncrypt.encoding(event.getUserPassword());
			//입력한 정보 검사
			//받아온 값이 0이면 응모 기준에는 충족하지만 활동중인 그룹이 없음을 의미한다.
			if(event.getGroupName().equals("0")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('그룹을 선택해주세요')");
				script.println("history.back()");
				script.println("</script>");
			}else if(event.getEventContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");
			}else if(event.getUserPassword() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호를 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");
			}else if(!userPW.equals(inputPW)) { //유저의 회원비밀번호가 일치하는지 검사
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 일치하지 않습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				//모든 검사 완료시 이벤트 응모하기
				EventDAO eventDAO = new EventDAO();
				int result = eventDAO.apply(userID, event.getGroupName(), event.getEventContent(), inputPW);
				if(result == -1){ //데이터베이스 오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('응모 실패')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('응모가 완료되었습니다<br>당첨여부는 메시지로 알려드리겠습니다')");
					script.println("self.close()");
					script.println("opener.location.href='mainPage.jsp'");
					script.println("</script>");
				}
				
				
			}
			
			
		}
		
	%>
	
	
</body>
</html>