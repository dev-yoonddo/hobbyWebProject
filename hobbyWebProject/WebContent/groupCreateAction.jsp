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
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
			script.println("</script>");
		}else{
			if(group.getGroupName() == null || group.getGroupPassword() == null
			|| group.getGroupNoP() == 0) {
				script.println("<script>");
				script.println("alert('그룹정보를 모두 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");
				
			}else{
				GroupDAO groupDAO = new GroupDAO();
				int result = groupDAO.createGroup(group.getGroupName(),group.getGroupPassword(), userID, group.getGroupNoP());
				if(result == -1){
					script.println("<script>");
					script.println("alert('그룹 생성이 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					//session.setAttribute("groupID", group.getGroupID());
					script.println("<script>");
					script.println("alert('그룹 생성이 완료되었습니다.')");
					script.println("location.href = 'groupPage'");
					script.println("</script>");
				}
			
			}
		}
		
	%>
</body>
</html>