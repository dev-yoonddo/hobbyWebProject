<%@page import="java.io.PrintWriter"%>
<%@page import="chat.ChatDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="chat.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		String lastUserID = null;
		int groupID = 0;
		String userID = null;
		ChatDAO chat = new ChatDAO();
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(request.getParameter("groupID") != null || request.getParameter("groupID") != "0"){
			groupID = Integer.parseInt(request.getParameter("groupID"));
		}
		ArrayList<ChatDTO> chatlist = new ChatDAO().getChatList(groupID);
		//getChatList 메서드에서 DESC한 리스트를 가져왔기 때문에 0번째 인덱스 (== 제일 마지막 데이터)를 가져온다.
	    ChatDTO lastChat = chatlist.get(0);
		if (!chatlist.isEmpty()) {
		    lastUserID = lastChat.getUserID();
		    //System.out.println(lastUserID);
		    if(userID != null && lastUserID != null){
		    	if(lastUserID.equals(userID)){
					script.print("match");
				    script.flush();
			    }else{
			    	script.print("mismatch");
				    script.flush();
				}
		    }else{
		    	script.print("no user");
			    script.flush();
		    }
		}else {
			script.print("empty");
	        script.flush();
		}
	
	%>
</body>
</html>