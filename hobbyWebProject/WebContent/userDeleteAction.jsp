<%@page import="comment.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="comment.CommentDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}else{
			UserDAO userDAO=new UserDAO();
			BoardDAO boardDAO=new BoardDAO();
			CommentDAO commentDAO=new CommentDAO();
			
			List<BoardDTO> boardVOList = boardDAO.getDelBoardVOByUserID(userID);
		    for (BoardDTO boardVO: boardVOList) {
		        boardVO.setBoardAvailable(0);
		        boardDAO.updateBoardVO(boardVO);
		        // Delete associated comments for each board
		        List<CommentDTO> commentVOList = commentDAO.getDelCommentVOByUserID(boardVO.getUserID());
		        for (CommentDTO commentVO: commentVOList) {
		            commentVO.setCmtAvailable(0);
		            commentDAO.updateCommentVO(commentVO);
		        }
		    }
		    
			int result=userDAO.delete(userID);
			if(result == -1){//데이터 베이스 오류
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('회원탈퇴에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
			}
			else{
		session.invalidate();
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('회원탈퇴에 성공했습니다.')");
		script.println("location.href='mainPage.jsp'");
		script.println("</script>");
		
			}
		}
	%>
</body>
</html>