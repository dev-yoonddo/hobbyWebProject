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
<meta name="viewport" content="width = device-width , initial-scale = 1, user-scalable = no, maximum-scale = 1 , minimum-scale = 1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="icon" href="image/logo.png">
</head>
<body>
	<%			
		PrintWriter script = response.getWriter();
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("window.open('loginPopUp', 'Login', 'width=500, height=550, top=50%, left=50%')");
			script.println("</script>");
		}else{
			//writeAction과 같이 파일 저장 경로를 각각 지정해준다.
			String path = null;
			String jspPath = application.getRealPath("/fileupload/");
			String awsPath = "/home/tomcat/apache-tomcat-8.5.88/webapps/fileupload/";
			if(jspPath.startsWith("C")){ //경로가 C로 시작하면 JSP에서 파일 업로드를 의미하기 때문에
				path = jspPath; //path에 JSP경로를 저장하고
			}else{ //경로가 C로 시작하지 않으면 배포 서버에서 파일 업로드를 의미하기 때문에
				path = awsPath; //tomcat 경로를 저장한다.
			}
			
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
			String notice = multi.getParameter("notice");
			String filename = multi.getOriginalFileName("fileupload");
			String fileRealname = multi.getFilesystemName("fileupload");
			
			//빈칸이 있으면 알림창을 띄운다.
			if(title.length() == 0){
				script.println("<script>");
				script.println("alert('제목을 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");				
			}else if(content.length() == 0){
				script.println("<script>");
				script.println("alert('내용을 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");				
			}else if(category.length() == 0 || category.equals("0")){
				script.println("<script>");
				script.println("alert('카테고리를 선택해주세요')");
				script.println("history.back()");
				script.println("</script>");				
			}//전달받은 파일이 있으면
			else if (filename != null && !filename.endsWith(".zip") && !filename.endsWith(".ZIP") && !filename.endsWith(".pdf") && !filename.endsWith(".PDF") && !filename.endsWith(".jpg") && !filename.endsWith(".JPG") && !filename.endsWith(".jpeg") && !filename.endsWith(".JPEG") && !filename.endsWith(".png") && !filename.endsWith(".PNG")) {
				script.println("<script>");
				script.println("alert('" + filename +  "은(는) 업로드 할 수 없는 형식의 파일입니다.\\nzip, pdf, jpg, png파일만 업로드가 가능합니다.')");
				script.println("history.back()");
				script.println("</script>");
			//file.delete();
			}else{
				int result = 0;
				BoardDAO boardDAO = BoardDAO.getInstance();
					result = boardDAO.update(boardID, title, content, category , filename, fileRealname);
					if(result == -1 || result == -2){
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다')");
						script.println("history.back()");
						script.println("</script>");
					}
					else{
						script.println("<script>");
						script.println("alert('수정이 완료되었습니다')");
						script.println("location.href='view?boardID="+boardID+"'");
						script.println("</script>");
					}
				}
			}
				
		
	%>
</body>
</html>