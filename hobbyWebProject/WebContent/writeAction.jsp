<%@page import="org.apache.tomcat.jni.Directory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/error/errorPage.jsp"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>

<jsp:useBean id="board" class="board.BoardDTO" scope="page"/>
<jsp:setProperty property="boardTitle" name="board"/>
<jsp:setProperty property="boardContent" name="board"/>
<jsp:setProperty property="boardCategory" name="board"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
			script.println("</script>");
		}else{
			if(board.getBoardTitle() == null || board.getBoardContent() == null || board.getBoardCategory() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('정보를 모두 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");				
			}else{
				int result = 0;
				String notice = null;
				BoardDAO boardDAO = new BoardDAO();
				//관리자 계정으로 공지사항 등록시
				notice = request.getParameter("notice");
				if(userID.equals("manager") && notice.equals("NOTICE")){
					result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent(), notice , board.getViewCount(), board.getHeartCount());
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다')");
						script.println("history.back()");
						script.println("</script>");
					}
					if((board.getBoardCategory()).equals("0")){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('카테고리를 선택해주세요')");
						script.println("history.back()");
						script.println("</script>");
					}
					else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('작성이 완료되었습니다')");
						script.println("location.href='community'");
						script.println("</script>");
					}
				//관리자가 아니거나 공지사항이 아닐시
				}if(notice.equals("NULL") || notice == null){
					result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent(), board.getBoardCategory(), board.getViewCount(), board.getHeartCount());
					//result > 0 이면 성공적으로 글쓰기 완료
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다')");
						script.println("history.back()");
						script.println("</script>");
					}
					if((board.getBoardCategory()).equals("0")){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('카테고리를 선택해주세요')");
						script.println("history.back()");
						script.println("</script>");
					}
					else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('작성이 완료되었습니다')");
						script.println("location.href='searchPage?searchField2="+board.getBoardCategory()+"'");
						script.println("</script>");
					}
				}
			}
		}
		
	%>
	
	
</body>
</html>