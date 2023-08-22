<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>

<jsp:useBean id="group" class="group.GroupDTO" scope="page"/>
<jsp:setProperty name="group" property="groupNotice"/>


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
		script.println("alert('로그인을 하세요.')");
 		script.println("location.href = 'loginPopUp'");
 		script.println("</script>");
 	}else{
	 	//groupID 가져오기
	 	int groupID = 0;
	 	if (request.getParameter("groupID") != null){
	 		groupID = Integer.parseInt(request.getParameter("groupID"));
	 	}
		if (groupID == 0){
	 		script.println("<script>");
	 		script.println("alert('유효하지 않은 그룹입니다.')");
	 		script.println("history.back()");
	 		script.println("</script>");
	 	}
	 	if(group.getGroupNotice() == null) {
			script.println("<script>");
			script.println("alert('공지 내용을 입력해주세요')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			GroupDAO groupDAO = new GroupDAO();
			int result = groupDAO.notice(group.getGroupNotice(), groupID ,userID);
			//System.out.print(result);
			if(result == -1){
				script.println("<script>");
				script.println("alert('작성 실패')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				script.println("<script>");
				script.println("alert('작성이 완료되었습니다.')");
				script.println("location.href='groupView?groupID='"+ groupID + "'");
				script.println("</script>");
			}
			
	 	}
 	}
 %>
</body>
</html>