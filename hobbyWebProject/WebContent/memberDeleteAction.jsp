<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@page import="sun.font.Script"%>
<%@page import="jdk.nashorn.internal.objects.annotations.ScriptClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		script.println("location.href='loginPopUp.jsp'");
		script.println("</script>");
		}
		int groupID=0;
		if(request.getParameter("groupID")!=null)
			groupID=Integer.parseInt(request.getParameter("groupID"));
			
		String memberID = request.getParameter("memberID");
			
		if(memberID == null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 멤버입니다.')");
		script.println("history.back()");
		script.println("</script>");
		}
			
		MemberDTO member = new MemberDAO().getMemberVO(memberID);
		if(!userID.equals(member.getUserID())){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
			} else{
				MemberDAO memberDAO = new MemberDAO();
				int result = memberDAO.delete(memberID);
				if(result == -1){//데이터 베이스 오류
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('탈퇴에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('탈퇴에 성공했습니다.')");
					script.println("history.back()");	
					script.println("</script>");
				}
			}
	%>
</body>
</html>