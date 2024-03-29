<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="comment.CommentDTO" %>
<%@ page import="comment.CommentDAO" %>
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
		String userID = null;
		int boardID=0;
		int cmtID = 0;
 		CommentDAO cmtDAO = CommentDAO.getInstance();

		if(session.getAttribute("userID") != null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='loginPopUp'");
			script.println("</script>");
		}
		if(request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if(request.getParameter("cmtID")!=null){
			cmtID = Integer.parseInt(request.getParameter("cmtID"));
		}
		if(cmtID == 0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}			
		CommentDTO comment = cmtDAO.getCommentVO(cmtID);
		if(!userID.equals(comment.getUserID())){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			int result=cmtDAO.delete(cmtID);
			if(result == -1){//데이터 베이스 오류
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("location.href=document.referrer;");
				script.println("</script>");
			}
		}
	%>
</body>
</html>