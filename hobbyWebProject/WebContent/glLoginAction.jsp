<%@page import="user.PwEncrypt"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.UserDTO" scope="page"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
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
	String userID = (String)request.getParameter("id");
	String userName = (String)request.getParameter("username");
	String userEmail = (String)request.getParameter("email");
	System.out.println(userID);
	System.out.println(userName);
	System.out.println(userEmail);
%>
<h2>구글 로그인</h2>
<h3>id : <%=userID %></h3>
<h3>name : <%=userName %></h3>
<h3>email : <%=userEmail %></h3>
</body>
</html>