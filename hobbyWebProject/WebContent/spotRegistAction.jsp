<%@page import="location.LocationDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Regist</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	String userID = null;
	String spotName = null;
	String address = null;
	double latitude = 0;
	double longitude = 0;
	LocationDAO locDAO = new LocationDAO();
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(request.getParameter("name") != null){
		spotName = request.getParameter("name");
	}
	if(request.getParameter("address") != null){
		address = request.getParameter("adr");
	}
	if(request.getParameter("latitude") != null){
		latitude = Double.parseDouble(request.getParameter("latitude"));
	}
	if(request.getParameter("longitude") != null){
		longitude = Double.parseDouble(request.getParameter("longitude"));
	}
	if(userID == null){
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
		script.println("</script>");
	}
	else if(userID == null || spotName == null || address == null || latitude == 0 || longitude == 0){
		script.println("<script>");
		script.println("alert('Information Error')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		int result = locDAO.regist(userID, spotName, address, latitude, longitude);
		if(result == -1){
			script.println("<script>");
			script.println("alert('데이터베이스 오류')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			script.println("<script>");
			script.println("alert('스팟 등록 완료')");
			script.println("history.back()");
			script.println("</script>");
		}
	}
		
%>
</body>
</html>