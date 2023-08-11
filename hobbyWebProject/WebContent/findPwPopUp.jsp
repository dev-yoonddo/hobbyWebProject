<%@page import="user.UserDTO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.UserDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="group.GroupDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
}
GroupDAO groupDAO = new GroupDAO();
MemberDAO memberDAO = new MemberDAO();

UserDTO user=new UserDAO().getUserVO(userID); //유저 정보 가져오기

ArrayList<MemberDTO> mbList = memberDAO.getListByUser(userID); //유저가 가입한 그룹 리스트 가져오기
%>
	<div>
		비밀번호를 찾을 그룹명을 선택하세요
		
	</div>
	<div>
	</div>
</body>
</html>