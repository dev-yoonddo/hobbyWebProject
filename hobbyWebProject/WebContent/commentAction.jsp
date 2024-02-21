<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentDTO"%>
<%@page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<jsp:useBean id="comment" class="comment.CommentDTO" scope="page"/>
<jsp:setProperty name="comment" property="cmtContent"/>

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
 	String userID = null;
	CommentDAO cmtDAO = CommentDAO.getInstance();

 	if(session.getAttribute("userID") != null){
 		userID = (String) session.getAttribute("userID");
 	}	
 	if(userID == null){
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
 		script.println("location.href = 'loginPopUp'");
 		script.println("</script>");
 	} 
 	else{
	 	int boardID = 0; 
	 	if (request.getParameter("boardID") != null){
	 		boardID = Integer.parseInt(request.getParameter("boardID"));
	 	}
	 	if (boardID == 0){
	 		PrintWriter script = response.getWriter();
	 		script.println("<script>");
	 		script.println("alert('유효하지 않은 글입니다.')");
	 		script.println("history.back()");
	 		script.println("</script>");
	 	}
 		if (comment.getCmtContent() == null){
	 		PrintWriter script = response.getWriter();
	 		script.println("<script>");
	 		script.println("alert('댓글 내용을 입력하세요.')");
	 		script.println("history.back()");
	 		script.println("</script>");
	 	} else {
	 		int result = cmtDAO.write(comment.getCmtContent(), userID, boardID);
	 		if (result == -1){
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('댓글 쓰기에 실패했습니다.')");
		 		script.println("history.back()");
		 		script.println("</script>");
		 	}
	 		else{
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('댓글이 작성되었습니다.')");
                script.println("location.href='view?boardID="+boardID+"'");
                script.println("</script>");
             }
	 	}
	 }
 %>
</body>
</html>