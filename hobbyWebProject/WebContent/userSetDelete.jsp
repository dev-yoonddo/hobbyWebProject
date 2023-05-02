<%@page import="comment.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="comment.CommentDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="board.BoardDAO" scope="page"/>
<jsp:useBean id="comment" class="comment.CommentDAO" scope="page"/>
<jsp:useBean id="group" class="group.GroupDAO" scope="page"/>
<jsp:useBean id="member" class="member.MemberDAO" scope="page"/>

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
			script.println("alert('삭제할 목록을 선택하세요.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
		    int result = 0;
		
			    if(deleteField.equals("board")) {
			        result = board.deleteByUser(userID);
			    } else if(deleteField.equals("cmt")) {
			        result = comment.deleteByUser(userID);
			    } else if(deleteField.equals("group")) {
			        result = group.deleteByUser(userID);
			    } else if(deleteField.equals("mb")) {
			        result = member.deleteByUser(userID);
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