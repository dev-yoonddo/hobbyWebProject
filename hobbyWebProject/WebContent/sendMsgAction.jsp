<%@page import="java.io.PrintWriter"%>
<%@page import="message.MessageDAO"%>
<%@page import="message.MessageDTO"%>
<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="message" class="message.MessageDTO" scope="page" />
<jsp:setProperty name="message" property="userID" />
<jsp:setProperty name="message" property="toUserID" />
<jsp:setProperty name="message" property="msgTitle" />
<jsp:setProperty name="message" property="msgContent" />
<jsp:setProperty name="message" property="msgDate" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
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
			script.println("alert('로그인이 필요합니다.')");
			script.println("window.open('loginPopUp.jsp', 'Login', 'width=450, height=500, top=50%, left=50%')");
			script.println("window.close()");
			script.println("</script>");
		}else{
			int groupID = 0; 
		 	if (request.getParameter("groupID") != null){
		 		groupID = Integer.parseInt(request.getParameter("groupID"));
		 	}
		 	if (groupID == 0){
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('유효하지 않은 그룹입니다.')");
		 		script.println("history.back()");
		 		script.println("</script>");
		 	}
			if(message.getMsgTitle() == null || message.getMsgContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			GroupDAO groupDAO = new GroupDAO();
			MessageDAO msgDAO = new MessageDAO();
			
			int result = msgDAO.send(userID, groupDAO.getGroupVO(groupID).getUserID(), message.getMsgTitle(), message.getMsgContent());
			if(result == -1){ //데이터베이스 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				//가입시 비밀번호 알려주기
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('메시지 전송이 완료되었습니다.')");
				script.println("location.href = 'groupPage.jsp'");
				script.println("</script>");
			}
					

		}

		
	%>
</body>
<script>

</script>
</html>