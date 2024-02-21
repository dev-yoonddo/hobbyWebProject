<%@page import="sun.security.jca.GetInstance.Instance"%>
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
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
</head>
<body>
	<%
		UserDAO userDAO = UserDAO.getInstance();
		String code = null;
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}

		//userEmail 파라미터값 가져오기
		if(request.getParameter("code") != null){
			code = request.getParameter("code");
		}
		//이미 인증을 했으면 알림창띄우기
		if(userDAO.getUserEmailChecked(userID) == true){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 인증이 된 계정입니다.')");
			script.println("self.close()");
			script.println("</script>");
		}else{
			//암호화 된 회원이메일과 코드를 비교해 일치하면 인증완료하기
			String userEmail = userDAO.getUserEmail(userID);
			String userEmailHash = userDAO.getUserVO(userID).getUserEmailHash();
			boolean isRight = (userEmailHash.equals(code)) ? true : false;
			if(isRight == false){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 코드입니다.')");
				script.println("history.back()");
				script.println("</script>");	
			}else{
				//인증이 되면 userEmailChecked == true로 변경하기
				boolean result = userDAO.setUserEmailChecked(userID);
				if(result == false){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('데이터베이스 오류')");
					script.println("self.close()");
					script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('인증에 성공했습니다. 홈페이지에서 인증 완료를 해주세요')");
					script.println("self.close()");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>