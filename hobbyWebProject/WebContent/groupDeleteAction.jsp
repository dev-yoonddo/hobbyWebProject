<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
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
		GroupDAO groupDAO = GroupDAO.getInstance();

		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'loginPopUp'");
			script.println("</script>");
		}
		int groupID = 0;
		if(request.getParameter("groupID") != null){
			groupID = Integer.parseInt(request.getParameter("groupID"));
		}
		if(groupID == 0){
			script.println("<script>");
			script.println("alert('유효하지 않은 그룹입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		GroupDTO group = groupDAO.getGroupVO(groupID);
		if(!userID.equals(group.getUserID()) && !userID.equals("admin")){
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			int result = groupDAO.delete(groupID);
			if(result == -1){
				script.println("<script>");
				script.println("alert('그룹 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				script.println("<script>");
				script.println("alert('삭제가 완료되었습니다.')");
				script.println("location.href = 'groupPage'");
				script.println("</script>");
			}
	
		}
	%>
</body>
</html>