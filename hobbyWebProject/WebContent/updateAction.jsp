<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="board" class="board.BoardDTO" scope="page"/>
<jsp:setProperty property="boardID" name="board"/>
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
			String path = "C:/gookbiProject/JSP/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp2/wtpwebapps/hobbyWebProject/fileupload/";
			MultipartRequest multi = new MultipartRequest(
				request,
				path,
				10 * 2048 * 2048,
				"UTF-8",
				new DefaultFileRenamePolicy()
			);
			//form type = multipart일땐 MultipartRequest로 파라미터 값을 가져온다.
			int boardID = Integer.parseInt(multi.getParameter("boardID"));
			String title = multi.getParameter("boardTitle");
			String content = multi.getParameter("boardContent");
			String category = multi.getParameter("boardCategory");
			//오리지널 파일명 = 유저가 업로드한 파일명
			String filename = multi.getOriginalFileName("fileupload");
			//실제 서버에 저장된 파일명
			String fileRealname = multi.getFilesystemName("fileupload");
			//File file = new File(path + filename);
			if(title == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목을 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");				
			}
			if(content == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");				
			}
			if(category == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('카테고리를 선택해주세요')");
				script.println("history.back()");
				script.println("</script>");				
			}if(filename != null){
				if (!filename.endsWith(".jar") && !filename.endsWith(".zip") && !filename.endsWith(".pdf") && !filename.endsWith(".jpg") && !filename.endsWith(".png")) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('" + filename +  "은(는) 업로드 할 수 없는 형식의 파일입니다.\\njar, zip, pdf, jpg, png파일만 업로드가 가능합니다.')");
					script.println("history.back()");
					script.println("</script>");
					//file.delete();
				}else{
					int result = 0;
					BoardDAO boardDAO = new BoardDAO();
						result = boardDAO.update(boardID, title, content, category , filename, fileRealname);
						if((category).equals("0")){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('카테고리를 선택해주세요')");
							script.println("history.back()");
							script.println("</script>");
						}
						else if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패했습니다')");
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
					}
			}
		}
				
		
	%>
</body>
</html>