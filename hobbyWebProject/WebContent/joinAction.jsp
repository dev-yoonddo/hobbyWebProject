<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="user.UserDTO"%>
<%@page import="user.PwEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.UserDTO" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userBirth" />
<jsp:setProperty name="user" property="userPhone" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
</head>
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
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
		|| user.getUserBirth() == null || user.getUserPhone() == null || user.getUserEmail() == null) {
			script.println("<script>");
			script.println("alert('정보를 모두 입력해주세요')");
			script.println("history.back()");
			script.println("</script>");
			
		}else{
			UserDAO userDAO = UserDAO.getInstance();
			//이미 사용중인 이메일인지 검사
			int emailOK = 0;
			ArrayList<UserDTO> list = userDAO.getEmailList();
			for (UserDTO i : list) {
				String email = i.getUserEmail();
				if(email.equals(user.getUserEmail())){
					script.println("<script>");
					script.println("alert('이미 사용중인 이메일입니다.')");
					script.println("history.back()");
					script.println("</script>");
					emailOK = 1;
					break;
				}
			}
			if(emailOK == 0){
				int result = userDAO.join(user);
				if(result == -1){
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디입니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					script.println("<script>");
					script.println("alert('회원가입이 완료되었습니다.')");	
					script.println("location.href = 'login'");
					script.println("</script>");
				}
			}
		}
	%>
</html>