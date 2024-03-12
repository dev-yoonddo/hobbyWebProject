<%@page import="crew.CrewDTO"%>
<%@page import="crew.CrewDAO"%>
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
	String spotLeader = null;
	String spotName = null;
	String address = null;

	LocationDAO locDAO = LocationDAO.getInstance();
	CrewDAO crew = CrewDAO.getInstance();

	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(request.getParameter("leader") != null){
		spotLeader = request.getParameter("leader");
	}
	if(request.getParameter("name") != null){
		spotName = request.getParameter("name");
	}
//	if(request.getParameter("address") != null){
//		address = request.getParameter("address");
//	}

	if(userID == null){
		script.print("null");
	    script.flush();
	}else if(spotName == null){
		script.print("Information Error");
        script.flush();
	}else{
		//해당 스팟 리더를 만든 유저면 바로 접속
		if(spotLeader.equals(userID)){
			script.print("leaders");
	        script.flush();
		}else{
			//userID와 spotName이 일치하는(이미가입한) 리스트 가져오기
			ArrayList<CrewDTO> list = crew.getJoinedList(userID,spotName);
			if(list.size() > 0){ //이미 가입한 유저면 바로 접속
				script.print("exist");
		        script.flush();
			}else{
				//그룹 가입 메서드 실행
				int result = crew.joinCrew(userID, spotName);
				if(result > 0){
					int result2 = locDAO.spotJoin(spotName);
					if(result2 > 0){
						script.print("successfully");
				        script.flush();
					}else{
						script.print("database error");
				        script.flush();
					}
				}else{
					script.print("join Error");
			        script.flush();
				}
			}
		}
	}
    script.close();

		
%>
</body>
</html>