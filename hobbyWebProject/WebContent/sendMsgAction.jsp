<%@page import="java.io.PrintWriter"%>
<%@page import="message.MessageDAO"%>
<%@page import="message.MessageDTO"%>
<%@page import="group.GroupDAO"%>
<%@page import="group.GroupDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="message" class="message.MessageDTO" scope="page" />
<jsp:setProperty name="message" property="msgTitle" />
<jsp:setProperty name="message" property="msgContent" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		GroupDAO groupDAO = GroupDAO.getInstance();
		MessageDAO msgDAO = MessageDAO.getInstance();
		
		String userID = null;
		int groupID = 0; 
		int msgID = 0;
		//userID를 가져온다.
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		//그룹아이디와 답장하기 할 때 필요한 메시지아이디를 가져온다.
		if(request.getParameter("groupID") != null){
			groupID = Integer.parseInt(request.getParameter("groupID"));
		}
		if(request.getParameter("msgID") != null){
			msgID = Integer.parseInt(request.getParameter("msgID"));
		}
		//userUpdate.jsp 에서 관리자에게 문의하기 클릭시 qna=y 를 가져온다.
		String qna = null;
		if(request.getParameter("qna") != null){
			qna = (request.getParameter("qna"));
		}
		//비로그인
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%')");
			script.println("window.close()");
			script.println("</script>");
		}else{//로그인
			//빈칸이 있으면
			if(message.getMsgTitle() == null || message.getMsgContent() == null) {
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				//qna = y값을 받으면 유저가 관리자에게 문의 하는것을 의미한다.
				if(qna != null && qna.equals("y")){
					String toUserID = "manager";
					int result = msgDAO.send(userID, toUserID , 0 , message.getMsgTitle(), message.getMsgContent());
					if(result == -1){ //데이터베이스 오류
						script.println("<script>");
						script.println("alert('데이터베이스 오류')");
						script.println("history.back()");
						script.println("</script>");
					}
					else {
						script.println("<script>");
						script.println("alert('전송이 완료되었습니다.')");
						script.println("location.href = 'userUpdate'");					
						script.println("self.close()");
						script.println("</script>");
					}
				}else{ //qna = y를 받지않음
					//groupID = 0이고 userID = manager이면 관리자가 문의에 답변 전송함을 의미한다.
					if(groupID == 0 && userID.equals("manager")){
						int result = msgDAO.send(userID, msgDAO.getMsgVO(msgID).getUserID(), groupID, message.getMsgTitle(), message.getMsgContent());
						if(result == -1){ //데이터베이스 오류
							script.println("<script>");
							script.println("alert('데이터베이스 오류')");
							script.println("history.back()");
							script.println("</script>");
						}
						else {
							script.println("<script>");
							script.println("alert('답변 전송이 완료되었습니다.')");
							script.println("window.open('viewMsgListPopUp?groupID=" + groupID + "','MESSAGE', 'width=450, height=450, top=50%, left=50%')");
							script.println("</script>");
						}
					}else{ //문의하기 또는 답변하기가 아니면 유저간의 메시지 주고받기를 의미한다.
						//유저가 gRoupView.jsp에서 그룹생성자에게 메시지를 보낼때(msgID생성전)는 groupID를 가져오고 답장할때(msgID생성후)는 msgID를 가져온다.
						//따라서 각각 send()메서드에 넘겨주는 값이 다르고 전송 완료 후 이동하는 페이지도 다르게 만든다.
						int active = groupDAO.getGroupVO(groupID).getGroupAvailable();
						if(active == 0){
							script.println("<script>");
							script.println("alert('비활동중인 그룹은 메시지 전송이 불가합니다.')");
							script.println("history.back()");
							script.println("</script>");
						}else{
							if(msgID == 0){ //groupView.jsp에서 메시지 전송 버튼을 눌렀을 때
								//비활동중인 그룹일 때 메시지를 보낼 수 없다.
								//msgID = 0이면 groupID를 받아오기 때문에 groupID로 그룹활동여부를 가져온다.
								int result = msgDAO.send(userID, groupDAO.getGroupVO(groupID).getUserID(), groupID, message.getMsgTitle(), message.getMsgContent());
								if(result == -1){ //데이터베이스 오류
									script.println("<script>");
									script.println("alert('데이터베이스 오류')");
									script.println("history.back()");
									script.println("</script>");
								}
								else {
									script.println("<script>");
									script.println("alert('메시지 전송이 완료되었습니다.')");
									script.println("location.href = 'groupView?groupID=" + groupID +"'");
									script.println("</script>");
								}
							}else{
								//답장을 할 땐 msgID를 받아오기 때문에 msgID로 groupID를 구해 그룹활동여부를 구한다.
								int result = msgDAO.send(userID, msgDAO.getMsgVO(msgID).getUserID(), groupID, message.getMsgTitle(), message.getMsgContent());
								if(result == -1){ //데이터베이스 오류
									script.println("<script>");
									script.println("alert('데이터베이스 오류')");
									script.println("history.back()");
									script.println("</script>");
								}
								else { //답장 보내기 완료시 메시지 리스트로 돌아가기
									script.println("<script>");
									script.println("alert('메시지 전송이 완료되었습니다.')");
									script.println("window.open('viewMsgListPopUp?groupID=" + groupID + "','MESSAGE', 'width=450, height=450, top=50%, left=50%')");
									script.println("</script>");
								}
							}
						}
					}
				}
			}
		}
	%>
</body>
</html>