<%@page import="message.MessageDAO"%>
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
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	String userID = null;

	MessageDAO msg = MessageDAO.getInstance();

	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
		script.println("</script>");
	}
	else{
		String deleteField2 = request.getParameter("deleteField2");
		if(deleteField2 == null) {
			script.println("<script>");
			script.println("alert('삭제할 메시지를 선택하세요.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
		    int result = 0;
		
		    if(deleteField2.equals("rcvMsg")) {
		        result = msg.deleteRcvMsg(userID);
		    } else if(deleteField2.equals("sendMsg")) {
		        result = msg.deleteSendMsg(userID);
		    } else if(deleteField2.equals("allMsg")) {
		        result = msg.deleteRcvMsg(userID) + msg.deleteSendMsg(userID);
		    }
		
		    if(result > 0) {
				script.println("<script>");
				script.println("alert('메시지가 삭제되었습니다.')");
				script.println("location.href='userUpdate'");
				script.println("</script>");
		    } else {
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