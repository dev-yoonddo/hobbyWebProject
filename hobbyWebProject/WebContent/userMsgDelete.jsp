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
		script.println("history.back()");
		script.println("</script>");
	}
	else{
		String deleteField = request.getParameter("deleteField");
	
		if(deleteField == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제할 메시지를 선택하세요.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
		    int result = 0;
		
			    if(deleteField.equals("rcvMsg")) {
			        result = message.deleteRcvMsg(userID);
			    } else if(deleteField.equals("sendMsg")) {
			        result = message.deleteSendMsg(userID);
			    } else if(deleteField.equals("allMsg")) {
			        result = message.deleteAllMsgByUser(userID);
			    }
			
			    if(result > 0) {
			    	PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제 성공')");
					script.println("location.href='userUpdate.jsp'");
					script.println("</script>");
			    } else {
			    	PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제 실패')");
					script.println("history.back()");
					script.println("</script>");
			    }
			}
		}
%>
</body>
</html>