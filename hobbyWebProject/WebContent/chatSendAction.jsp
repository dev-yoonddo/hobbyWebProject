<%@page import="chat.ChatDAO"%>
<%@page import="location.LocationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="location.LocationDAO"%>
<%@page import="java.io.PrintWriter"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	PrintWriter script = response.getWriter();
	String userID = null;
	int groupID = 0;
	String chatContent = null;
	ChatDAO chatDAO = new ChatDAO();
	
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(request.getParameter("groupID") != null || request.getParameter("groupID") != "0"){
		groupID = Integer.parseInt(request.getParameter("groupID"));
	}
	if(request.getParameter("content") != null){
		chatContent = request.getParameter("content");
	}

	if(userID == null){
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
		script.println("</script>");
	}
	if(userID == null){
		script.print("null userID");
        script.flush();
	}else if(groupID == 0 || chatContent == null){
		script.print("Information Error");
        script.flush();
	}else if(chatContent.equals("")){
		script.print("none");
        script.flush();
	}else{
		int result = chatDAO.send(userID, groupID, chatContent);
		if(result == -1){
			script.print("Database Error");
	        script.flush();
		}else{
			script.print("chat send successfully");
	        script.flush();
		}
	}
		
%>