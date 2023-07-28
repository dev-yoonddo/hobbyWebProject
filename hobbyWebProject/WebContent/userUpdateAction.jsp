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
		PrintWriter script=response.getWriter();
		String userID = null;
		if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
		}
		//로그아웃 됐을때
		if(userID == null){
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login'");
		script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		UserDTO user = new UserDAO().getUserVO(userID);
		//test계정에서 비밀번호 수정요청이 들어올때
		if(userID.equals("test")){
			script.println("<script>");
			script.println("alert('테스트 계정은 비밀번호를 수정할 수 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			//test 계정이 아니면 정보 수정 가능
			if(request.getParameter("userID")==null||request.getParameter("userName")==null
			||request.getParameter("userBirth")==null||request.getParameter("userPhone")==null||request.getParameter("userPassword")==null){
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
			}
			//입력받은 비밀번호를 암호화 한 뒤 기존 비밀와 비교 후 같으면 이미 사용중인 비밀번호라고 알림
			String encryptPW = pwEncrypt.encoding(request.getParameter("userPassword"));
			if(encryptPW.equals(user.getUserPassword())){
				script.println("<script>");
				script.println("alert('이미 사용중인 비밀번호입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				int result=userDAO.update(userID,request.getParameter("userName"),request.getParameter("userBirth"),request.getParameter("userPhone"),encryptPW);
				if(result == -1){//데이터 베이스 오류가 날 때
					script.println("<script>");
					script.println("alert('회원정보 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					script.println("<script>");
					script.println("alert('회원정보 수정이 완료되었습니다.')");
					script.println("location.href='userUpdate'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>