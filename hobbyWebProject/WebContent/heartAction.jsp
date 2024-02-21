<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="board.BoardDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="heart.HeartDAO" %>
<%@ page import="heart.HeartDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>

<body>
<%
	PrintWriter script = response.getWriter();
	String userID = null;
	int boardID=0;
	BoardDAO boardDAO = BoardDAO.getInstance();
	HeartDAO heartDAO = HeartDAO.getInstance();
	
	if(session.getAttribute("userID")!=null){
		userID = (String)session.getAttribute("userID");
	}
	if(request.getParameter("boardID")!=null){
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}

	if(userID == null){
		script.print("userID null");
		script.flush();
	}
	if(boardID == 0){
		script.print("boardID null");
		script.flush();
	}
	//해당 게시판에 이미 하트를 눌렀는지 확인한다.
	HeartDTO heartvo = heartDAO.getHeartVOByUser(userID, boardID);
	//하트를 눌렀으면
	if(heartvo != null){
		//하트 취소 메서드 실행
		int delete = heartDAO.delete(userID, boardID);
		if(delete == 1){ //하트가 정상적으로 취소
			delete = boardDAO.heartDelete(boardID);
			if(delete == 1){ //하트 갯수가 정상적으로 -1
				script.print("heart delete");
				script.flush();
			}
		}else{
			script.print("database error");
			script.flush();
		}
	//하트를 누르지 않았으면
	}else{
		int result = heartDAO.heart(userID,boardID);
		if(result == 1){ //heart에 데이터가 정상적으로 들어갔으면
			result = boardDAO.heart(boardID); //board에 heartCount + 1
			if(result == 1){ //둘 다 정상적으로 실행됐으면
				script.print("heart ok");
				script.flush();
			}
		}else{
			script.print("database error");
			script.flush();
		}
	}
	script.close();
%>
</body>
</html>