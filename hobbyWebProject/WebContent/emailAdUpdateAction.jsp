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
<title>EMAIL ADRESS</title>
<link rel="icon" href="image/logo.png">
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="css/member.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css2?family=Bruno+Ace&family=Gowun+Dodum&family=IBM+Plex+Sans+KR:wght@300;600&family=Jua&family=Merriweather:wght@700&family=Nanum+Gothic&family=Nanum+Gothic+Coding&family=Noto+Sans+KR:wght@400&family=Noto+Serif+KR:wght@200&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
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
	for (int i = 0; i < list.size(); i++) {
		String email = list.get(i).getUserEmail();
		if(email.equals(user.getUserEmail())){
			script.println("<script>");
			script.println("alert('이미 사용중인 이메일입니다.')");
			script.println("history.back()");
			script.println("</script>");
			break;
		}else{
			int result = userDAO.userEmailUpdate(userID, user.getUserEmail());
			if(result == -1){
				script.println("<script>");
				script.println("alert('오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				script.println("<script>");
				script.println("self.close()");
				//부모창 페이지 새로고침
				script.println("opener.location.reload()");
				script.println("</script>");
			}
		}
	}
}
%>
</body>
</html>