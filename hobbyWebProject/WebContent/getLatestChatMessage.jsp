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
		int groupID = 0;
		String lastUserID = null;
		ChatDAO chat = new ChatDAO();
		
		if(request.getParameter("groupID") != null || request.getParameter("groupID") != "0"){
			groupID = Integer.parseInt(request.getParameter("groupID"));
		}
		ArrayList<ChatDTO> chatlist = new ChatDAO().getChatList(groupID);
		if (!chatlist.isEmpty()) {
		    ChatDTO lastChat = chatlist.get(chatlist.size() - 1);
		    lastUserID = lastChat.getUserID();
		    //System.out.println(lastUserID);
			script.print(lastUserID);
		    script.flush();
		}else {
			script.print("empty");
	        script.flush();
		}
	
	%>
</body>
</html>