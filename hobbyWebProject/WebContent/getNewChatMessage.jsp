<%@page import="java.io.PrintWriter"%>
<%@page import="chat.ChatDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="chat.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		PrintWriter script = response.getWriter();
		int groupID = 0;

		if(request.getParameter("groupID") != null || request.getParameter("groupID") != "0"){
			groupID = Integer.parseInt(request.getParameter("groupID"));
		}
		//새로운 채팅이 입력됐는지 비교하기 위해 해당 그룹의 채팅갯수를 구한다.
		ArrayList<ChatDTO> chatlist = ChatDAO.getInstance().getChatList(groupID);
		int chatSize = chatlist.size();

    	script.print(chatSize);
	    script.flush();
	%>
