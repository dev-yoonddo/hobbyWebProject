<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>


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
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
			script.println("</script>");
		}
		int groupID = 0;
		if(request.getParameter("groupID")!=null){
			groupID=Integer.parseInt(request.getParameter("groupID"));
		}
		//memberID값 가져오기
		String memberID = request.getParameter("memberID");

		MemberDAO memberDAO = new MemberDAO();
		int result = memberDAO.delete(memberID, userID, groupID);
		if(result == -1){//데이터 베이스 오류
			script.println("<script>");
			script.println("alert('탈퇴에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			script.println("<script>");
			script.println("alert('탈퇴 완료되었습니다.')");
			script.println("location.href='groupPage'");	
			script.println("</script>");
		}
			
	%>
</body>
</html>