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
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
			script.println("</script>");
		}
		int boardID=0;
		if(request.getParameter("boardID")!=null){
		boardID=Integer.parseInt(request.getParameter("boardID"));
		}
		if(boardID == 0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		BoardDAO boardDAO = new BoardDAO();
		HeartDAO heartDAO = new HeartDAO();
		//해당 게시판에 이미 하트를 눌렀는지 확인한다.
		HeartDTO heartvo = new HeartDAO().getHeartVOByUser(userID, boardID);
		//하트를 눌렀으면
		if(heartvo != null){
			//하트 취소 메서드 실행
			int delete = heartDAO.delete(userID, boardID);
			if(delete == 1){ //하트가 정상적으로 취소
				delete = boardDAO.heartDelete(boardID);
				if(delete == 1){ //하트 갯수가 정상적으로 -1
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("location.href= \'view?boardID="+boardID+"\'"); //해당 글로 다시 돌아가기
					script.println("</script>");
				}
			}else{
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		//하트를 누르지 않았으면
		}else{
			int result = heartDAO.heart(userID,boardID);
			if(result == 1){ //heart에 데이터가 정상적으로 들어갔으면
				result = boardDAO.heart(boardID); //board에 heartCount + 1
				if(result == 1){ //둘 다 정상적으로 실행됐으면
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('추천이 완료되었습니다.')");
					script.println("location.href= \'view?boardID="+boardID+"\'"); //해당 글로 다시 돌아가기
					script.println("</script>");
				}
			}else{
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
		
%>
</body>
</html>