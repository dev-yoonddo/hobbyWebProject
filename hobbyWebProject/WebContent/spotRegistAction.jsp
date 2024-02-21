<%@page import="location.LocationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="location.LocationDAO"%>
<%@page import="java.io.PrintWriter"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<%
	PrintWriter script = response.getWriter();
	String userID = null;
	String spotName = null;
	String address = null;
	double latitude = 0;
	double longitude = 0;
	String spName = null;
	String spAd = null;
	
	LocationDAO locDAO = LocationDAO.getInstance();
	ArrayList<LocationDTO> locationlist = locDAO.getNameAdList();
	
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(request.getParameter("name") != null){
		spotName = request.getParameter("name");
	}
	if(request.getParameter("address") != null){
		address = request.getParameter("address");
	}
	if(request.getParameter("latitude") != null){
		latitude = Double.parseDouble(request.getParameter("latitude"));
	}
	if(request.getParameter("longitude") != null){
		longitude = Double.parseDouble(request.getParameter("longitude"));
	}

	if(userID == null){
		script.print("null userID");
        script.flush();
	}
	if(spotName == null || address == null || latitude == 0 || longitude == 0){
		script.print("Information Error");
        script.flush();
	}else{
		int nameExist = 0;
		int adExist = 0;
		for(LocationDTO loc : locationlist){			
			if(spotName.equals(loc.getSpotName())){ //데이터베이스에 이미 같은 이름이 존재하면
				nameExist++; //exist + 1
			}
			else if(address.equals(loc.getAddress())){ //데이터베이스에 이미 같은 주소가 존재하면
				adExist++; //exist + 1
			}
		}
		if(nameExist == 0 && adExist == 0){ //데이터베이스에 같은 이름과 주소가 존재하지 않으면 스팟 저장
			int result = locDAO.regist(userID, spotName, address, latitude, longitude);
			if(result == -1){
				script.print("Database Error");
		        script.flush();
			}else{
				script.print("Spot saved successfully");
		        script.flush();
			}
		}else{
			if(nameExist != 0){
				script.print("Spot name already exists");
		        script.flush();
			}else if(adExist != 0){
				script.print("Spot address already exists");
		        script.flush();
			}
		}		
	}
	script.close();
%>
</body>
</html>