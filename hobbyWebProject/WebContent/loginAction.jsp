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
	PrintWriter script = response.getWriter();
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null){
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'mainPage'");
		script.println("</script>");
	}
	//로그인시 입력한 패스워드를 암호화 한 뒤 데이터베이스 값과 비교한다.  
	int result = UserDAO.getInstance().login(user.getUserID(), user.getUserPassword(), user.getUserAvailable());
	if(result == 2){
		script.println("<script>");
		script.println("alert('정보를 모두 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result == 1){
		session.setAttribute("userID", user.getUserID());;
		script.println("<script>");
		script.println("alert('로그인 되었습니다.')");
		script.println("location.href = 'mainPage'");
		script.println("</script>");
	}
	else if(result == 0){
		script.println("<script>");
		script.println("alert('비밀번호를 다시 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result == -1){
		script.println("<script>");
		script.println("alert('아이디가 존재하지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result == -2){
		script.println("<script>");
		script.println("alert('데이터베이스 오류')");
		script.println("history.back()");
		script.println("</script>");
	}
	/*else if(result == -3){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('회원 정보가 없습니다.')");
	script.println("history.back()");
	script.println("</script>");
	}*/
%>

</body>
</html>