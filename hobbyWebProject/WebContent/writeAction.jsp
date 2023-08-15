<%@page import="file.FileDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
			//getRealPath를 사용해 각 경로에 저장해도 되지만 배포서버에서는 프로젝트 내부 파일에 저장하면 업데이트시 파일들이 삭제되기 때문에
			//방지하기 위해 (.../hobbyWebProject/fileupload)경로를 삭제하고 FileZilla에서 외부에 경로를 따로 생성한다.
			String path = null;
			String jspPath = application.getRealPath("/fileupload/");
			String awsPath = "/home/tomcat/apache-tomcat-8.5.88/webapps/fileupload/";
			if(jspPath.startsWith("C")){ //경로가 C로 시작하면 JSP에서 파일 업로드를 의미하기 때문에
				path = jspPath; //path에 JSP경로를 저장하고
			}else{ //경로가 C로 시작하지 않으면 배포 프로젝트에서 파일 업로드를 의미하기 때문에
				path = awsPath; //tomcat 경로를 저장한다.
			}
			//String path = "C:/gookbiProject/JSP/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp2/wtpwebapps/hobbyWebProject/fileupload/";
			//String path="/home/tomcat/apache-tomcat-8.5.88/webapps/fileupload/"; //프로젝트 외부에 폴더를 만들어 이곳에 저장한다.
			//String path = application.getRealPath("/fileupload/"); ->fileupload폴더가 위치한 경로를 찾는다.
			//System.out.print(path); -> jsp에서 파일 업로드 했을 때와 배포 후 파일 업로드 했을때의 경로가 다름.
			MultipartRequest multi = new MultipartRequest(
				request,
				path,
				10 * 2048 * 2048,
				"UTF-8",
				new DefaultFileRenamePolicy()
			);
			//form type = multipart일땐 MultipartRequest로 파라미터 값을 가져온다.
			String title = multi.getParameter("boardTitle");
			String content = multi.getParameter("boardContent");
			String category = multi.getParameter("boardCategory");
			String notice = multi.getParameter("notice");

			//오리지널 파일명 = 유저가 업로드한 파일명
			String filename = multi.getOriginalFileName("fileupload");
			//실제 서버에 저장된 파일명
			String fileRealname = multi.getFilesystemName("fileupload");
//			File file = new File(path + filename);
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
				}
				if (!filename.endsWith(".jar") && !filename.endsWith(".JAR") && !filename.endsWith(".zip") && !filename.endsWith(".ZIP") && !filename.endsWith(".pdf") && !filename.endsWith(".PDF") && !filename.endsWith(".jpg") && !filename.endsWith(".JPG") && !filename.endsWith(".png") && !filename.endsWith(".PNG")) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('" + filename +  "은(는) 업로드 할 수 없는 형식의 파일입니다.\\njar, zip, pdf, jpg, png파일만 업로드가 가능합니다.')");
					script.println("history.back()");
					script.println("</script>");
//					file.delete();
				}else{
					int result = 0;
					BoardDAO boardDAO = new BoardDAO();
					//관리자 계정으로 공지사항 등록시
//					notice = request.getParameter("notice");
					if(userID.equals("manager") && notice.equals("NOTICE")){
						result = boardDAO.write(title, userID, content, notice , filename, fileRealname);
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
					}if(notice.equals("NULL")){
						result = boardDAO.write(title, userID, content, category , filename, fileRealname);
						//result > 0 이면 성공적으로 글쓰기 완료
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
							script.println("location.href='searchPage?searchField2="+category+"'");
							script.println("</script>");
						}
					}
				}
			
		}
		
	%>
	
	
</body>
</html>