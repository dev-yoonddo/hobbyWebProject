<%@page import="sun.font.Script"%>
<%@page import="jdk.nashorn.internal.objects.annotations.ScriptClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>


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
		script.println("alert('로그인을 하세요')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
			}
			int boardID = 0;
			if(request.getParameter("boardID") != null){
		boardID = Integer.parseInt(request.getParameter("boardID"));
			}
			if(boardID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("history.back()");
		script.println("</script>");
			}
			BoardDTO board = new BoardDAO().getBoardVO(boardID);
			if(!userID.equals(board.getUserID()) && !userID.equals("admin")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
			}else{
		BoardDAO boardDAO = new BoardDAO();
		int result = boardDAO.delete(boardID);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제가 완료되었습니다.')");
			script.println("location.href = 'community.jsp'");
			script.println("</script>");
		}
		
			}
	%>
</body>
</html>