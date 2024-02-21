<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.apache.tomcat.jni.Directory"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>

<jsp:useBean id="group" class="group.GroupDTO" scope="page"/>
<jsp:setProperty name="group" property="groupNotice"/>


<!DOCTYPE html>
<html>
<body>
 <%
 
 	PrintWriter script = response.getWriter();
	int groupID = 0;
	String noticeContent = null;
	GroupDAO groupDAO = GroupDAO.getInstance();
	
	if(request.getParameter("groupID") != null || request.getParameter("groupID") != "0"){
		groupID = Integer.parseInt(request.getParameter("groupID"));
	}
	if(request.getParameter("content") != null){
		noticeContent = request.getParameter("content");
	}
 	if (groupID == 0){
 		script.print("group error");
	        script.flush();
 	}
 	else{
 		if(noticeContent == null || noticeContent.equals("")) {
 			script.print("none");
 	        script.flush();
		}else{
 			int result = 0;
			
			result = groupDAO.noticeUpdate(groupID, noticeContent);
			System.out.print(result);
			if(result > 0){
				script.print("success");
	 	        script.flush();
			}else{
				script.print("database error");
	 	        script.flush();
			}
		}
 	}
 	
 %>
</body>
</html>