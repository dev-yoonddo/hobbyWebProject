<%@page import="user.UserDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@page import="user.PwEncrypt"%>
<%@page import="org.apache.tomcat.jni.Directory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="user.UserDAO" %>
<%@ page import="event.EventDAO" %>
<%@ page import="event.EventDTO" %>

<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="user" class="user.UserDTO" scope="page"/>
<jsp:setProperty property="userPhone" name="user"/>
<jsp:setProperty property="userPassword" name="user"/>

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
			script.println("alert('로그인이 필요합니다')");
			script.println("self.close()");
			script.println("opener.location.href='login'");
			script.println("</script>");
		}
		//groupID 가져오기
		int groupID = 0;
		if(request.getParameter("groupID") != null){
			groupID = Integer.parseInt(request.getParameter("groupID"));
		}
		GroupDAO group = new GroupDAO();
		int groupActive = group.getGroupVO(groupID).getGroupAvailable();
		if(groupActive == 0){
			script.println("<script>");
			script.println("alert('비활동중인 그룹입니다.')");
			script.println("self.close()");
			script.println("</script>");
		}else{
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = userDAO.getUserVO(userID);
		//회원 비밀번호를 가져온다.
		String userPW = userDTO.getUserPassword();
		//암호화된 비밀번호와 비교하기 위해 입력한 비밀번호 + salt키를 암호화 한 값을 가져온다.
		HashMap<String,String> pw = PwEncrypt.encoding(user.getUserPassword(), userDTO.getUserSalt());
		String inputPW = pw.get("hash");
		//회원 전화번호를 가져온다.
		String userPhone = userDAO.getUserVO(userID).getUserPhone();
		//입력한 정보 검사
		if(user.getUserPhone() == null) {
			script.println("<script>");
			script.println("alert('핸드폰 번호를 입력해주세요')");
			script.println("history.back()");
			script.println("</script>");
		}else if(!userPhone.equals(user.getUserPhone())){ //회원 전화번호가 일치하는지 검사
			script.println("<script>");
			script.println("alert('핸드폰 번호가 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else if(user.getUserPassword() == null) {
			script.println("<script>");
			script.println("alert('회원 비밀번호를 입력해주세요')");
			script.println("history.back()");
			script.println("</script>");
		}else if(!userPW.equals(inputPW)) { //회원 비밀번호가 일치하는지 검사
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			String groupPW = group.getGroupVO(groupID).getGroupPassword();
			//모든 검사 완료시 비밀번호 알려주기
			script.println("<script>");
			script.println("alert('비밀번호는 " + groupPW + " 입니다.')");
			script.println("self.close()");
			//부모창 페이지 이동하기
			script.println("opener.location.href='groupPage'");
			script.println("</script>");
			}	
		}
	%>
	
	
</body>
</html>