<%@page import="org.apache.tomcat.jni.Directory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<jsp:useBean id="board" class="board.BoardVO" scope="page"/>
<jsp:setProperty property="boardTitle" name="board"/>
<jsp:setProperty property="boardContent" name="board"/>
<jsp:setProperty property="boardCategory" name="board"/>

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
		}else{
			if(board.getBoardTitle() == null || board.getBoardContent() == null || board.getBoardCategory() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('정보를 모두 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");
				
				}else{
					BoardDAO boardDAO = new BoardDAO();
					int result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent(), board.getBoardCategory(), board.getViewCount(), board.getHeartCount());
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('작성이 완료되었습니다.')");
						script.println("location.href='mainPage.jsp'");
						script.println("</script>");
					}
					
					
				}
			
			
		}
		
	%>
	
	
</body>
</html>