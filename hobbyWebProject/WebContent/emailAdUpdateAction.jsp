<%@page import="group.GroupDTO"%>
<%@page import="user.UserDTO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.UserDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="group.GroupDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="user.UserDTO" scope="page" />
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
	PrintWriter script = response.getWriter();
	String userID = null;
	UserDAO userDAO = new UserDAO();
	UserDTO userVO=new UserDAO().getUserVO(userID); //유저 정보 가져오기
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
		script.println("</script>");
	}
	if(user.getUserEmail() == null){
		script.println("<script>");
		script.println("alert('이메일 주소를 입력하세요.')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		//이미 사용중인 이메일인지 검사
		ArrayList<UserDTO> list = userDAO.getEmailList();
		int emailcheck = 0;
		for (int i = 0; i < list.size(); i++) {		
			//데이터베이스에 이미 같은 이메일이 존재하면 emailcheck++
			if(list.get(i).getUserEmail().equals(user.getUserEmail())){
				emailcheck++;
			}
		}
		if(emailcheck > 0){
			script.println("<script>");
			script.println("alert('이미 사용중인 이메일입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			int result = userDAO.userEmailUpdate(userID, user.getUserEmail());
			if(result == -1){
				script.println("<script>");
				script.println("alert('오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				script.println("<script>");
				//팝업을 닫고 부모창 페이지 새로고침
				script.println("self.close()");
				script.println("opener.location.reload()");
				script.println("</script>");
			}
		}
	}
	
%>
</body>
</html>