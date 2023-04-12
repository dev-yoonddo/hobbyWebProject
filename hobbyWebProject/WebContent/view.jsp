<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentVO"%>
<%@page import="user.UserDAO"%>
<%@page import="user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="board.BoardVO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="css/board.css?after">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/checkPW.js"></script>
</head>
<Style>
section{
	height: auto;
	display: flex;
	margin: 0;
	padding: 0;
	padding-top: 100px;
	margin-bottom: 150px;
	font-family: 'Nanum Gothic Coding', monospace;
}
.board-container{
	width: 1000px;
	margin: 0 auto;	
}
thead{
	color: #ffffff;
}

.btn-black{
	float: right;
}
.btn-black span{
	padding: 5px;
	margin: 0;
	height: 35px;
}
.td{
	border-right-style: solid;
	border-right-width: 0.3mm;
	border-bottom: none;
	border-color: #aaaaaa;
}

.btn-black {
  position: relative;
  display: inline-block;
  width: 100px; height: 50px;
  background-color: transparent;
  border: none; 
  cursor: pointer;
  margin: 0;
 
}
.btn-black span {         
  position: relative;
  display: inline-block;
  font-size: 12pt;
  font-weight: bold;
  font-family: 'Nanum Gothic Coding', monospace;
  letter-spacing: 2px;
  width: 100%;
  padding: 10px;
  transition: 0.5s;
  
  color: #ffffff;
  background-color: #000000;
  border: 1px solid #000000;
}

.btn-black::before {
  background-color: #000000;
}

.btn-black span:hover {
  color: #000000;
  background-color: #ffffff;
}
</style>
<body>
<%
//userID 가져오기
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
int cmtID = 0;
if(request.getParameter("cmtID")!=null)
	cmtID = Integer.parseInt(request.getParameter("cmtID"));
//boardID 가져오기
int boardID = 0;
if(request.getParameter("boardID") != null){
	boardID = Integer.parseInt(request.getParameter("boardID"));
}

//글이 유효하다면 1이상의 숫자가 반환되기 때문에 boardID == 0일때  글이 유효하지 않다는 알림창 띄우기
if(boardID == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 글입니다.')");
	script.println("location.href = 'customerPage.jsp'");
	script.println("</script>");
}

BoardVO board = new BoardDAO().getBoardVO(boardID);
CommentVO comment = new CommentDAO().getCommentVO(cmtID);
%>

<!-- header -->
<header>
<div id="header" class="de-active">
	<nav class="navbar">
		<nav class="navbar_left">
			<div class="navbar_logo">
				<a href="mainPage.jsp" id="mainlogo" >TOGETHER</a>
			</div>
			<ul class="navbar_menu" style="float: left;">
				<li><a href="community.jsp" id ="menu">COMMUNITY</a></li>
				<li><a href="qnaPage.jsp" id="menu">Q & A</a></li>
			</ul>
		</nav>
			<ul class="navbar_login" >
				<%
					if(userID == null){
				%>	
				<li><a href="login.jsp">LOGIN</a></li>
				<li><a href="join.jsp">JOIN</a></li>
				<%
					}else{
				%>
				<li><a href="userUpdate.jsp"><i class="fa-solid fa-gear"></i></a></li>
				<li><a href="logout.jsp">LOGOUT</a></li>
				<%
					}
				%>
			</ul>
			<a onclick="toggleAct()" class="navbar_toggleBtn">
				<i class="fa-solid fa-bars"></i>
			</a>
	</nav>
</div>
</header>
<!-- header -->

<!-- section -->
<section>
	<div class="board-container">
		<div class="inquiry">
			<div class="row"><br>
				<h4 style="font-weight: bold; color: #646464;">문의 글</h4><br><br>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #464646; text-align: center;">문의한 글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="td" style="width:20%;">글 제목</td>
							<td colspan="2"><%= board.getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
						<tr>
							<td class="td">작성자</td>
							<td colspan="2"><%= board.getUserID() %></td>
						</tr>
						<tr>
							<td class="td">작성일자</td>
							<td colspan="2"><%= board.getBoardDate().substring(0 ,11) + board.getBoardDate().substring(11, 13) + "시" + board.getBoardDate().substring(14, 16) + "분" %></td>
						</tr>
						<tr>
							<td class="td">내용</td>
							<!-- 특수문자 처리 -->
							<td colspan="2" style="min-height: 200px; text-align: left;"><%= board.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
						<tr>
							<td class="td">조회수</td>
							<td colspan="2"><%= board.getViewCount()+1 %></td>
						</tr>
						<tr>
							<td class="td">하트</td>
							<td colspan="2"><%= board.getHeartCount() %></td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<button type="button" class="btn-black" onclick="location.href='customerPage.jsp'"><span>목록</span></button>
			<% 
				if(userID != null){
					if(userID.equals("admin")){
			%>
			
						<button type="button" class="btn-black" id="cmt-write-btn" onclick="cmtAction()"><span>답변쓰기</span></button>
					
			<%
					}else if(userID.equals(board.getUserID())){
			%>
						<button type="button" class="btn-black" onclick="location.href='update.jsp?boardID=<%= boardID%>'"><span>수정</span></button>
						<button type="button" class="btn-black" id="btn-del" onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='deleteAction.jsp?boardID=<%= boardID%>'}"><span>삭제</span></button>
						<button type="button" class="btn-black" id="cmt-write-btn" onclick="cmtAction()"><span>답변쓰기</span></button>
			<% 
					}
				}
			%>
			</div>
			
			 
			<div class="cmt-view">
	         	<div class="row">
	         		<h5 style="font-size: 15pt; color: #646464; float: left;">답변<br></h5><hr style="width: 1000px;">
	                <%
	                   CommentDAO cmtDAO = new CommentDAO();
	                   ArrayList<CommentVO> list = cmtDAO.getList(boardID);
	                   for(int i=0; i<list.size(); i++){
	                %>
	               	<table class="table table-striped" style="table-layout: fixed;">
	               		<tr style="">
	               			<td align="left"><%= list.get(i).getUserID() %></td>
	               			<td align="right"><%= list.get(i).getCmtDate().substring(0,11)+list.get(i).getCmtDate().substring(11,13)+"시"+list.get(i).getCmtDate().substring(14,16)+"분" %></td>
	               		</tr>
	               	</table>
	               	<table style="margin-bottom: 20px;">
	               		<tr>
	               			<td><%= list.get(i).getCmtContent() %></td>
	               		</tr>
		           	</table>
            			<%
            				if(userID != null && userID.equals(list.get(i).getUserID())){
            			%>
         				<div style="float: right;">
            			<button type="button" class="btn-black" id="cmt-btn" onclick="if(confirm('답글을 삭제하시겠습니까?')){location.href='commentDeleteAction.jsp?boardID=<%= boardID%>&cmtID=<%=list.get(i).getCmtID() %>'}"><span>삭제</span></button>
            			</div>
            			<%
            				}
            			%>
	                  <%
	                     }
	                  %>
	         	</div>  
	      	</div>
			<!-- 답변쓰기 버튼을 눌렀을 때만 답변쓰기 섹션이 나타나도록 설정 -->
			<div id="cmt-write" style="display: none;">
		      <div class="row">
		          <form method="post" action="commentAction.jsp?boardID=<%= boardID %>">
			          <table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd">
			             <tbody>
			                <tr>
			                   <td align="left"><%=userID %></td>
			                </tr>
			                <tr>
			                   <td><input type="text" class="form-control" placeholder="답변 쓰기" name="cmtContent" maxlength="300"></td>
			                </tr>
			             </tbody>
			          </table>
			      <button type="submit" class="btn-black" id="cmt-btn"><span>완료</span></button>
			      </form>
		      </div>
		   </div>
   </div>
</section>
<!-- section -->

<!-- footer -->
<footer><hr>

   	
</footer>
<!-- footer -->
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	
</body>
</html>