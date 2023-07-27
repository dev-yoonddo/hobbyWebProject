<%@page import="comment.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="comment.CommentDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="message" class="message.MessageDAO" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
		script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
		script.println("</script>");
	}
	else{
		String deleteField2 = request.getParameter("deleteField2");
	
		if(deleteField2 == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제할 메시지를 선택하세요.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
		    int result = 0;
		
		    if(deleteField2.equals("rcvMsg")) {
		        result = message.deleteRcvMsg(userID);
		    } else if(deleteField2.equals("sendMsg")) {
		        result = message.deleteSendMsg(userID);
		    } else if(deleteField2.equals("allMsg")) {
		        result = message.deleteRcvMsg(userID) + message.deleteSendMsg(userID);
		    }
		
		    if(result > 0) {
		    	PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('메시지가 삭제되었습니다.')");
				script.println("location.href='userUpdate'");
				script.println("</script>");
		    } else {
		    	PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제할 메시지가 없습니다.')");
				script.println("history.back()");
				script.println("</script>");
		    }
		}
	}
%>
</body>
</html>