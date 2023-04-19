<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		String userID = null;
			if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
			}
			if(userID == null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
			}
			UserDTO user = new UserDAO().getUserVO(userID);
		if(request.getParameter("userID")==null||request.getParameter("userName")==null
		||request.getParameter("userBirth")==null||request.getParameter("userPhone")==null||request.getParameter("userPassword")==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
			}else{
		UserDAO userDAO=new UserDAO();//하나의 인스턴스
		int result=userDAO.update(userID,request.getParameter("userName"),request.getParameter("userBirth"),request.getParameter("userPhone"),request.getParameter("userPassword"));
		if(result == -1){//데이터 베이스 오류가 날 때
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보 수정에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보 수정이 완료되었습니다.')");
			script.println("location.href='mainPage.jsp'");
			script.println("</script>");
		}
			
			}
	%>
</body>
</html>