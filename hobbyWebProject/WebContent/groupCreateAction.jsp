<%@page import="java.io.PrintWriter"%>
<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>

<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="group" class="group.GroupDTO" scope="page" />
<jsp:setProperty name="group" property="groupName" />
<jsp:setProperty name="group" property="groupPassword" />
<jsp:setProperty name="group" property="groupNoP" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
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
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = 'loginPopUp.jsp'");
			script.println("</script>");
		}else{
			if(group.getGroupName() == null || group.getGroupPassword() == null
			|| group.getGroupNoP() == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('그룹정보를 모두 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");
				
			}else{
				GroupDAO groupDAO = new GroupDAO();
				int result = groupDAO.createGroup(group.getGroupName(),group.getGroupPassword(), userID, group.getGroupNoP());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('그룹 생성이 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				if(group.getGroupNoP() == 0){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('그룹 인원을 입력해주세요')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					session.setAttribute("groupID", group.getGroupID());
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('그룹 생성이 완료되었습니다.')");
					script.println("location.href = 'groupPage.jsp'");
					script.println("</script>");
				}
			
			}
		}
		
	%>
</body>
</html>