<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDTO" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TT PIZZA</title>
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
		script.println("location.href='loginPopUp.jsp'");
		script.println("</script>");
		}
		int boardID=0;
		if(request.getParameter("boardID")!=null)
		boardID=Integer.parseInt(request.getParameter("boardID"));
			
		int cmtID=0;
		if(request.getParameter("cmtID")!=null)
		cmtID=Integer.parseInt(request.getParameter("cmtID"));
			
		if(cmtID==0){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 댓글입니다.')");
		script.println("history.back()");
		script.println("</script>");
		}
			
		CommentDTO comment = new CommentDAO().getCommentVO(cmtID);
		if(!userID.equals(comment.getUserID())){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
			} else{
				CommentDAO commentDAO=new CommentDAO();
				int result=commentDAO.delete(cmtID);
				if(result == -1){//데이터 베이스 오류
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("location.href=document.referrer;");
					script.println("</script>");
				}
			}
	%>
</body>
</html>