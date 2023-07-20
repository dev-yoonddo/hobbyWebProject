<%@page import="user.pwEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
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
		//로그아웃 됐을때
		if(userID == null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
		}
		//test계정에서 비밀번호 수정요청이 들어올때
		if(userID.equals("test")){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('테스트 계정은 비밀번호를 수정할 수 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			//test 계정이 아니면
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
				int result=userDAO.update(userID,request.getParameter("userName"),request.getParameter("userBirth"),request.getParameter("userPhone"),pwEncrypt.encoding(request.getParameter("userPassword")));
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
		}
	%>
</body>
</html>