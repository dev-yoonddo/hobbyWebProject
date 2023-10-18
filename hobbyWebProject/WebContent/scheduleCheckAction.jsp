<%@page import="jdk.nashorn.internal.ir.debug.JSONWriter"%>
<%@page import="jdk.nashorn.internal.parser.JSONParser"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="schedule.ScheduleDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<%
PrintWriter script = response.getWriter();
String userID = null;
String spotName = null;
int skedMonth = 0;
int skedDay = 0;
ScheduleDAO skedDAO = new ScheduleDAO();
if(session.getAttribute("userID") != null){
	userID = (String)session.getAttribute("userID");
}
if(request.getParameter("spot") != null){
	spotName = request.getParameter("spot");
}
if(request.getParameter("month") != null){
	skedMonth = Integer.parseInt(request.getParameter("month"));
}
if(request.getParameter("day") != null){
	skedDay = Integer.parseInt(request.getParameter("day"));
}

ArrayList<ScheduleDTO> skedlist = skedDAO.getScheduleListByTime(spotName, skedMonth, skedDay);
String[] value = new String[skedlist.size()];

if(skedlist.size() > 0){
		for(int i=0; i < skedlist.size(); i++){
			value[i] = skedlist.get(i).getUserID()+" : "+skedlist.get(i).getSkedContent()+"<br>";
			System.out.println(value[i]);
			script.print(value[i]);
		}
	}
		script.flush();
		script.close();
	

%>
</body>
</html>