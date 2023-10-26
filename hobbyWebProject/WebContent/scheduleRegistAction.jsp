<%@page import="schedule.ScheduleDAO"%>
<%@page import="group.GroupDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<body>
	<%
		PrintWriter script = response.getWriter();
		String userID = null;
		String spotName = null;
		String content = null;
		int skedMonth = 0; 
		int skedDay = 0;
		String skedContent = null;
		ScheduleDAO skedDAO = new ScheduleDAO();

		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (request.getParameter("spot") != null){
	 		spotName = request.getParameter("spot");
	 	}
		if (request.getParameter("content") != null){
	 		skedContent = request.getParameter("content");
	 	}
		if (request.getParameter("month") != null){
	 		skedMonth = Integer.parseInt(request.getParameter("month"));
	 	}
		if (request.getParameter("day") != null){
	 		skedDay = Integer.parseInt(request.getParameter("day"));
	 	}

		if(userID == null){
			script.print("null");
		    script.flush();
		}else{
		 	if (skedContent == null || skedContent == ""){
		 		script.print("info error");
		 	    script.flush();
		 	}else{
				int result = skedDAO.registSchedule(userID, spotName, skedMonth, skedDay, skedContent);
				if(result > 0){
					script.print("ok");
				    script.flush();
				}else{
					script.print("database error");
				    script.flush();
				}
		 	}
		}	
	    script.close();
	%>
</body>
</html>